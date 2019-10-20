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
    var displayLodingCityCheck = false
    var displayLodingCityErrorTest = false
    func displayCity(viewModel: CountryListDetail.GetCity.ViewModel) {
      displayCity = true
    }
    
    func displayLodingCity(viewModel: CountryListDetail.Loding.ViewModel) {
      displayLodingCityCheck = true
    }
    func displayLodingCityError() {
      displayLodingCityErrorTest = true
    }
  }
  
  func testPresentCityAskViewControllerToViewControllerDisplayCity() {
    //Given
    let viewModelSpy = CountryListDetailViewControllerSpy()
    presenterDetail.viewController = viewModelSpy
    
    
    //When
    let responseSpy = CountryListDetail.GetCity.Response(city: DataCity.init(countryCode: "Th", countryName: "Thai", capitalName: "Bankkok"))
    presenterDetail.presentCity(response: responseSpy)
    
    //Then
    XCTAssert(viewModelSpy.displayCity,"Test PresentCity() should ask ViewController DisplayCity()")
    XCTAssert(viewModelSpy.displayLodingCityCheck,"Test PresentCity() should ask ViewController LodingCity()")
  }
  
  func testPresentLoadingAskViewControllerToViewControllerDisplayLodingCity(){
    //Given
    let viewModelSpy = CountryListDetailViewControllerSpy()
    presenterDetail.viewController = viewModelSpy
    
    //when
    presenterDetail.presentLoadingCity(response: CountryListDetail.Loding.Response(isShowing: true))
    
    //Then
    XCTAssert(viewModelSpy.displayLodingCityCheck,"Test PresentCity() should ask ViewController LodingCity()")
  }
  
  func testPresentLoadingErrorAskViewControllerToViewControllerDisplayLodingCityError(){
    //Given
    let viewModelSpy = CountryListDetailViewControllerSpy()
    presenterDetail.viewController = viewModelSpy
    
    //when
    presenterDetail.presentCity(response: CountryListDetail.GetCity.Response(city: DataCity(countryCode: "", countryName: "", capitalName: "" )))
    
    
    //Then
    XCTAssert(viewModelSpy.displayLodingCityErrorTest,"Test PresentCityError() should ask ViewController LodingCityError()")
  }
}
