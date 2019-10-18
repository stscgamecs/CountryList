//
//  CountryListRouter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListRouterInput {
  func navigateToDetail(sender:DataCountry)
}

class CountryListRouter: CountryListRouterInput {
  weak var viewController: CountryListViewController!
  
  // MARK: - Navigation
  func navigateToDetail(sender: DataCountry) {
    viewController.performSegue(withIdentifier: "showDetail", sender: sender)
  }
  
  // MARK: - Communication
  func passDataToNextScene(segue: UIStoryboardSegue,sender: Any?) {
    if segue.identifier == "showDetail" {
      if let sender = sender as? DataCountry{
        passDataToSomewhereScene(segue: segue,sender: sender)
      }
    }
  }
  
  func passDataToSomewhereScene(segue: UIStoryboardSegue,sender: DataCountry) {
    let countryListViewController = segue.destination as? CountryListDetailViewController
    countryListViewController?.interactor.model = sender
  }
}
