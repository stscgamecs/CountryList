//
//  CountryListWorker.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListStoreProtocol {
  func getDataCountry(_ completion: @escaping (Result<Country,Error>) -> Void)
}

class CountryListWorker {
  var store: CountryListStoreProtocol
  
  init(store: CountryListStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  func getStore(_ completion: @escaping (Result<Country,Error>) -> Void) {
    // NOTE: Do the work
    store.getDataCountry {
      completion($0)
    }
  }
}
