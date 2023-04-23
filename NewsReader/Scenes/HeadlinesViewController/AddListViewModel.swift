import Foundation
import RxSwift
import RxCocoa
import RxDataSources



extension Ad: IdentifiableType, Equatable  {

    var identity: some Hashable {
        title
    }
    
    static func == (lhs: Ad, rhs: Ad) -> Bool {
        lhs.title == rhs.title
    }
}

struct AddsSection {
    typealias Identity = String
    
    let identity: String
    var items: [Ad]
}

extension AddsSection: AnimatableSectionModelType {
    init(original: AddsSection, items: [Ad]) {
        self = original
        self.items = items
    }
}


final class AddListViewModel {
    
    let addList: Driver<[AddsSection]>
    
    private let service: AddsServiceType
    
    init(service: AddsServiceType) {
        self.service = service
       
        addList = service
            .getTopHeadLines()
            .map { adds in
                return [
                    AddsSection(
                        identity: UUID().uuidString,
                        items: adds)
                ]
            }
            .asDriver(onErrorJustReturn: [])
    }
    
}
