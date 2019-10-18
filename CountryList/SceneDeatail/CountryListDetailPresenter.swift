//
//  CountryListDetailPresenter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailPresenterInterface {
  func presentLoadingCity(response: CountryListDetail.Loding.Response)
  func presentCity(response: CountryListDetail.GetCity.Response)
}

class CountryListDetailPresenter: CountryListDetailPresenterInterface {
  weak var viewController: CountryListDetailViewControllerInterface!
  
  // MARK: - Presentation logic
  func presentLoadingCity(response: CountryListDetail.Loding.Response) {
    let viewModel = CountryListDetail.Loding.ViewModel(isShowing: false)
    viewController.displayLodingCity(viewModel: viewModel)
  }
  
  func presentCity(response: CountryListDetail.GetCity.Response) {
    let viewModelisHidden = CountryListDetail.Loding.ViewModel(isShowing: true)
    viewController.displayLodingCity(viewModel: viewModelisHidden)
    let responseCapitalName = response.city.capitalName
    let responseCountryName = response.city.countryName
    let viewModel = CountryListDetail.GetCity.ViewModel(countryName: responseCountryName, cityName: responseCapitalName)
    viewController.displayCity(viewModel: viewModel)
  }
}
