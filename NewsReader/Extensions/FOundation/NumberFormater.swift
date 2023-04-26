//
//  NumberFormater.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 26.04.2023.
//

import Foundation

extension NumberFormatter {
    static var priceNymberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        
        return numberFormatter
    }()
}
