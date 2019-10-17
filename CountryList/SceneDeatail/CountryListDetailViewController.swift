//
//  CountryListDetailViewController.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol CountryListDetailViewControllerInterface: class {
  func displayCity(viewModel: CountryListDetail.getCity.ViewModel)
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

  // MARK: - Event handling
  func getCity() {
    loadingViewDetail.isHidden = false
    let request = CountryListDetail.getCity.Request( )
    interactor.getCity(request: request)
  }

  // MARK: - Display logic
  func displayCity(viewModel: CountryListDetail.getCity.ViewModel) {
      sleep(2)
    loadingViewDetail.isHidden = true
    countryLabel.text = viewModel.city.data[0].countryName
    cityLabel.text = viewModel.city.data[0].capitalName
  }

  // MARK: - Router
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
}
