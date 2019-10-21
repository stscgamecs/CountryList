//
//  CountryListInteractorTests.swift
//  CountryListTests
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import CountryList

class CountryListInteractorTests: XCTestCase {
  var interactor: CountryListInteractor!
  var store: CountryListStore!
  
  func setUpCountry(){
    interactor = CountryListInteractor()
    store = CountryListStore()
  }
  
  override func setUp() {
    super.setUp()
    setUpCountry()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  class CountryListPresenterSpy:CountryListPresenterInterface {
    
    var presentCountry = false
    var presentSearchCountry = false
    var presentCountryLoadingCheck = false
    
    func presentCountry(response: CountryList.CountryModel.Response) {
      presentCountry = true
    }
    
    func presentSearchCountry(response: CountryList.SearchCountry.Response) {
      presentSearchCountry = true
    }
    
    func presentCountryLoading(response: CountryList.Loading.Response) {
      presentCountryLoadingCheck = true
    }
  }
  
  class CountryListWorkerSpy: CountryListStoreProtocol {
    var checkStateFailure:Bool = false
    
    func getDataCountry(_ completion: @escaping (Result<Country, ApiError>) -> Void) {
      if checkStateFailure == false{
        completion(Result.success(.init(data: [])))
      }else{
        completion(Result.failure(ApiError.jsonError))
      }
    }
  }
  
  func testGetCountryAskPresenterToPresentCountry() {
    //Given
    let workerSpy = CountryListWorker(store: CountryListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = CountryListPresenterSpy()
    interactor.presenter = presenterSpy
    
    
    //when
    let requestSpy = CountryList.CountryModel.Request()
    interactor.getCountry(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentCountry,"Test GetCountry() should ask PresenterCountry()")
    XCTAssert(presenterSpy.presentCountryLoadingCheck,"Test GetCountry() should ask PresenterCountryLoading()")
  }
  
  func testGetCountryAskPresenterToPresentCountryWhenFails() {
    //Given
    let storeSpy = CountryListWorkerSpy()
    storeSpy.checkStateFailure = true
    
    let workerSpy = CountryListWorker(store:storeSpy)
    interactor.worker = workerSpy
    
    let presenterSpy = CountryListPresenterSpy()
    interactor.presenter = presenterSpy
    
    
    //when
    let requestSpy = CountryList.CountryModel.Request()
    interactor.getCountry(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentCountry,"Test GetCountry() should ask PresenterCountry()")
    XCTAssert(presenterSpy.presentCountryLoadingCheck,"Test GetCountry() should ask PresenterCountryLoading()")
  }
  
  func testGetSearchAskPresenterToPresentSearchCountry() {
    //Given
    let presenterSpy = CountryListPresenterSpy()
    interactor.presenter = presenterSpy
    let modelSpy: Country = .init(data: [.init(countryCode: "Th", countryName: "Thai")])
    interactor.modelCountry = modelSpy
    
    //when
    let searchCountrySpy = "Th"
    let requestSpy = CountryList.SearchCountry.Request(searchCountry: searchCountrySpy)
    interactor.getSearch(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSearchCountry,"Test GetSearch should ask PresenterSearchCountry()")
  }
  
  func testGetSearchAskPresenterToPresentSearchCountryisEmpty() {
    //Given
    let presenterSpy = CountryListPresenterSpy()
    interactor.presenter = presenterSpy
    let modelSpy: Country = .init(data: [])
    interactor.modelCountry = modelSpy
    
    //when
    let searchCountrySpy = ""
    let requestSpy = CountryList.SearchCountry.Request(searchCountry: searchCountrySpy)
    interactor.getSearch(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSearchCountry,"Test GetSearch should ask PresenterSearchCountry()")
  }
  
  func testGetSearchAskPresenterToPresentSearchCountryisNull() {
    //Given
    let presenterSpy = CountryListPresenterSpy()
    interactor.presenter = presenterSpy
    let modelSpy: Country = .init(data: [])
    interactor.modelCountry = modelSpy
    
    //when
    let requestSpy = CountryList.SearchCountry.Request(searchCountry: nil)
    interactor.getSearch(request: requestSpy)
    
    //then
    XCTAssertFalse(presenterSpy.presentSearchCountry,"Test GetSearch Not should ask PresenterSearchCountry()")
  }
}
