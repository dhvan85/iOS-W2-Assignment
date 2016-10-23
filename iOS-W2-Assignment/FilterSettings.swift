//
//  FilterSettings.swift
//  iOS-W2-Assignment
//
//  Created by Van Do on 10/22/16.
//  Copyright © 2016 Van Do. All rights reserved.
//

import Foundation

class FilterSettings {
    var term: String = ""
    var dealSwitch = false
    var sortSwitches = [true, false, false]
    var distanceSwitches = [false, false, false, true]
    var categorySwitches = [false, false, false, false, false]
    
    let sectionNames = ["", "Sort", "Distance", "Category"]
    let sortNames = ["Best Match", "Distance", "Highest Rated"]
    let distanceNames = ["0.5 mile", "1 mile", "5 miles", "10 miles"]
    let categoryNames = [["title":"Hotels", "alias":"hotels"],
                         ["title":"Restaurants", "alias":"restaurants"],
                         ["title": "Home Services", "alias": "homeservices"],
                         ["title": "Food", "alias": "food"],
                         ["title": "Health", "alias": "health"]
    ]

    static let instance = FilterSettings()
    
    func getSortMode() -> YelpSortMode {
        for index in 0..<sortSwitches.count {
            if (sortSwitches[index] == true) {
                return YelpSortMode(rawValue: index)!
            }
        }
        
        return YelpSortMode.bestMatched
    }
    
    func getDistanceMode() -> Double {
        for index in 0..<distanceSwitches.count {
            if (distanceSwitches[index] == true) {
                switch index {
                case 1: return 1
                case 2: return 5
                case 3: return 10
                default: return 0.5
                }
            }
        }
        
        return 0.5
    }
    
    func getCategoryAlias() -> [String] {
        var result = [String]()
        
        for index in 0..<categorySwitches.count {
            if (categorySwitches[index] == true) {
                result.append(categoryNames[index]["alias"]!)
            }
        }
        
        return result
    }
}
