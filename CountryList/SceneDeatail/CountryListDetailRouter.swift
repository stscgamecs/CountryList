//
//  CountryListDetailRouter.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailRouterInput {
  func navigateToSomewhere()
}

class CountryListDetailRouter: CountryListDetailRouterInput {
  weak var viewController: CountryListDetailViewController!

  // MARK: - Navigation
  func navigateToSomewhere() {
    
  }

  // MARK: - Communication
  func passDataToNextScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router which scenes it can communicate with

    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router how to pass data to the next scene

    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.interactor.model = viewController.interactor.model
  }
}
