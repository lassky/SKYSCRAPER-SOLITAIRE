//
//  PlayerBoardSlot.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 11/3/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import Foundation

class PlayerBoardSlot: NSObject {
    

    enum TerrainTypes: Int {
        case plain = 0
        case hillside = 1
        case shore = 2
        case water = 3
        case mountain = 4
    }
    
    // MARK: Properties
    var terrainType: Int
    var isOccupied: Bool = false
    var isSettlement: Bool = false
    var hasBuilding: Bool = false
    var buildingID: String?
    var settlementPoints: Int = 0

    
    
    init(terrainType: Int, thisBuilding: String?) {
        self.terrainType = terrainType
        super.init()
        if let buildingID = thisBuilding {
            self.buildingID = buildingID
            hasBuilding = true
            settlementPoints = checkSettlementPoints()
            isSettlement = isSettlement(buildingID: buildingID)
            
        } else {
            isOccupied = false
            buildingID = nil
            isSettlement = false
        }

        
    }
    
    
    // MARK: Methods
   
    // Still needs to be implemented - settlement points calculation
    func checkSettlementPoints() -> Int {
        var pointsTotal = 0
        
        return pointsTotal
    }
    
    func isSettlement(buildingID: String) -> Bool {
        // TODO...
        return false
    }
    
}
