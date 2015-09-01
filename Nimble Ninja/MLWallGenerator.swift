//
//  MLWallGenerator.swift
//  Nimble Ninja
//
//  Created by andy chen on 8/11/15.
//  Copyright (c) 2015 AndyChen. All rights reserved.
//

import Foundation
import SpriteKit

class MLWallGenerator: SKSpriteNode{
    
    var generationTimer: NSTimer?
    var walls = [MLWall]()
    
    func startGeneratingWallsEvery(seconds: NSTimeInterval){
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    }
    
    func stopGenerating(){
        generationTimer?.invalidate()
    }
    
    func generateWall(){
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0{
            scale = -1.0
        }else{
            scale = 1.0
        }
        
        let wall = MLWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kMLGroundHeight/2 + wall.size.height/2)
        walls.append(wall)
        addChild(wall)
    }
    
    func stopWalls(){
        stopGenerating()
        for wall in walls {
            wall.stopMoving()
        }
    }
    
}
