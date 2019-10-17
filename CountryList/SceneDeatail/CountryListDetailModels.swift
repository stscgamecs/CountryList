//
//  CountryListDetailModels.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

struct CountryListDetail {
  struct GetCity {
    
    struct Request {}
    
    struct Response {
      let city: City
    }
    
    struct ViewModel {
      let countryName: String
      let cityName:String
      
    }
  }
  struct GetCountry {
    
    struct Request {}
    
    struct Response {}
    
    struct ViewModel {}
  }
  
}
