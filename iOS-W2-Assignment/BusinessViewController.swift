//
//  BusinessViewController.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/18/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var businesses: [Business]!
    
    @IBOutlet weak var businessTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBusinessTableView()
        initBusinessTableView()
        
        // Example of Yelp search with more search options specified
        /*
         Business.search(with: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]?, error: Error?) in
         if let businesses = businesses {
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         }
         */
    }

    private func initBusinessTableView() {
        businessTableView.dataSource = self
        businessTableView.delegate = self
    }
    
    private func loadBusinessTableView(){
        Business.search(with: "Thai") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.businessTableView.reloadData()
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (businesses != nil ? businesses.count : 0)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let businessCell = businessTableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessTableViewCell
        let currentBusiness = businesses?[indexPath.row]
        
        if let currentBusiness = currentBusiness {
            businessCell.business = currentBusiness
        }
        
        return businessCell
    }
}
