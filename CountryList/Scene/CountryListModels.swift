//
//  CountryListModels.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

struct CountryList {
  
  struct CountryModel {
    
    struct Request {}
    
    struct Response {
      let country: Country
    }
    
    struct ViewModel {
      let country: Country
    }
  }
  
  struct SearchCountry {
    struct Request {
      let searchCountry:String
    }
    
    struct Response {
      let country: [DataCountry]
    }
    
    struct ViewModel {
      let country: [DataCountry]
    }
  }
}
