//
//  Player.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 10/23/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import Foundation

class Player: NSObject {
    
    // MARK: Properties
    var myResources = [Int]()
    var myBrothers = [Brother]()
    var isCurrent = true
    var myPlayerBoards = [PlayerBoard]()
    
    // MARK: Initialization
    override init() {
        
        // myResources array needs to initialize to different starting values depending on player count (single-player game starts with 0). For now, we are assuming 2 player game.
        myResources = [0,0,0,0,0,0]
        //myPlayerBoards.append(PlayerBoard(boardType: "heartland"))
        
    }
    
    enum resourceList: Int {
        case wood = 0
        case clay = 1
        case grain = 2
        case sheep = 3
        case peat = 4
        case coin = 5
    }
    
    
    func addBoard(boardType: String) -> PlayerBoard {
        let newBoard = PlayerBoard(boardType: boardType)
        
        /*
        switch boardType {
        case "heartland":
            newBoard.newHeartland()
        default:
            newBoard.newHeartland()
        }
*/
        
        
        return newBoard
    }
}
