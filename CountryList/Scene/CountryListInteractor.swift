//
//  CountryListInteractor.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListInteractorInterface {
  func getCountry(request: CountryList.CountryModel.Request)
  func getSearch(request: CountryList.SearchCountry.Request)
}

class CountryListInteractor: CountryListInteractorInterface {
  var presenter: CountryListPresenterInterface!
  var worker: CountryListWorker?
  var modelCountry: Country?
  
  // MARK: - Business logic
  func getCountry(request: CountryList.CountryModel.Request) {
    presenter.presentCountryLoading(response: CountryList.Loading.Response(isShowing: false))
    
    worker?.getStore { [weak self] in
      if case let Result.success(data) = $0 {
        self?.modelCountry = data
        let response = CountryList.CountryModel.Response(country: self?.modelCountry)
        self?.presenter.presentCountry(response: response)
      } else {
        print(ApiError.jsonError)
          let response = CountryList.CountryModel.Response(country: self?.modelCountry)
          self?.presenter.presentCountry(response: response)
      }
    }
  }
  
  func getSearch(request: CountryList.SearchCountry.Request) {
    guard let textFieldSearch = request.searchCountry else{
      return
    }
    
    if !(textFieldSearch.isEmpty) {
      let model = modelCountry?.data.filter({ (data) -> Bool in
        return data.countryName.range(of: textFieldSearch,options: .caseInsensitive) != nil
      })
      let response = CountryList.SearchCountry.Response(country: model)
      presenter.presentSearchCountry(response: response)
    } else {
      let response = CountryList.SearchCountry.Response(country: self.modelCountry?.data)
      presenter.presentSearchCountry(response: response)
    }
  }
}
