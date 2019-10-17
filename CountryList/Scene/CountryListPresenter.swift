//
//  CountryListPresenter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//
import UIKit

protocol CountryListPresenterInterface {
  func presentCountryLoading()
  func presentCountry(response: CountryList.CountryModel.Response)
  func presentSearchCountry(response: CountryList.SearchCountry.Response)
}

class CountryListPresenter: CountryListPresenterInterface {
  weak var viewController: CountryListViewControllerInterface!
  // MARK: - Presentation logic
  func presentCountryLoading() {
    viewController.displayLoading(hidden: false)
  }
  
  func presentCountry(response: CountryList.CountryModel.Response) {
     viewController.displayLoading(hidden: true)
    guard let country = response.country else { return  }
    let viewModel = CountryList.CountryModel.ViewModel(country: country)
    viewController.displayCountry(viewModel: viewModel)
  }
  
  func presentSearchCountry(response: CountryList.SearchCountry.Response) {
    viewController.displayLoading(hidden: true)
    guard let country = response.country else { return  }
    let viewModel = CountryList.SearchCountry.ViewModel(country: country)
    viewController.displaySearchCountry(viewModel: viewModel)
  }
}
