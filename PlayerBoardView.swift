//
//  PlayerBoardView.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 11/3/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import UIKit

@IBDesignable class PlayerBoardView: UIView {
    
    var buildingRows = [UIStackView]()
    
    init(boardType: String) {
        super.init(frame: CGRect(x:0, y:0, width:100, height: 100))
        self.layer.backgroundColor = UIColor.green.cgColor
    
        switch boardType {
        case "heartland":
            setupHeartland()
            
        default:
            setupHeartland()
            
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.backgroundColor = UIColor.green.cgColor

        setupHeartland()
            
    }
    
    
    
    func setupHeartland() {
        let row0 = UIStackView(frame: CGRect(x:0, y:0, width:255, height:67))
        let row1 = UIStackView(frame: CGRect(x:0, y:67, width:255, height:67))
        row0.tag = 0
        row1.tag = 1
        buildingRows.append(row0)
        buildingRows.append(row1)
        for row in buildingRows {
            let rowBG = UIView(frame: row.frame)
            row.addSubview(rowBG)


            addRowBuildings(rowSize: 5, curRow: row, rowIndex: buildingRows.index(of: row)!)
            self.addSubview(row)
            
            }
        
        }
    
    func addRowBuildings(rowSize: Int, curRow: UIStackView, rowIndex: Int) {
           
            switch rowIndex {
            case 0:
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Moor", description: "", tag: 4))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Forest", description: "", tag: 0))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Forest", description: "", tag: 0))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "", description: "", tag: 99))
                 curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Clay Mound", description: "Take Clay", tag: 1))
                
                for curBuilding in curRow.arrangedSubviews {
                    //Add constraints
                    curBuilding.translatesAutoresizingMaskIntoConstraints = false
                    curBuilding.heightAnchor.constraint(equalToConstant: curBuilding.frame.height).isActive = true
                    curBuilding.widthAnchor.constraint(equalToConstant: curBuilding.frame.width).isActive = true
                    curBuilding.layer.borderColor = UIColor.black.cgColor
                    curBuilding.layer.borderWidth = 1

                }
                
            default: // case 1
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Moor", description: "", tag: 4))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Forest", description: "", tag: 0))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Farmyard", description: "Take Grain -or- \nTake Livestock", tag: 3))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "", description: "", tag: 99))
                curRow.addArrangedSubview(Building(frame: CGRect(x:0, y:0, width:50, height:68), buildingName: "Cloister Office", description: "Take Coins", tag: 5))
                
                
                for curBuilding in curRow.arrangedSubviews {
                    //Add constraints
                    curBuilding.translatesAutoresizingMaskIntoConstraints = false
                    curBuilding.heightAnchor.constraint(equalToConstant: curBuilding.frame.height).isActive = true
                    curBuilding.widthAnchor.constraint(equalToConstant: curBuilding.frame.width).isActive = true
                    curBuilding.layer.borderColor = UIColor.black.cgColor
                    curBuilding.layer.borderWidth = 1
                    
                }
            }
        
    }
}
