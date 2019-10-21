//
//  CountryListViewController.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit
protocol CountryListViewControllerInterface: class {
  func displayCountry(viewModel: CountryList.CountryModel.ViewModel)
  func displaySearchCountry(viewModel:CountryList.SearchCountry.ViewModel)
  func displayLoading(viewModel: CountryList.Loading.ViewModel)
  func displayLoadingError(viewModel: CountryList.LoadingError.ViewModel)
}

class CountryListViewController: UIViewController, CountryListViewControllerInterface {
  
  var interactor: CountryListInteractorInterface!
  var router: CountryListRouter!
  
  private var country: [DataCountry] = []
  
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  @IBOutlet weak var countryTableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  
  // MARK: - Object lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  private func configure(viewController: CountryListViewController) {
    let router = CountryListRouter()
    router.viewController = viewController
    
    let presenter = CountryListPresenter()
    presenter.viewController = viewController
    
    let interactor = CountryListInteractor()
    interactor.presenter = presenter
    interactor.worker = CountryListWorker(store: CountryListStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCell()
    getCountry()
  }
  
  func displayLoading(viewModel: CountryList.Loading.ViewModel) {
    loadingView.isHidden = viewModel.isShowing
  }
  
  func setUpCell() {
    let bundle = Bundle(for: CountryTableViewCell.self)
    let nib = UINib(nibName: "CountryTableViewCell", bundle: bundle)
    countryTableView.register(nib, forCellReuseIdentifier: "countryCell")
  }
  
  // MARK: - Event handling
  func getCountry() {
    let request = CountryList.CountryModel.Request()
    interactor.getCountry(request: request)
  }
  // MARK: - Display logic
  func displayCountry(viewModel: CountryList.CountryModel.ViewModel) {
    country = viewModel.country.data
    countryTableView.reloadData()
  }
  
  func displaySearchCountry(viewModel: CountryList.SearchCountry.ViewModel) {
    let newcountry = viewModel.country
    country = newcountry
    countryTableView.reloadData()
  }
  
  func displayLoadingError(viewModel: CountryList.LoadingError.ViewModel) {
    let alert = UIAlertController(title: "Error", message: "\(viewModel.urlError)", preferredStyle: .alert)
    self.present(alert, animated: false)
  }
  
  @IBAction func textFieldsearch(_ sender: UITextField) {
    let requset = CountryList.SearchCountry.Request(searchCountry: sender.text)
    interactor.getSearch(request: requset)
  }
  
  // MARK: - Router
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue, sender:sender)
  }
}

extension CountryListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return country.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = countryTableView.dequeueReusableCell(withIdentifier: "countryCell") as? CountryTableViewCell else {
      return UITableViewCell()
    }
    
    let countryList = country[indexPath.row]
    cell.setUi(country: countryList)
    return cell
  }
}

extension CountryListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let countryIndex = country[indexPath.item]
    router.navigateToDetail(sender: countryIndex)
  }
}
