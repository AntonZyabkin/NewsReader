import Foundation
import RxSwift
import RxCocoa

final class HeadlinesViewModel {
    
    let headlines: Driver<[TopStoryHeadLine]>
    
    private let service: NewsServiceType
    
    init(service: NewsServiceType) {
        self.service = service
        
        headlines = service
            .getTopHeadLines()
            .asDriver(onErrorJustReturn: [])
    }
    
}
