//
//  CountryListPresenter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//
import UIKit

protocol CountryListPresenterInterface {
  func presentCountryLoading(response: CountryList.Loading.Response)
  func presentCountry(response: CountryList.CountryModel.Response)
  func presentSearchCountry(response: CountryList.SearchCountry.Response)
  func presentCountryLoadingError(response: CountryList.LoadingError.Response)
}

class CountryListPresenter: CountryListPresenterInterface {
  
  weak var viewController: CountryListViewControllerInterface!
  // MARK: - Presentation logic
  func presentCountryLoading(response: CountryList.Loading.Response) {
    let viewModel = CountryList.Loading.ViewModel(isShowing: false)
    viewController.displayLoading(viewModel: viewModel)
  }
  
  func presentCountry(response: CountryList.CountryModel.Response) {
    let viewModelisHidden = CountryList.Loading.ViewModel(isShowing: true)
       viewController.displayLoading(viewModel: viewModelisHidden)
  
    guard let country = response.country else {
      return
    }
    let viewModel = CountryList.CountryModel.ViewModel(country: country)
    viewController.displayCountry(viewModel: viewModel)
  }
  
  func presentSearchCountry(response: CountryList.SearchCountry.Response) {
    let viewModelisHidden = CountryList.Loading.ViewModel(isShowing: true)
    viewController.displayLoading(viewModel: viewModelisHidden)
    guard let country = response.country else { return }
    let viewModel = CountryList.SearchCountry.ViewModel(country: country)
    viewController.displaySearchCountry(viewModel: viewModel)
  }
  func presentCountryLoadingError(response: CountryList.LoadingError.Response) {
    viewController.displayLoadingError(viewModel: CountryList.LoadingError.ViewModel(urlError: response.urlError))
  }
}
