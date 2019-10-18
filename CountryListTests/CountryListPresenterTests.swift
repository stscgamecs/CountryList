//
//  CountryListPresenterTests.swift
//  CountryListTests
//
//  Created by Z64me on 17/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import CountryList

class CountryListPresenterTests: XCTestCase {
  var presenter: CountryListPresenter!
 
  override func setUp() {
    super.setUp()
    presenter = CountryListPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  class CountryListViewControllerSpy: CountryListViewControllerInterface {
    
    var displayCountry = false
    var displaySearchCountry = false
    var displayLoading = false
    
    func displayLoading(viewModel: CountryList.Loading.ViewModel) {
      displayLoading = true
    }
    
    func displayCountry(viewModel: CountryList.CountryModel.ViewModel) {
      displayCountry = true
    }
    
    func displaySearchCountry(viewModel: CountryList.SearchCountry.ViewModel) {
      displaySearchCountry = true
    }
  }
  
  func testPresentCountryAskViewControllerToViewControllerDisplayCountry() {
    //Given
    let viewModelSpy = CountryListViewControllerSpy()
    presenter.viewController = viewModelSpy
    
    //when
    let responseSpy = CountryList.CountryModel.Response(country: .init(data: []))
    presenter.presentCountry(response: responseSpy)
    
    //then
    XCTAssert(viewModelSpy.displayCountry,"Test PresentCountry() should ask ViewController DisplayCountry()")
  }
  
  func testPresentSearchCountryAskViewControllerToViewControllerDisplaySearchCountry() {
    //Given
    let viewModelSpy = CountryListViewControllerSpy()
    presenter.viewController = viewModelSpy
    
    //when
    let responseSpy = CountryList.SearchCountry.Response(country: [])
    presenter.presentSearchCountry(response: responseSpy)
    
    //then
    XCTAssert(viewModelSpy.displaySearchCountry,"Test PresentCountry() should ask ViewController DisplayCountry()")
  }
  
  func testPresentCountryLoadingAskViewControllerToViewControllerDisplayLoading(){
    //Given
    let viewModelSpy = CountryListViewControllerSpy()
    presenter.viewController = viewModelSpy
    
    //when
    presenter.presentCountryLoading(response: CountryList.Loading.Response(isShowing: true))
    
    //then
    XCTAssert(viewModelSpy.displayLoading,"Test PresentCountryLoading ask ViewController displayLoading())")
  }
}
