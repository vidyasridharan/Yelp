//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    var client: YelpClient!
    var results = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "ljxsRIsSiV_6yP_c7vFKXQ"
    let yelpConsumerSecret = "Oj1-IN-oGsi8n17VEALlIFgMed8"
    let yelpToken = "TjgVl1zQg9GRhMn0ECsIGuu05tnrxKfc"
    let yelpTokenSecret = "lVfgyM-G00xxdNf-EMgk-Drxklo"
    var refreshControl: UIRefreshControl!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.searchBar.delegate=self
        //tableView.rowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        self.view.backgroundColor=UIColor.lightGrayColor()  
        self.getResults("Thai")
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        self.navigationItem.titleView = self.searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var yelpCell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as YelpTableViewCell
        yelpCell.setYelpCellContent(self.results[indexPath.row] as NSDictionary, rank: indexPath.row)
        
        println(self.results[indexPath.row])
        return yelpCell
    }
    
    func getResults(term: NSString)->Void{
        
        client.searchWithTerm(term, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.results = response["businesses"] as NSArray
            NSLog("Got %d business listings", self.results.count);
            //println(self.results)
            self.tableView.reloadData()
            
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
               println(error)
                self.results = []
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.getResults(searchText)
        tableView.reloadData()
        
        if(searchText == ""){
            searchBar.resignFirstResponder()    
        }
    }
    
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
 
    func onRefresh() {
        self.view.endEditing(true)
        
            self.refreshControl.endRefreshing()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var term = "Thai"
        if(searchBar.text != nil){
          term = searchBar.text
        }
       
        var radius_value = defaults.integerForKey("radius_value")
        var sort_value = defaults.integerForKey("sort_value")
        var deals_value = defaults.boolForKey("default_value")
        client.searchWithFilters(term, radius: radius_value, deals: deals_value, sort: sort_value, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.results = response["businesses"] as NSArray
            NSLog("Got %d business listings", self.results.count);
            //println(self.results)
            self.tableView.reloadData()
            
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
                self.results = []
        }
    
    }
}

