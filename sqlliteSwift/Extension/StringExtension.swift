//
//  StringExtension.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 12/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func transformStringDate(fromDateFormat: String, toDateFormat: String) {
        let initialFormatter = DateFormatter()
        initialFormatter.dateFormat = fromDateFormat
        
        guard let initialDate = initialFormatter.date(from: self) else {
            print("Error in date string or in from format date")
            return
        }
        
        let resultFormat = DateFormatter()
        resultFormat.dateFormat = toDateFormat
        resultFormat.string(from: initialDate)
    }
    
}
