import Foundation

struct TopStoryHeadLine: Decodable {
    struct Media: Decodable {
        let url: String
    }
    
    let title: String
    let url: String
}

