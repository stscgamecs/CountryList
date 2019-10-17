//
//  CountryListEntity.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation

// MARK: - Country
struct Country: Codable {
    let data: [DataCountry]
}

// MARK: - DataCountry
struct DataCountry: Codable {
  var countryCode, countryName: String
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case countryName = "country_name"
    }
}
