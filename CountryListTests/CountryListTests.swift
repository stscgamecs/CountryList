//
//  CountryListTests.swift
//  CountryListTests
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import CountryList

class CountryListDetailPresenterTests: XCTestCase {
  var presenterDetail: CountryListDetailPresenter!
  
  override func setUp() {
    super.setUp()
    presenterDetail = CountryListDetailPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  class CountryListDetailViewControllerSpy: CountryListDetailViewControllerInterface {
    var displayCity = false
    
    func displayCity(viewModel: CountryListDetail.getCity.ViewModel) {
      displayCity = true
    }
  }
  func testPresentCityAskViewControllerToViewControllerDisplayCity() {
    
    //Given
    let viewModelSpy = CountryListDetailViewControllerSpy()
    presenterDetail.viewController = viewModelSpy
    
    
    //when
    let responseSpy = CountryListDetail.getCity.Response(city: .init(data: []))
    presenterDetail.presentCity(response: responseSpy)
    
    //then
    XCTAssert(viewModelSpy.displayCity,"Test PresentCity() should ask ViewController DisplayCity()")
    
  }
}
