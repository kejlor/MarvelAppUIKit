//
//  SCImages.swift
//  
//
//  Created by Bartosz Wojtkowiak on 07/07/2023.
//

import UIKit

public func SCImage(named name: String) -> UIImage? {
  UIImage(named: name, in: Bundle.module, compatibleWith: nil)
}
