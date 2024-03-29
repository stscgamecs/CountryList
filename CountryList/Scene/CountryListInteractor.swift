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
    worker?.getStore { [weak self] result in
      switch result {
      case .success(let data):
        self?.modelCountry = data
        let response = CountryList.CountryModel.Response(country: self?.modelCountry)
        self?.presenter.presentCountry(response: response)
      case .failure(let data):
        let response = CountryList.LoadingError.Response(urlError: "\(data)")
        self?.presenter.presentCountryLoadingError(response: response)
      }
    }
  }
  
  func getSearch(request: CountryList.SearchCountry.Request) {
    guard let textFieldSearch = request.searchCountry else {
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
