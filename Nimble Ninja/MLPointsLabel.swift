//
//  MLPointsLabel.swift
//  Nimble Ninja
//
//  Created by andy chen on 8/30/15.
//  Copyright (c) 2015 AndyChen. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MLPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.blackColor()
        fontName = "Helvetica"
        fontSize = 24.0
        
        number = num
        text = "\(num)"
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func increment(){
        number++
        text = "\(number)"
    }
    
    func setTo(number: Int){
        self.number = number
        text = "\(self.number)"
        
    }
    
}