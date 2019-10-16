//
//  CountryTableViewCell.swift
//  CountryList
//
//  Created by Z64me on 16/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var countryName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  func setUi(country:String){
    countryName.text = country
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
