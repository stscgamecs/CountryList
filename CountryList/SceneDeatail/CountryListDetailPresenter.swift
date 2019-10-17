//
//  CountryListDetailPresenter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailPresenterInterface {
  func presentLoadingCity()
  func presentCity(response: CountryListDetail.GetCity.Response)
}

class CountryListDetailPresenter: CountryListDetailPresenterInterface {
  weak var viewController: CountryListDetailViewControllerInterface!

  // MARK: - Presentation logic
  func presentLoadingCity() {
    viewController.displayLodingCity(hidden: false)
  }
  
  func presentCity(response: CountryListDetail.GetCity.Response) {
     viewController.displayLodingCity(hidden: true)
    let responseCapitalName = response.city.data[0].capitalName
    let responseCountryName = response.city.data[0].countryName
    let viewModel = CountryListDetail.GetCity.ViewModel(countryName: responseCountryName, cityName: responseCapitalName)
    viewController.displayCity(viewModel: viewModel)
  }
}
