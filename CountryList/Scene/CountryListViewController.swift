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
}

class CountryListViewController: UIViewController, CountryListViewControllerInterface {
  var interactor: CountryListInteractorInterface!
  var router: CountryListRouter!
  var country: [DataCountry] = []
  
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  @IBOutlet weak var countryTableView: UITableView!
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
    getCountry()
  }
  
  // MARK: - Event handling
  func getCountry() {
    loadingView.isHidden = false
    let request = CountryList.CountryModel.Request()
    interactor.getCountry(request: request)
  }
  
  // MARK: - Display logic
  func displayCountry(viewModel: CountryList.CountryModel.ViewModel) {
    sleep(2)
    loadingView.isHidden = true
    let newcountry = viewModel.country.data
    country = newcountry
    countryTableView.reloadData()
  }
  
  func displaySearchCountry(viewModel: CountryList.SearchCountry.ViewModel) {
    let newcountry = viewModel.country
    country = newcountry
    countryTableView.reloadData()
  }
  
  @IBOutlet weak var textField: UITextField!
  @IBAction func textFieldsearch(_ sender: Any) {
    guard let checkText = textField.text else {
      return
    }
    if !checkText.isEmpty{
      let requset = CountryList.SearchCountry.Request(searchCountry: checkText)
      interactor.getSearch(request: requset)
    }
    else if checkText.isEmpty{
      getCountry()
    }
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
    
    let countryList = country[indexPath.row].countryName
    cell.setUi(country: countryList)
    return cell
  }
}

extension CountryListViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let countryIndex = country[indexPath.item]
    router.navigateToDetail(sender: countryIndex)
  }
}
