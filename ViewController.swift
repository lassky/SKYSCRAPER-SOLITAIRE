//
//  ViewController.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 10/20/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var woodValue: UILabel!
    @IBOutlet weak var clayValue: UILabel!
    @IBOutlet weak var grainValue: UILabel!
    @IBOutlet weak var sheepValue: UILabel!
    @IBOutlet weak var peatValue: UILabel!
    @IBOutlet weak var coinValue: UILabel!
    
    @IBOutlet weak var myWood: UILabel!
    @IBOutlet weak var myClay: UILabel!
    @IBOutlet weak var myGrain: UILabel!
    @IBOutlet weak var mySheep: UILabel!
    @IBOutlet weak var myPeat: UILabel!
    @IBOutlet weak var myCoin: UILabel!
    @IBOutlet weak var playerBoardView: PlayerBoardView!
    
    @IBOutlet weak var playerBoardWindow: UIView!
    
    @IBOutlet weak var buildingRow0: UIStackView!
    @IBOutlet weak var buildingRow1: UIStackView!
    @IBOutlet weak var buildingRow2: UIStackView!
    @IBOutlet weak var buildingRow3: UIStackView!
    
    @IBOutlet weak var districtStack: UIView!
    @IBOutlet weak var plotStack: UIView!
    
    var labels = [UILabel]()
    var playerResources = [UILabel]()
    var productionWheel = ProductionWheel()
    
    let buildingDB = BuildingDB()
    var buildingSelected = false
    var currentlySelectedBuilding = String()
    var selectedPurchaseButton = UIButton()
    
    let purchaseDisplay = PurchaseDisplay()
    
    @IBOutlet weak var nextPhase: UIButton!
    // For now, just add 1 player, but there will have to be an array of player representing that game's player count.
    let player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Move all UIButtons into an array that can be iterated through when turning the wheel in turnWheel()
        labels = [woodValue, clayValue, grainValue, sheepValue, peatValue, coinValue]
        playerResources = [myWood, myClay, myGrain, mySheep, myPeat, myCoin]
        refreshPlayerBoards()
        
        setPurchaseDisplay(phase: "0")
        
        player.myPlayerBoards.append(player.addBoard(boardType: "heartland"))
        playerBoardWindow.layer.borderColor = UIColor.black.cgColor
        playerBoardWindow.layer.borderWidth = 2
        setHeartland()
        print (districtStack.frame.minX)
        print(districtStack.frame.minY)
        print(districtStack.frame.height)
        print(districtStack.frame.width)
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // run whenever a new building in placed into player board array
    func refreshPlayerBoards() {
        // Placeholder, just use phase A Buildings.  Eventually this needs to update for each phase.
        var currentDisplay = [Array<String>]()
        
        for building in buildingDB.buildingList {
            if building[BuildingDB.BuildingFields.phase.rawValue] == "0" {
                currentDisplay.append(building as! [String]) }
            }
    }
    
   
    // MARK: Actions
    
    @IBAction func turnWheel(_ sender: Any) {
        productionWheel.turnWheel()
        
        // Get the index number from ProductionWheel and convert into the actual number of resources to display on screen.
        var i = 0
        for label in labels {
            label.text = String(productionWheel.resourceValue[productionWheel.resourceIndexes[i]])
            i = i + 1
        }

    }
    
    @IBAction func takeResource(_ sender: Any) {
        // Conditional binding ensures there is a UIButton as the sender.  Eventually these will be hooked into the player's action selection board.
        guard let button = sender as? UIButton else {
            return
        }
        
        // Add the current number to the player's resource stock, then set the onscreen label to 0.
        if let addResources = Int(labels[button.tag].text!) {
            let newResources = player.myResources[button.tag] + addResources
            player.myResources[button.tag] = newResources
            playerResources[button.tag].text = String(newResources)
        }
        
        // Update ProductionWheel property to this resource to index 0, and set onscreen label to 0.
        productionWheel.resourceIndexes[button.tag] = 0
        labels[button.tag].text = "0"
        
    }
    
    // MARK: IB Actions
    
    @IBAction func buttonClicked(_ sender: AnyObject?) {
        
        let alert = UIAlertController(title: buildingDB.buildingList[sender!.tag][BuildingDB.BuildingFields.name.rawValue], message: "Are you sure you want to build?", preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(alert, animated: false, completion: nil)
        
    }
    
    
    @IBAction func purchaseBuilding(_ sender: AnyObject?) {
        let test = sender as! UIButton
        let layer = test.superview?.layer
        
        if layer?.borderColor == UIColor.black.cgColor {
           
            if buildingSelected == false {
                layer?.borderColor = UIColor.green.cgColor
                layer?.borderWidth = 3
                buildingSelected = true
               
                let currentBuilding = sender!.superview as! Building
                currentlySelectedBuilding = currentBuilding.nameView.text!
                
                selectedPurchaseButton = sender as! UIButton
                
                
            checkPlacementAvailability()
                    
            }
        }
        
        else if layer?.borderColor == UIColor.green.cgColor {
            layer?.borderColor = UIColor.black .cgColor
            layer?.borderWidth = 1
            
            for board in player.myPlayerBoards {
                
                for slot in board.boardSlots {
                    
                    if slot.hasBuilding == false {
                        
                        let activeBuilding = board.boardSlots.index(of: slot)
                        playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].layer.borderColor = UIColor.black.cgColor
                        playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].layer.borderWidth = 1
                        for view in playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].subviews { view.removeFromSuperview() }
                       
                    }
          
                }
            }
            buildingSelected = false
    }
  

    }
    
    @IBAction func takeWood(_ sender: UIButton) {
        let thisBuilding = sender.superview as! Building
        let views = thisBuilding.subviews
        
        for view in views {
            view.removeFromSuperview()
        }
        sender.tag = 0
        
        let row = thisBuilding.superview as! UIStackView
        let woodTaken = row.arrangedSubviews.index(of: thisBuilding)! + (5*row.tag)
        player.myPlayerBoards[0].boardSlots[woodTaken].hasBuilding = false
        
        self.takeResource(sender)
    }
    
    @IBAction func takePeat(_ sender: UIButton) {
        let thisBuilding = sender.superview as! Building
        let views = thisBuilding.subviews
        for view in views {
            view.removeFromSuperview()
        }
        sender.tag = 4
        
        let row = thisBuilding.superview as! UIStackView
        let peatTaken = row.arrangedSubviews.index(of: thisBuilding)! + (5*row.tag)
        player.myPlayerBoards[0].boardSlots[peatTaken].hasBuilding = false

        self.takeResource(sender)
        
    }
    
    func takeGrain() {
        let button = UIButton()
        button.tag = 2
        
        self.takeResource(button)
    }
    
    func takeLivestock() {
        let button = UIButton()
        button.tag = 3
        
        self.takeResource(button)
    }
    
    func checkPlacementAvailability() {
        for board in player.myPlayerBoards {
            
            for slot in board.boardSlots {
                
                if slot.hasBuilding == false {

                    let activeBuilding = board.boardSlots.index(of: slot)
                    playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].layer.borderColor = UIColor.blue.cgColor
                    playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].layer.borderWidth = 3
                    
                    let button = UIButton(frame: CGRect(x:0, y:0, width:playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].frame.width, height:playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].frame.height))
                    button.addTarget(self, action: #selector(addBuildingToPlayerBoard(_:)), for: .touchUpInside)
                    playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].addSubview(button)
                
                }
                
            }
        }
    }
    
    
    
    func setPurchaseDisplay(phase: String) {
        
        let buildingRows = [buildingRow0, buildingRow1, buildingRow2, buildingRow3]
        
        
        var i = 0
        var j = 0
        for building in buildingDB.buildingList {
            if (i > 4) {
                j += 1
                i = 0
            }
            let phaseIndex = BuildingDB.BuildingFields.phase.rawValue
            let name = BuildingDB.BuildingFields.name.rawValue
            let function = BuildingDB.BuildingFields.function.rawValue
            
            if building[phaseIndex] == phase {
                let text = building[name]
                let desc = building[function]
                let index = (i+1)*(j+1)
                let newBuilding = Building(frame:CGRect(x:0, y:0, width: 38, height: 45))
                
                newBuilding.setupBuilding(buildingName: text, description: desc, tag: index)
                newBuilding.layer.borderWidth = 1
                newBuilding.layer.borderColor = UIColor.black.cgColor
                
                //Add constraints
                newBuilding.translatesAutoresizingMaskIntoConstraints = false
                newBuilding.heightAnchor.constraint(equalToConstant: 45).isActive = true
                newBuilding.widthAnchor.constraint(equalToConstant: 38).isActive = true
                
                // Add event for when this building is clicked.
                newBuilding.button.tag = i
                newBuilding.button.addTarget(self, action: #selector(purchaseBuilding(_:)),  for: .touchUpInside)
                
                buildingRows[j]?.addArrangedSubview(newBuilding)
                i += 1
                purchaseDisplay.currentBuildingList.append(building as! [String])
            }
            buildingRows[j]?.addArrangedSubview(Building(frame:CGRect(x:0, y:0, width: 38, height: 45)))
        
        }
        
    }
    
    
    func setHeartland() {
        let farmyard = playerBoardView.buildingRows[1].arrangedSubviews[2] as! Building
        let office = playerBoardView.buildingRows[1].arrangedSubviews[4] as! Building
        let clayMound = playerBoardView.buildingRows[0].arrangedSubviews[4] as! Building
        let forest01 = playerBoardView.buildingRows[0].arrangedSubviews[1] as! Building
        let forest02 = playerBoardView.buildingRows[0].arrangedSubviews[2] as! Building
        let forest03 = playerBoardView.buildingRows[1].arrangedSubviews[1] as! Building
        let peat01 = playerBoardView.buildingRows[1].arrangedSubviews[0] as! Building
        let peat02 = playerBoardView.buildingRows[0].arrangedSubviews[0] as! Building
        farmyard.button.addTarget(self, action: #selector(farmyard(_:)), for: .touchUpInside)
        office.button.addTarget(self, action: #selector(takeCoin(_:)), for: .touchUpInside)
        clayMound.button.addTarget(self, action: #selector(takeClay(_:)), for: .touchUpInside)
        forest01.button.addTarget(self, action: #selector(takeWood(_:)), for: .touchUpInside)
        forest02.button.addTarget(self, action: #selector(takeWood(_:)), for: .touchUpInside)
        forest03.button.addTarget(self, action: #selector(takeWood(_:)), for: .touchUpInside)
        peat01.button.addTarget(self, action: #selector(takePeat(_:)), for: .touchUpInside)
        peat02.button.addTarget(self, action: #selector(takePeat(_:)), for: .touchUpInside)


    }
    
    @IBAction func farmyard(_ sender: UIButton) {
        let alert = UIAlertController(title: "Farmyard", message: "Take Grain or Livestock?", preferredStyle: .alert)
        let takeGrain = UIAlertAction(title: "Take Grain", style: .default, handler: {(sender: UIAlertAction!) in self.takeGrain()})
        let takeLivestock = UIAlertAction(title: "Take Livestock", style: .default, handler: {(sender: UIAlertAction!) in self.takeLivestock()})
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(takeGrain)
        alert.addAction(takeLivestock)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func takeCoin(_ sender: UIButton) {
        sender.tag = 5
        self.takeResource(sender)
    }
    @IBAction func takeClay(_ sender: UIButton) {
        sender.tag = 1
        self.takeResource(sender)
    }
    
    @IBAction func nextPhase(_ sender: UIButton) {
        
        for view in buildingRow0.arrangedSubviews {
            //if view.subviews.isEmpty == true {
            view.removeFromSuperview()
            //}
        }
        for view in buildingRow1.arrangedSubviews {
            // if view.subviews.isEmpty == true {
            view.removeFromSuperview()
            //}
        }
        for view in buildingRow2.arrangedSubviews {
            // if view.subviews.isEmpty == true {
            view.removeFromSuperview()
            //}
        }
        for view in buildingRow3.arrangedSubviews {
           //  if view.subviews.isEmpty == true {
            view.removeFromSuperview()
            //}
        }
        
        setPurchaseDisplay(phase: "1")   // Need Game Manager class to send in the Phase number to setPurchaseDisplay
        
    }
    
    @IBAction func addBuildingToPlayerBoard(_ sender: UIButton) {
        
        let (buildingID, buildingDescription) = buildingDB.getBuildingInfo(name: currentlySelectedBuilding)
        
        let newBuilding = Building(frame: sender.frame, buildingName: currentlySelectedBuilding, description: buildingDescription, tag: 4)
        sender.addSubview(newBuilding)
        
        
        for board in player.myPlayerBoards {
                //print(board)
            for slot in board.boardSlots {
                print(slot.buildingID)
                
                if slot.hasBuilding == false {
                    
                    let activeBuilding = board.boardSlots.index(of: slot)
                    playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].layer.borderColor = UIColor.black.cgColor
                    playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].layer.borderWidth = 1
                    for view in playerBoardView.buildingRows[activeBuilding!/5].arrangedSubviews[activeBuilding!%5].subviews {
                        if view == sender  {
                            slot.hasBuilding = true
                            let (thisID, _) = buildingDB.getBuildingInfo(name: currentlySelectedBuilding)
                            slot.buildingID = thisID
                        } else {
                               view.removeFromSuperview()
                        }
                    }
                    
                }}}
     
        selectedPurchaseButton.superview!.layer.borderWidth = 0
        for view in selectedPurchaseButton.superview!.subviews {
            view.removeFromSuperview()
        }
        
        buildingSelected = false
        
        }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.playerBoardWindow)
        if let view = recognizer.view {
            
            
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
            
            
            
            if view.tag == 1 || view.tag == 2 {
                checkForDragOverlap(sender: recognizer.view as! UIButton)
                if recognizer.state == UIGestureRecognizerState.ended {
                    if view.tag == 2 {view.center = CGPoint(x:670, y:272) }
                    else if view.tag == 1 {view.center = CGPoint(x:670, y:209)}
                    let label = view.subviews[0] as! UILabel
                    let labelValue = Int(label.text!)! + 1
                    label.text = String(describing: labelValue)
                    for zone in playerBoardView.subviews {
                        if !(zone is UIStackView) {
                        zone.isHidden = true
                        }
                    }
                    
                }
                
            }
            
        }
        recognizer.setTranslation(CGPoint.zero, in: self.playerBoardWindow)

    }
    
    
    @IBAction func pickupDistrict(_ sender: UIButton) {
        let value = sender.subviews[0] as! UILabel
        var valueInt = Int(value.text!)
        valueInt! -= 1
        value.text = String(describing: valueInt!)
        for zone in playerBoardView.subviews {
            if zone.tag == sender.tag {
                zone.isHidden = false
            }
        }
    }
    
    func checkForDragOverlap(sender: UIButton) {
        for zone in playerBoardView.subviews {
            let absFrame = self.view.convert(zone.frame, from:playerBoardView)
            for subview in zone.subviews {
                if zone.tag == 2 && zone.superview == playerBoardView {
                subview.layer.borderWidth = 0
                }
            }
            if !(zone is UIStackView) && zone.superview == playerBoardView {
                if zone.isHidden == false {
                    //if sender.frame.intersects(absFrame) {
                    if absFrame.contains(sender.center) {
                        if zone.tag == 2 {
                            for subview in zone.subviews {
                            subview.layer.borderColor = UIColor.blue.cgColor
                            subview.layer.borderWidth = 3
                            }
                            
                        }
                        else {
                        zone.layer.borderColor = UIColor.blue.cgColor
                        zone.layer.borderWidth = 3
                        }
                    }
                    else {
                        zone.layer.borderWidth = 0
                    }
                }
            }
        }
    }
    
}


