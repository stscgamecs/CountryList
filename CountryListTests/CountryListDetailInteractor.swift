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
    func presentCity(response: CountryListDetail.getCity.Response) {
      presentCity = true
    }
    
    
  }
  class CountryListDetailWorkerSpy: CountryListDetailStoreProtocol {
    var checkStateFailure:Bool = false
    func getDataCity(sent city_name: String, _ completion: @escaping (Result<City, ApiError>) -> Void) {
      if checkStateFailure == false{
        completion(Result.success(.init(data: [.init(countryCode: "", countryName: "", capitalName: "")])))
      }else{
        completion(Result.failure(ApiError.jsonError))
      }
    }
  }
  
  func testGetCityAskPresenterToPresentCity() {
    //Given
    let store = CountryListDetailWorkerSpy()
    let workerSpy = CountryListDetailWorker(store: store)
    interactorDetail.worker = workerSpy
    
    let modelSpy: DataCountry
    modelSpy = .init(countryCode: "Th", countryName: "Thiland")
    interactorDetail.model = modelSpy
    interactorDetail.model?.countryCode = "Th"
    let presenterDetailSpy = CountryListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    //when
    let requestSpy = CountryListDetail.getCity.Request()
    interactorDetail.getCity(request: requestSpy)
    
    //then
    XCTAssert(presenterDetailSpy.presentCity,"Test GetCity() should ask PresentCity()")
  }

}
