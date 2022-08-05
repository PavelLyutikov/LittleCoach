//
//  LocalizedString.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 11.05.2022.
//

import Foundation
import UIKit

class LocalizedString: UIView {
    
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
