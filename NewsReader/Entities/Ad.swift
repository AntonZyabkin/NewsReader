import Foundation
import Fakery


let faker = Faker(locale: "ru")


struct Ad: Decodable {
    struct Category: Decodable {
        let title: String
        
        static var placeholder: Category {
            Category(title: faker.lorem.word())
        }
    }
    
    let title: String
    let description: String
    var category: Category?
    
    
    static var placeholder: Ad {
        Ad(
            title: faker.address.county(),
            description: faker.lorem.paragraphs(amount: 2),
            category: Category.placeholder)
    }
}

