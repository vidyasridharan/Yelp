//
//  PriceCell.swift
//  Yelp
//
//  Created by Vidya Sridharan on 9/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {
    
  
    
    @IBOutlet weak var priceControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.lightGrayColor() 
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
