//
//  FilterTableViewController.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/20/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

class FilterTableViewController: UIViewController {

   
    /*
     4 section:
     - Deal : 1 - SwitchCell
     - Sort: 3 - CheckCell -> exclusive
     - Distance: 1- SwitchCell ->> 4 - CheckCell exclusive
     - Category: 1-switchcell ->> 10 - CheckCell - multi check
 */
    let sectionNames = ["", "Sort", "Distance", "Category"]
    let sortNames = ["Best Match", "Distance", "Highest Rated"]
    let distanceNames = ["0.5 mile", "1 mile", "5 miles", "10 miles"]
    let categoryNames = [["title":"Hotels", "alias":"hotels"],
                         ["title":"Restaurants", "alias":"restaurants"],
                         ["title": "Home Services", "alias": "homeservices"],
                         ["title": "Doctors", "alias": "physicias"],
                         ["title": "Psychologists", "alias": "psychologists"]
    ]
    
    var sortSwitches = [true, false, false]
    var distanceSwitches = [false, false, false, false]
    var categorySwitches = [false, false, false, false, false]
    var dealSwitch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FilterTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return sortSwitches.count
            case 2: return distanceSwitches.count
            case 3: return categorySwitches.count
            default: return 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchTableViewCell
            cell.titleLabel.text = "Offering a Deal"
            cell.enableSwitch.isOn = dealSwitch
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckCell") as! CheckTableViewCell
            
            cell.titleLabel.text = sortNames[indexPath.row]
            cell.iconImageView.isHighlighted = sortSwitches[indexPath.row]
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckCell") as! CheckTableViewCell
            
            cell.titleLabel.text = distanceNames[indexPath.row]
            cell.iconImageView.isHighlighted = distanceSwitches[indexPath.row]
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckCell") as! CheckTableViewCell
            
            cell.titleLabel.text = categoryNames[indexPath.row]["title"]
            cell.iconImageView.isHighlighted = categorySwitches[indexPath.row]

            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
//        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
//        
//        textLabel.text = sectionNames[section]
//        header.backgroundColor = UIColor.lightGray
//        
//        header.addSubview(textLabel)
//        return header
//    }
    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
