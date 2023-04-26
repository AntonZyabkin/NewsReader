//
//  DateFormatter.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 26.04.2023.
//

import Foundation

extension DateFormatter {
    
    static var datAndTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM y, HH:mm")
        return dateFormatter
        
    }()
}
