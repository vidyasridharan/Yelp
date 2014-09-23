//
//  FilterViewController.swift
//  Yelp
//
//  Created by Vidya Sridharan on 9/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var filterTable: UITableView!
    var sort_value = 0
    var radius_filter = 25
    
    var isExpanded: [Int: Bool] = [Int:Bool]()
    var distanceNames = ["Auto", "1 mile", "15 miles", "24 miles", "25 miles"]
    var categoryNames = ["Take-Out", "Good for Groups", "Take Reservations", "General 1", "General 2"]
    var sortNames = ["Best Match", "Distance", "Rating", "Most Reviewed"]
    var popularNames = ["Open Now", "Hot & New", "Offering a Deal", "Delivery"]
    var sectionTitles = ["Price", "Most Popular", "Distance", "Sort By", "General Features"]
    var sectionSizes = [ 1, 4, 5, 4, 5]
    var radius_values = [25, 1, 15, 24, 25]
    
    var selectedDistanceIndex = 0
    var selectedSortIndex = 0
    var PriceSection = 0
    var PopularSection = 1
    var DistanceSection = 2
    var SortSection = 3
    var CategorySection = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Filters"
        self.filterTable.delegate = self
        self.filterTable.dataSource = self
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.filterTable.rowHeight = 32
        // Do any additional setup after loading the view.
        filterTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
        case PriceSection  :
            var cell = tableView.dequeueReusableCellWithIdentifier("PriceCell") as PriceCell
            return cell
            
        case PopularSection:
        var cell = tableView.dequeueReusableCellWithIdentifier("popularCell") as PopularCell
        cell.setPopularCell(popularNames[indexPath.row])
            return cell
            
        case  DistanceSection:
            var cell = tableView.dequeueReusableCellWithIdentifier("distanceCell") as distanceCell
            cell.distanceLabel.text = distanceNames[indexPath.row]
            
            if (self.selectedDistanceIndex == indexPath.row) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            return cell
        
        case SortSection:
            var cell2 = tableView.dequeueReusableCellWithIdentifier("distanceCell") as distanceCell
            cell2.distanceLabel.text = sortNames[indexPath.row]
            return cell2
        
        case CategorySection:
            var cell3 = tableView.dequeueReusableCellWithIdentifier("popularCell") as PopularCell
            cell3.setPopularCell(categoryNames[indexPath.row])
            if(indexPath.row == 2){
                if(isExpanded[indexPath.section] != nil){
                    cell3.setPopularCell(categoryNames[indexPath.row])
                }
                else{
                    cell3.popularLabel.text = "See More"
                }
            }
            return cell3
            
        default:
            return UITableViewCell()
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section)
            {
            case DistanceSection, SortSection:
                if((isExpanded[section]) != nil){
                    if((isExpanded[section])!){
                        return sectionSizes[section]
                    }
                    return 1
                }
                return 1
            
            case CategorySection:
                if((isExpanded[section]) != nil){
                    if((isExpanded[section])!){
                        return sectionSizes[section]
                    }
                    return 3
                    }
            return 3
            
            default:
                return sectionSizes[section]
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionSizes.count
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section){
        case DistanceSection, SortSection:
            
            if((isExpanded[indexPath.section]) != nil){
                isExpanded[indexPath.section] = !isExpanded[indexPath.section]!
                self.selectedDistanceIndex = indexPath.row
                    println("Selected")
            }
            else{
                isExpanded[indexPath.section] = true
    
            }
                tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        case CategorySection:
                if(indexPath.row == 2){
                    isExpanded[indexPath.section] = true
                }
                tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
            break
            
        default:
            break
        }
 

        
    }
   
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x:0, y:0, width:320, height:30))
        headerView.backgroundColor = UIColor.lightGrayColor()
        var label = UILabel(frame: CGRect(x:10, y:10, width:300, height:15))
        label.text=sectionTitles[section]
        headerView.addSubview(label)
        return headerView
    }
   
   
    @IBAction func onCancel(sender: AnyObject) {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
  

    @IBAction func onSearch(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool( true, forKey: "deals_value")
        radius_filter = radius_values[selectedDistanceIndex]
        defaults.setInteger(radius_filter, forKey: "radius_value")
        defaults.setInteger(selectedSortIndex, forKey: "sort_value")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
