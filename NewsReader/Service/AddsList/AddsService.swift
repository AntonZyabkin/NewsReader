import Foundation
import RxSwift


protocol AddsServiceType {
    func getadList(page: Int, limit: Int) -> Single<[Ad]>
}


final class AddsService: AddsServiceType {
    func getadList(page: Int, limit: Int) -> Single<[Ad]> {
        
        let request = URLRequest(url: URL(string: "https://api.evetto.app/v1/ads")!)
        
        
        struct Response: Decodable {
            let data: [Ad]
        }
        
        
        return URLSession.shared
            .rx
            .data(request: request)
            .map { data in
                try! JSONDecoder().decode(Response.self, from: data)
            }
            .map(\.data)
            .asSingle()
    }
}
