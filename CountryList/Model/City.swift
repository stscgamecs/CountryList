//
//  City.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import Foundation

// MARK: - City
struct City: Codable {
  var data: [DataCity]
}

// MARK: - DataCity
struct DataCity: Codable {
  let countryCode, countryName, capitalName: String
  
  enum CodingKeys: String, CodingKey {
    case countryCode = "country_code"
    case countryName = "country_name"
    case capitalName = "capital_name"
  }
}
