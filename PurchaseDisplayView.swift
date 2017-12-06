//
//  PurchaseDisplay.swift
//  OraLabora2
//
//  Created by Nathan Tompkins on 10/27/17.
//  Copyright © 2017 Nathan Tompkins. All rights reserved.
//

import UIKit

@IBDesignable class PurchaseDisplayView: UIView {
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    
    }

    
    // MARK: Properties
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            layer.borderWidth = 1
        }
    }
    
    
    // MARK: Private Methods
    
}
