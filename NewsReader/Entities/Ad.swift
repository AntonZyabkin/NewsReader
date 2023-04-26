import Foundation
import Fakery
import RxDataSources

let faker = Faker(locale: "ru")

typealias Ad = AdResponse
//struct Ad: Decodable {
//    struct Category: Decodable {
//        let title: String
//
//        static var placeholder: Category {
//            Category(title: faker.lorem.word())
//        }
//    }
//    struct Location: Decodable {
//        let area: String
//        let district: String?
//
//        static var placeholder: Location {
//            Location(area: "Russia", district: "Moscow region")
//        }
//
//    }
//
//    struct Price: Decodable {
//
//
//        enum Currency: String, Decodable {
//            case TRY, USD, EUR, RUB
//        }
//
//        let currency: Currency
//        let amount: Double
//    }
//
//    let id: UUID
//    let title: String
//    let description: String
//    var category: Category?
//    var location: Location?
//    var previewImageURL: URL?
//    let createdAt: Date
//    let price: Price?
//
//    static var placeholder: Ad {
//        Ad(
//            id: UUID(),
//            title: faker.address.county(),
//            description: faker.lorem.paragraphs(amount: 2),
//            category: Category.placeholder,
//            location: Location.placeholder,
//            previewImageURL: nil,
//            createdAt: Date(),
//            price: nil
//        )
//    }
//}
//
//extension Ad: IdentifiableType, Equatable  {
//
//    var identity: String {
//        id.uuidString
//    }
//
//    static func == (lhs: Ad, rhs: Ad) -> Bool {
//        lhs.title == rhs.title
//    }
//}
