//
//  CountryListDetailInteractor.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailInteractorInterface {
  func getCity(request: CountryListDetail.getCity.Request)
  var model: DataCountry? { get set}
}

class CountryListDetailInteractor: CountryListDetailInteractorInterface {
  
  var presenter: CountryListDetailPresenterInterface!
  var worker: CountryListDetailWorker?
  var model: DataCountry?
  
  // MARK: - Business logic
  func getCity(request: CountryListDetail.getCity.Request) {
    let codeName = model!
    
    worker?.doSomeWork(sent: codeName.countryCode) { [weak self] in
      if case let Result.success(data) = $0 {
        let datamodel = data
        self!.model?.countryCode = datamodel.data[0].countryCode
        let response = CountryListDetail.getCity.Response(city: datamodel)
        self?.presenter.presentCity(response: response)
      }
      
    }
  }
}
