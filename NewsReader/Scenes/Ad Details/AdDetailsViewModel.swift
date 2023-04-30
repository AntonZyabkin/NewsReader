//
//  AdDetailsViewModel.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 25.04.2023.
//

import Foundation
import SwiftUI
import RxSwift

final class AdDetailsViewModel: ObservableObject {
    
    @Published var didLoadData = false
    @Published var sharedURL: URL = URL(string: "https://google.com/")!
    @Published var imageURLs: [URL] = []
    @Published var title = ""
    @Published var location: String?
    @Published var price = ""
    @Published var category = ""
    @Published var date = ""
    @Published var numberOfViews = ""
    @Published var descriptionText: String?
    @Published var sellerName = ""
    @Published var contacts: [Contact] = []
    
    private var disposeBag = DisposeBag()
    private var numberFormatter = NumberFormatter.priceNymberFormatter
    private var dateFormatter = DateFormatter.datAndTime
    private let routeTrigger: RouteTrigger<AdsRoute>
    

    
    init(adDetails: Observable<Ad>,
         routeTrigger: RouteTrigger<AdsRoute>) {
        self.routeTrigger = routeTrigger
        adDetails
            .asObservable()
            .startWith(.placeholder(currency: .TRY))
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [unowned self] ad in
                    assert(Thread.isMainThread)
                    self.update(from: ad)
                },
                onError: { error in
                    assert(Thread.isMainThread)
                    print(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    
    private func update(from ad: Ad) {
        sharedURL = ad.adsURL
        imageURLs = (ad.attachments?.map(\.link) ?? [])
        title = ad.title
        descriptionText = ad.description
        location = ad.location?.area ?? ""
        
        if let incomePrice = ad.price {
            numberFormatter.currencyCode = incomePrice.currency.rawValue
            numberFormatter.currencySymbol = incomePrice.currency.currencySymbol
            self.price = numberFormatter.string(for: incomePrice.amount) ?? "\(incomePrice.amount)"
        } else {
            self.price = "цена не указана"
        }
        category = ad.category?.title ?? ""
        date =  dateFormatter.string(from: ad.createdAt)
        contacts = ad.contacts ?? []
        didLoadData = true
    }
    
    func contactSeller(_ contact: Contact) {
        routeTrigger.trigger(.contact(contact))
    }
    
    static var placeholder: AdDetailsViewModel {
        AdDetailsViewModel(adDetails: .just(.placeholder(currency: .TRY)),
                           routeTrigger: .empty)
    }
}
