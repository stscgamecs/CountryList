//
//  CountryListPresenter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//
import UIKit

protocol CountryListPresenterInterface {
  func presentCountry(response: CountryList.CountryModel.Response)
  func presentSearchCountry(response: CountryList.SearchCountry.Response)
}

class CountryListPresenter: CountryListPresenterInterface {
  weak var viewController: CountryListViewControllerInterface!
  
  // MARK: - Presentation logic
  func presentCountry(response: CountryList.CountryModel.Response) {
    let country = response.country
    let viewModel = CountryList.CountryModel.ViewModel(country: country)
    viewController.displayCountry(viewModel: viewModel)
  }
  
  func presentSearchCountry(response: CountryList.SearchCountry.Response) {
    let country = response.country
    let viewModel = CountryList.SearchCountry.ViewModel(country: country)
    viewController.displaySearchCountry(viewModel: viewModel)
  }
}
