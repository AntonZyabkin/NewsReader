//
//  NewsService.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 21.04.2023.
//

import Foundation
import RxSwift

protocol NewsServiceType {
    func getTopHeadLines() -> Observable<[TopStoryHeadLine]>
}


final class NewsService: NewsServiceType {
    func getTopHeadLines() -> Observable<[TopStoryHeadLine]> {
        return Observable.never()
    }
}
