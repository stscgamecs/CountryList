//
//  CountryListDetailPresenter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailPresenterInterface {
  func presentCity(response: CountryListDetail.getCity.Response)
}

class CountryListDetailPresenter: CountryListDetailPresenterInterface {
  weak var viewController: CountryListDetailViewControllerInterface!

  // MARK: - Presentation logic
  func presentCity(response: CountryListDetail.getCity.Response) {
    let viewModel = CountryListDetail.getCity.ViewModel(city: response.city)
    viewController.displayCity(viewModel: viewModel)
  }
}
