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
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        self?.modelCountry = data
        let response = CountryList.CountryModel.Response(country: self!.modelCountry!)
        self?.presenter.presentCountry(response: response)
      }else{
        print(ApiError.jsonError)
      }
      
    }
  }
  
  func getSearch(request: CountryList.SearchCountry.Request) {
    let textFieldSearch = request.searchCountry
    let model = modelCountry!.data.filter({ (data) -> Bool in
      return data.countryName.range(of: textFieldSearch) != nil
    })
    
    let response = CountryList.SearchCountry.Response(country: model)
    presenter.presentSearchCountry(response: response)
  }
}
