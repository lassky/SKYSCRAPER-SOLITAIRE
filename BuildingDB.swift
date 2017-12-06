//
//  BuildingDB.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 10/25/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import Foundation

class BuildingDB: NSObject {
   
    var rawBuildings: NSString?
    let numFields = 17
    var buildingList = [Array<String?>]()
    
    enum BuildingFields: Int {
        case phase = 0
        case id = 1
        case name = 2
        case cloister = 3
        case terrain = 4
        case costWood = 5
        case costClay = 6
        case costStone = 7
        case costStraw = 8
        case costCoin = 9
        case valuePoint = 10
        case valueSettlement = 11
        case function = 12
        case timesFunction = 13
        case secondary = 14
        case timesSecondary = 15
    }
    
    // MARK: Initialization
    override init() {
        super.init()
        
        // Create filepath to find csv data.
        let bundle = Bundle.main
        let resourcePath = bundle.path(forResource: "IrelandBuildingsDB", ofType: "csv")
        do {
            rawBuildings = try String.init(contentsOfFile: resourcePath!) as NSString
            createDB()
        }
        catch {
            fatalError("Could not load building spreadsheet") }
        }
    
  
    func createDB() {
        let allStrings = rawBuildings?.components(separatedBy: ",")
        
        var  i = 0
        var building = [String]()
            for string in allStrings! {
               i += 1
                if i >= numFields {
                    buildingList.append(building)
                    building = []
                    i = 0
                } else {
                    building.append(string)
                }
            }

        }
    
    func getBuildingInfo(name: String?) -> (String?, String?) {
        
        if name != nil && !(name?.isEmpty)! {
        var buildingFound = [String?]()
        
        for building in self.buildingList {
            if building[BuildingDB.BuildingFields.name.rawValue] == name {
                buildingFound = building as [String?]
                
            }
        }
        
        return (buildingFound[BuildingFields.id.rawValue], buildingFound[BuildingFields.function.rawValue])
       } else {
        return (nil, nil)
        }
    }
 
    
}
    

