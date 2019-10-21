//
//  CountryListStore.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
enum ApiError: Error {
  case success
  case jsonError
  case networkError
}

class CountryListStore: CountryListStoreProtocol {
  func getDataCountry(_ completion: @escaping (Result<Country,ApiError>) -> Void) {
    guard let url = URL(string: "http://13.229.64.101/noi/default.php") else {
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let _ = error {
        DispatchQueue.main.async {
        completion(.failure(ApiError.jsonError))
        }
      }
      else if let data = data, let response = response as? HTTPURLResponse {
        DispatchQueue.main.async {
          if response.statusCode == 200 {
            do {
              let countryList: Country = try JSONDecoder().decode(Country.self, from: data)
              completion(Result.success(countryList))
            } catch(let error) {
              print("parse JSON failed")
              print(error)
              completion(Result.failure(ApiError.jsonError))
            }
          }
        }
      }
    }
    task.resume()
  }
}
