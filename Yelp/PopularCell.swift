//
//  PopularCell.swift
//  Yelp
//
//  Created by Vidya Sridharan on 9/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class PopularCell: UITableViewCell {

    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var switchControl: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func setPopularCell (labelContent: String)->Void{
        popularLabel.text = labelContent
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
