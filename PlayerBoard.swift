//
//  PlayerBoard.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 11/6/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import UIKit

class PlayerBoard: NSObject {

    var boardSlots = [PlayerBoardSlot]()
    
    init(boardType: String)
    {
        super.init()
        if boardType == "heartland" {
            setupHeartland()
        }
        
        
        
    }

    func setupHeartland() {
        
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"T01"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"T00"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"T00"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:nil))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"B01"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"T01"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"T00"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"B00"))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:nil))
        boardSlots.append(PlayerBoardSlot(terrainType:PlayerBoardSlot.TerrainTypes.plain.rawValue, thisBuilding:"B02"))
        
    }
    
}
