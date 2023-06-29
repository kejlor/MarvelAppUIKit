//
//  DataResponse.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 27/06/2023.
//

import Foundation

struct DataResponse: Decodable {
    let count: Int
    let results: [Comic]
}
