//
//  CountryListDetailWorker.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailStoreProtocol {
  func getDataCity(sent city_name:String ,_ completion: @escaping (Result<DataCity,ApiError>) -> Void)
}

class CountryListDetailWorker {
  var store: CountryListDetailStoreProtocol

  init(store: CountryListDetailStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  func getStore(sent city_name: String,_ completion: @escaping (Result<DataCity,ApiError>) -> Void) {
    store.getDataCity(sent: city_name) {
      completion($0)
    }
  }
}
