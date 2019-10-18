//
//  CountryListDetailStore.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CountryListDetailStore: CountryListDetailStoreProtocol {
  func getDataCity(sent city_name:String,_ completion: @escaping (Result<DataCity, ApiError>) -> Void) {
    guard let todoEndpoint = URL(string: "http://13.229.64.101/noi/detail.php?code=\(city_name)") else {
      return
    }
    var request = URLRequest(url: todoEndpoint)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let _ = error {
        completion(.failure(ApiError.networkError))
      }
      else if let data = data, let response = response as? HTTPURLResponse {
        DispatchQueue.main.async {
          
          if response.statusCode == 200 {
            do {
              let countryList: City = try JSONDecoder().decode(City.self, from: data)
              completion(Result.success(countryList.data[0]))
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
