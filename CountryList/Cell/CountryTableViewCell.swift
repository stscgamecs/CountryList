//
//  CountryTableViewCell.swift
//  CountryList
//
//  Created by Z64me on 18/10/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var countryNamelabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func setUi(country: DataCountry){
    countryNamelabel.text = country.countryName
  }
}
