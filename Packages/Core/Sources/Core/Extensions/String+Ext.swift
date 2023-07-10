//
//  String+Ext.swift
//  
//
//  Created by Bartosz Wojtkowiak on 07/07/2023.
//

import Foundation

public extension String {
    
    var localized: String {
        return NSLocalizedString(self, bundle: .module, comment: "\(self)_comment")
    }
    
    func localized(_ args: [CVarArg]) -> String {
        return String(format: localized, args)
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}

