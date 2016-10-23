//
//  FilterTableViewController.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/20/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import UIKit

@objc protocol FilterTableViewControllerDelegate {
    @objc optional func settingChanged (_ sender: FilterTableViewController)
}

class FilterTableViewController: UIViewController {
    /*
     4 section:
     - Deal : 1-SwitchCell
     - Sort: 3-CheckCell - exlusive check
     - Distance: 1-SwitchCell ->> 4-CheckCell - exclusive check
     - Category: 1-switchcell ->> 5-CheckCell - multi check
     */
    
    var sectionNames: [String]!
    var sortNames: [String]!
    var distanceNames: [String]!
    var categoryNames: [Dictionary<String,String>]!
    
    
    var sortSwitches: [Bool]!
    var distanceSwitches: [Bool]!
    var categorySwitches: [Bool]!
    var dealSwitch: Bool!
    weak var delegate: FilterTableViewControllerDelegate?
    
    @IBAction func onSaving(_ sender: AnyObject) {
        FilterSettings.instance.dealSwitch = dealSwitch
        FilterSettings.instance.sortSwitches = sortSwitches
        FilterSettings.instance.distanceSwitches = distanceSwitches
        FilterSettings.instance.categorySwitches = categorySwitches
        
        delegate?.settingChanged?(self)
        
        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionNames = FilterSettings.instance.sectionNames
        sortNames = FilterSettings.instance.sortNames
        distanceNames = FilterSettings.instance.distanceNames
        categoryNames = FilterSettings.instance.categoryNames
        
        sortSwitches = FilterSettings.instance.sortSwitches
        distanceSwitches = FilterSettings.instance.distanceSwitches
        categorySwitches = FilterSettings.instance.categorySwitches
        dealSwitch = FilterSettings.instance.dealSwitch
        
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
            cell.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            for index in 0..<sortSwitches.count {
                sortSwitches[index] = false
            }
            
            sortSwitches[indexPath.row] = true
            break
        case 2:
            for index in 0..<distanceSwitches.count {
                distanceSwitches[index] = false
            }
            
            distanceSwitches[indexPath.row] = true
            break
        case 3:
            categorySwitches[indexPath.row] = !categorySwitches[indexPath.row]
        default:
            break
        }
        
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
}

extension FilterTableViewController: SwitchTableViewCellDelegate {
    func switchChanged(_ sender: SwitchTableViewCell) {
        dealSwitch = sender.enableSwitch.isOn
    }
}
