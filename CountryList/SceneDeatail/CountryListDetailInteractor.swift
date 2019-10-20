//
//  CountryListDetailInteractor.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailInteractorInterface {
  func getCity(request: CountryListDetail.GetCity.Request)
  var model: DataCountry? { get set }
}

class CountryListDetailInteractor: CountryListDetailInteractorInterface {
  var presenter: CountryListDetailPresenterInterface!
  var worker: CountryListDetailWorker?
  var model: DataCountry?
  
  // MARK: - Business logic
  func getCity(request: CountryListDetail.GetCity.Request) {
    guard let codeName = model else{
      return
    }
    
    let response = CountryListDetail.Loding.Response(isShowing: false)
    presenter.presentLoadingCity(response: response)
    
    worker?.getStore(sent: codeName.countryCode) { [weak self] in
      if case let Result.success(data) = $0 {
        self?.model?.countryCode = data.countryCode
        let response = CountryListDetail.GetCity.Response(city: data)
        self?.presenter.presentCity(response: response)
      } else {
        print(ApiError.jsonError)
      }
    }
  }
}
