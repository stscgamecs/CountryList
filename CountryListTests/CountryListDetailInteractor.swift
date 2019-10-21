//
//  CountryListDetailInteractor.swift
//  CountryListTests
//
//  Created by Z64me on 17/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import CountryList

class CountryListDetailInteractorTest: XCTestCase {
  var interactorDetail: CountryListDetailInteractor!
  var storeDetail: CountryListDetailStore!
  
  func setUpCountryDetail() {
    interactorDetail = CountryListDetailInteractor()
    storeDetail = CountryListDetailStore()
  }
  
  override func setUp() {
    super.setUp()
    setUpCountryDetail()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  class CountryListDetailPresenterSpy: CountryListDetailPresenterInterface {
    
    
    var presentCity = false
    var presentLoadingCityCheck = false
    var presentLoadingCityError = false
    func presentCity(response: CountryListDetail.GetCity.Response) {
      presentCity = true
    }
    
    func presentLoadingCity(response: CountryListDetail.Loding.Response) {
      presentLoadingCityCheck = true
    }
    
    func presentLoadingCityError(response: CountryListDetail.LoadingError.Response) {
         presentLoadingCityError = true
    }
  }
  
  class CountryListDetailWorkerSpy: CountryListDetailStoreProtocol {
    var checkStateFailure:Bool = false
    
    func getDataCity(sent city_name: String, _ completion: @escaping (Result<DataCity, Error>) -> Void) {
      if checkStateFailure == false {
        completion(Result.success(.init(countryCode: "", countryName: "", capitalName: "")))
      } else {
        completion(Result.failure(ApiError.jsonError))
      }
    }
  }
  
  func testGetCityAskPresenterToPresentCity() {
    //Given
    let store = CountryListDetailWorkerSpy()
    let workerSpy = CountryListDetailWorker(store: store)
    interactorDetail.worker = workerSpy
    
    let modelSpy: DataCountry = .init(countryCode: "Th", countryName: "Thiland")
    interactorDetail.model = modelSpy
    interactorDetail.model?.countryCode = "Th"
    
    let presenterDetailSpy = CountryListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    //when
    let requestSpy = CountryListDetail.GetCity.Request()
    interactorDetail.getCity(request: requestSpy)
    
    //then
    XCTAssert(presenterDetailSpy.presentCity,"Test GetCity() should ask PresentCity()")
    XCTAssert(presenterDetailSpy.presentLoadingCityCheck,"Test GetCity() should ask PresentLoadingCity()")
  }
  func testGetCityAskPresenterToPresentCityWhenFails() {
    //Given
    let store = CountryListDetailWorkerSpy()
    store.checkStateFailure = true
    let workerSpy = CountryListDetailWorker(store: store)
    interactorDetail.worker = workerSpy
    
    let modelSpy: DataCountry = .init(countryCode: "", countryName: "")
    interactorDetail.model = modelSpy
    interactorDetail.model?.countryCode = ""
    
    let presenterDetailSpy = CountryListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    //when
    let requestSpy = CountryListDetail.GetCity.Request()
    interactorDetail.getCity(request: requestSpy)
    
    //then
    XCTAssert(presenterDetailSpy.presentLoadingCityError,"Test GetCity() should ask PresentLoadingCityError()")
    XCTAssert(presenterDetailSpy.presentLoadingCityCheck,"Test GetCity() should ask PresentLoadingCity()")
  }
}
