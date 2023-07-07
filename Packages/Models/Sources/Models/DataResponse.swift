//
//  DataResponse.swift
//  
//
//  Created by Bartosz Wojtkowiak on 07/07/2023.
//

import Foundation

public struct DataResponse: Decodable {
    public let count: Int
    public let results: [Comic]
}
