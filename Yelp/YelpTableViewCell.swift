//
//  YelpTableViewCell.swift
//  Yelp
//
//  Created by Vidya Sridharan on 9/20/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var ratingView: UIImageView!
    

    @IBOutlet weak var posterImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setYelpCellContent ( cellContent : NSDictionary, rank:Int)->Void{
        var name = "\(rank+1)."
        name += cellContent["name"] as String!
        self.nameLabel.text = name
        var reviews = cellContent["review_count"] as NSInteger
        
        
        self.reviewsLabel.text = "\(reviews) Reviews"
        var posterUrl = cellContent["rating_img_url"] as NSString
        ratingView.setImageWithURL(NSURL(string: posterUrl))
        println("trouble")
        
        println(cellContent["image_url"])
        var imageUrl = cellContent["image_url"] as NSString!
        if(imageUrl != nil){
        posterImage.setImageWithURL( NSURL(string:imageUrl))
        
        }
        var addresses = cellContent["location"] as NSDictionary!
        var address_content = addresses["display_address"] as NSArray!
        println(address_content[0])
        var categoriesArray = cellContent["categories"] as NSArray!
        
       
        /*if(categoriesArray.count != 0){
            var content = categoriesArray[0] as? NSString
            println(content)
            println("test")
            self.tagLabel.text = content
        }*/
        
        self.addressLabel.text = address_content[0] as NSString
        
        self.distLabel.text = "0.0 mi";
     //   self.costLabel.text = "$$";
       
    }
}
