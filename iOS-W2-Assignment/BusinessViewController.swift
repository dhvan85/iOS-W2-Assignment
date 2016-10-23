//
//  BusinessViewController.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/18/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var businesses: [Business]!
    var searchBar: UISearchBar!
    
    @IBOutlet weak var businessTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchBar()
        initBusinessTableView()
        loadBusinessData()
    }

    private func initSearchBar() {
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    private func initBusinessTableView() {
        businessTableView.dataSource = self
        businessTableView.delegate = self
        
        businessTableView.estimatedRowHeight = 110
        businessTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    public func loadBusinessData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Business.search(with: FilterSettings.instance.term,
                        sort: FilterSettings.instance.getSortMode(),
                        distance: FilterSettings.instance.getDistanceMode(),
                        categories: FilterSettings.instance.getCategoryAlias(),
                        deals: FilterSettings.instance.dealSwitch)
        { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.businessTableView.reloadData()
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FromFilterButton") {
            let destination = segue.destination as! FilterTableViewController
            destination.delegate = self
        }
    }
}

extension BusinessViewController: FilterTableViewControllerDelegate {
    func settingChanged (_ sender: FilterTableViewController) {
        loadBusinessData()
    }
}

// SearchBar methods
extension BusinessViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        FilterSettings.instance.term = ""
        searchBar.text = FilterSettings.instance.term
        searchBar.resignFirstResponder()
        
        loadBusinessData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        FilterSettings.instance.term = searchBar.text ?? ""
        searchBar.resignFirstResponder()
        
        loadBusinessData()
    }
}
