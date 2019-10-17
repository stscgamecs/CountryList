//
//  CountryListDetailViewController.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailViewControllerInterface: class {
  func displayCity(viewModel: CountryListDetail.GetCity.ViewModel)
  func displayLodingCity(hidden:Bool)
}

class CountryListDetailViewController: UIViewController, CountryListDetailViewControllerInterface {
  
  var interactor: CountryListDetailInteractorInterface!
  var router: CountryListDetailRouter!
  var city: [DataCity] = []
  
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var loadingViewDetail: UIActivityIndicatorView!
  
  // MARK: - Object lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration
  private func configure(viewController: CountryListDetailViewController) {
    let router = CountryListDetailRouter()
    router.viewController = viewController

    let presenter = CountryListDetailPresenter()
    presenter.viewController = viewController

    let interactor = CountryListDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = CountryListDetailWorker(store: CountryListDetailStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    getCity()
  }
  func displayLodingCity(hidden:Bool) {
    loadingViewDetail.isHidden = hidden
  }
  // MARK: - Event handling
  func getCity() {
    interactor.getCity(request: CountryListDetail.GetCity.Request())
  }

  // MARK: - Display logic
  func displayCity(viewModel: CountryListDetail.GetCity.ViewModel) {
    countryLabel.text = viewModel.countryName
    cityLabel.text = viewModel.cityName
  }

  // MARK: - Router
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
}
