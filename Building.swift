//
//  Building.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 10/23/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import UIKit

@IBDesignable class Building: UIView {
 
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            layer.borderWidth = 1
        }
    }
    
    let confirmButton = UIButton(frame:CGRect(x:40, y:20, width:80, height:20))
    let cancelButton = UIButton(frame:CGRect(x:140, y:20, width:80, height:20))
    let button = UIButton(frame:CGRect(x: 0, y:0, width:50, height: 50))
    
    let nameView = UILabel(frame:CGRect(x: 5, y: 0, width: 35, height: 30))
    let descView = UILabel(frame:CGRect(x: 5, y:10, width:35, height: 60))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBuilding(buildingName: "", description: "", tag: tag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBuilding(buildingName: "", description: "", tag: tag)

    }
    
    init (frame: CGRect, buildingName: String?, description: String?, tag: Int) {
        super.init(frame: frame)
        setupBuilding(buildingName: buildingName, description: description, tag: tag)
    }
    
    
    
    func setupBuilding(buildingName: String?, description: String?, tag: Int) {
        
        nameView.text = buildingName
        nameView.font = UIFont.systemFont(ofSize: 6)
        nameView.numberOfLines = 2
        nameView.textAlignment = NSTextAlignment.center
        
      
        descView.text = description
        descView.font = UIFont.systemFont(ofSize: 6)
        descView.numberOfLines = 4
        descView.textAlignment = NSTextAlignment.center
        
        button.tag = tag
    
        addSubview(nameView)
        addSubview(descView)
        addSubview(button)
    }
    

    
}
