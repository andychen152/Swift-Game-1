//
//  MLMovingGround.swift
//  Nimble Ninja
//
//  Created by andy chen on 8/10/15.
//  Copyright (c) 2015 AndyChen. All rights reserved.
//

import Foundation
import SpriteKit

class MLMovingGround: SKSpriteNode {
    
    let number_of_segments = 20
    let color_one = UIColor(red: 34.0/255.0, green: 139.0/255.0, blue: 34.0/255.0, alpha: 1.0)  //forest green
    let color_two = UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)   // lighter shade of green
    
    
    
    init(size: CGSize){
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0.0, 0.5)
        
        for var i = 0; i < number_of_segments; i++ {
            var segmentColor: UIColor!
            if i%2 == 0{
                segmentColor = color_one
            }
            else {
                segmentColor = color_two
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(number_of_segments), self.size.height))
            segment.anchorPoint = CGPointMake(0.0, 0.5)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
            
        }
        
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        
        let adjustedDuration = NSTimeInterval(frame.size.width / kDefaultXToMoverPerSecond)
        
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0.0, duration: adjustedDuration/2)
        let resetPosition = SKAction.moveToX(0.0, duration: 0.0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stop() {
        removeAllActions()
    }

}
