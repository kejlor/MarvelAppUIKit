//
//  String+Ext.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: [CVarArg]) -> String {
        return String(format: localized, args)
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
