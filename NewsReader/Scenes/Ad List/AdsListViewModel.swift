import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import XCoordinator

private let PAGE_LIMIT = 20

struct AdsSection {
    let identity: String
    var items: [AdsListViewModel.AdListItem]
}

extension AdsSection: AnimatableSectionModelType {
    init(original: AdsSection, items: [AdsListViewModel.AdListItem]) {
        self = original
        self.items = items
    }
}

final class AdsListViewModel {
    
    enum AdListItem: IdentifiableType, Equatable {
        case activityIndicator
        case ad(AdsListItemViewModel)

        var identity: String {
            switch self {
            case .activityIndicator: return "activityIndicator"
            case .ad(let ad): return ad.identity
            }
        }
    }
    
    let ads: Driver<[AdsSection]>
    let nextPageTrigger = PublishRelay<Void>()
    let reloadingTrigger = PublishRelay<Void>()
    
    private let service: AdsServiceType
    private let routeTrigger: RouteTrigger<AdsRoute>
    
    init(
        service: AdsServiceType = appContext.adsService,
        routeTrigger: RouteTrigger<AdsRoute>
    ) {
        self.service = service
        ads = AdsListViewModel.createAdsLoader(
            service: service,
            nextPageTrigger: nextPageTrigger.asObservable(),
            reloadTrigger: reloadingTrigger.asObservable()
        )
        self.routeTrigger = routeTrigger
    }
    
    func navigateToAd(with item: AdsListItemViewModel) {
        routeTrigger.trigger(.details(item.id, item.title, ad: item.ad))
    }
    
    static func createAdsLoader(
        service: AdsServiceType,
        nextPageTrigger: Observable<Void>,
        reloadTrigger: Observable<Void>
    ) -> Driver<[AdsSection]> {
        var page = 0
        
        let dateFormatter = DateFormatter.datAndTime
        
        let numberFormatter = NumberFormatter.priceNymberFormatter
        
        return Observable
            .merge(
                nextPageTrigger.do(onNext: { page += 1 }),
                reloadTrigger.do(onNext: { page = 1 })
            )
            .flatMap { () -> Single<[Ad]> in
                service.getAdsList(page: page, limit: PAGE_LIMIT)
            }
            .startWith([])
            .map { ads -> [AdsSection] in
                return [
                    AdsSection(
                        identity: UUID().uuidString,
                        items: ads.map { ad in
                            AdListItem.ad(AdsListItemViewModel(
                                ad: ad,
                                formatDate: dateFormatter.string,
                                priceFormatter: numberFormatter
                            ))
                        }
                    )
                ]
            }
            .asDriver(onErrorJustReturn: [])
            .scan([], accumulator: { old, new in
                let data: [AdsSection]
                if page == 1 {
                    data = new
                } else {
                    data = old.dropLast() + new
                }
                return data + [AdsSection(identity: UUID().uuidString, items: [.activityIndicator])]
            })
    }
    
}
