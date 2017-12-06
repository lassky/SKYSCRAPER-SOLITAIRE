//
//  ProductionWheel.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 10/22/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import Foundation

class ProductionWheel: NSObject {
    
    // MARK: Properties
    
    // Initialization of the wheel placement for each of the 6 main resources. The current order is Wood, Clay, Grain, Sheep, Peat, Coin. (This will be expanded to include Joker, Stone, and Grapes.)
    var resourceIndexes = [0, 0, 0, 0, 0, 0]
    var resourceValue = [Int]()

    // MARK: Initialization
    override init() {
        super.init()
        
        // Eventually, this init will be passed a player count so that the wheel can be set up with the correct value array.  resourceValue will be set using a switch statement based on this parameter.
        resourceValue = [0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 8, 10]

    }
    
    
    // MARK: Methods
    func turnWheel() {
        // Update the current place on the wheel for each resource.  This is consistent regardless of which wheel (player count) is used, and the conversion to the actual number of resources is done by the object using this index.
        var i = 0
        for var index in resourceIndexes{
            index = index + 1
            // If index goes above 12, change to 0.  This will have to be modified to remove the game piece in the single-player game.
            resourceIndexes[i] = index % 13
            i += 1
        }
    }
    
    func takeResource(resource: Int) {
       
        // This function receives a UIButton tag (index) that matches the index number in the resourceIndexes array.
        resourceIndexes[resource] = 0
    }
}
