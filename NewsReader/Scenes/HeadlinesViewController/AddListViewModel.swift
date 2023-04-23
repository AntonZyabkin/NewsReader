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
    let nextPageLoadingTrigger = PublishRelay <Void>()
    
    private let service: AddsServiceType
    
    init(service: AddsServiceType) {
        self.service = service
       
        var page = 1
        
        addList = nextPageLoadingTrigger
            .flatMap{ () -> Single<[Ad]> in
                service.getadList(page: page, limit: 20)
            }
            .do(onNext: { _ in
                page += 1
            })
            .map { ads -> [AddsSection] in
                return [
                    AddsSection(
                        identity: UUID().uuidString,
                        items: ads.map(AdListItem.ad))
                ]
            }
            .asDriver(onErrorJustReturn: [])
            .startWith([AddsSection(identity: UUID().uuidString, items: [.activityIndicator])])
    }
    
}
