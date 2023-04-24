import Foundation
import RxSwift
import RxCocoa
import RxDataSources



struct AddsSection {
    typealias Identity = String
    
    let identity: String
    var items: [AddListViewModel.AdListItem]
}

extension AddsSection: AnimatableSectionModelType {
    init(original: AddsSection, items: [AddListViewModel.AdListItem]) {
        self = original
        self.items = items
    }
}


final class AddListViewModel {
    
    enum AdListItem: IdentifiableType, Equatable {
        case activityIndicator
        case ad(Ad)
        
        
        var identity: String {
            switch self {
            case .activityIndicator:
                return "activityIndicator"
            case .ad(let ad):
                return ad.identity
            }
        }
    }
    
    let addList: Driver<[AddsSection]>
    let nextPageTrigger = PublishRelay <Void>()
    let reloadPageTrigger = PublishRelay <Void>()

    private let service: AddsServiceType
    
    init(service: AddsServiceType) {
        self.service = service
        
        addList = AddListViewModel.createAdsListLoader(
            service: service,
            nextPageTrigger: nextPageTrigger.asObservable(),
            reloadTrigger: reloadPageTrigger.asObservable()
        )
    }
    
    
    static func createAdsListLoader(
        service: AddsServiceType,
        nextPageTrigger: Observable<Void>,
        reloadTrigger: Observable<Void>
    ) -> Driver<[AddsSection]> {
        
        var page = 0
        
        return Observable
            .merge(
                nextPageTrigger.do(onNext: { page += 1 }),
                reloadTrigger).do(onNext: { page = 1 })
                    
            .flatMap{ () -> Single<[Ad]> in
                service.getadList(page: page, limit: 20)
            }
            .startWith([]) //observable [Ad]
            .map { ads -> [AddsSection] in
                return [
                    AddsSection(
                        identity: UUID().uuidString,
                        items: ads.map(AdListItem.ad))
                ]
            }
            .asDriver(onErrorJustReturn: [])
        
        //оператор позволяет не перезаписывать старые элемента новыми, а суммировать их
            .scan([], accumulator: { old, new in
                let data: [AddsSection]
                if page == 1 {
                    data = new
                } else {
                    data = old.dropLast() + new
                }
                return data + [AddsSection(identity: UUID().uuidString, items: [.activityIndicator])]
            })
    }
}
