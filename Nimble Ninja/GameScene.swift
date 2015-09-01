//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by andy chen on 7/23/15.
//  Copyright (c) 2015 AndyChen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: MLMovingGround!
    var hero: MLHero!
    var cloudGenrator: MLCloudGenerator!
    var wallGenerator: MLWallGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        
        /*
        //add volcano background
        let backgroundTexture = SKTexture(imageNamed: "VOlcano.jpg")
        let backgroundImage = SKSpriteNode(texture: backgroundTexture, size: view.frame.size)
        backgroundImage.position = view.center
        addChild(backgroundImage)
        */
        addMovingGround()
        addHero()
        addCloudGenerator()
        addWallGenerator()
        addStartLabel()
        addPointsLabels()
        addPhysicsWorld()
    }
    
    func addMovingGround(){
        movingGround = MLMovingGround(size: CGSizeMake(view!.frame.width, kMLGroundHeight))
        movingGround.position = CGPointMake(0, view!.frame.size.height/2)
        addChild(movingGround)
    }
    
    func addHero(){
        hero = MLHero()
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
    }
    
    func addCloudGenerator(){
        cloudGenrator = MLCloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGenrator.position = view!.center
        addChild(cloudGenrator)
        cloudGenrator.populate(7)
        cloudGenrator.startGeneratingWithSpawnTime(5)
    }
    
    func addWallGenerator(){
        wallGenerator = MLWallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
    }
    
    func addStartLabel(){
        let tapToStart = SKLabelNode(text: "Tap To Start")
        tapToStart.name = "tapToStart"
        tapToStart.position = CGPointMake(view!.center.x, view!.center.y + 40)
        tapToStart.fontName = "Helvetica"
        tapToStart.fontColor = UIColor.blackColor()
        tapToStart.fontSize = 22.0
        addChild(tapToStart)
        //tapToStart.runAction(blinkAnimation())
    }
    
    func addPointsLabels(){
        let pointsLabel = MLPointsLabel(num: 0)
        pointsLabel.position = CGPointMake(20.0, view!.frame.size.height - 35)
        pointsLabel.name = "pointsLabel"
        addChild(pointsLabel)
        
        let highscoreLabel = MLPointsLabel(num: 0)
        highscoreLabel.position = CGPointMake(view!.frame.size.width-20, view!.frame.size.height - 35)
        highscoreLabel.name = "highscoreLabel"
        addChild(highscoreLabel)
        
        let highscoreTextLabel = SKLabelNode(text: "High")
        highscoreTextLabel.fontColor = UIColor.blackColor()
        highscoreTextLabel.fontSize = 14.0
        highscoreTextLabel.fontName = "Helvetica"
        highscoreTextLabel.position = CGPointMake(0, -30)
        highscoreLabel.addChild(highscoreTextLabel)
    }
    
    func addPhysicsWorld(){
         physicsWorld.contactDelegate = self
    }
    
    func start(){
        let tapToStart = childNodeWithName("tapToStart")
        tapToStart?.removeFromParent()
        
        isStarted = true
        hero.stop()
        hero.startRunning()
        movingGround.start()
        wallGenerator.startGeneratingWallsEvery(0.1575)   // 1.0 second
        
    }
    
    func gameOver(){
        isGameOver = true
        
        //stop everything
        hero.fall()
        wallGenerator.stopWalls()
        movingGround.stop()
        hero.stop()
        
        //create game over label
        let GameOverLabel = SKLabelNode(text: "Game Over")
        GameOverLabel.fontColor = UIColor.redColor()
        GameOverLabel.fontName = "Helvetica"
        GameOverLabel.position.x = view!.center.x
        GameOverLabel.position.y = view!.center.y + 40
        GameOverLabel.fontSize = 22.0
        addChild(GameOverLabel)
        //GameOverLabel.runAction(blinkAnimation())
        
    }
    
    func restart(){
        cloudGenrator.stopGenerating()
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        view!.presentScene(newScene)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if isGameOver{
            restart()
        }else if !isStarted{
            start()
        }else{
            hero.flip()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        if wallGenerator.wallTrackers.count > 0 {
            /* Called before each frame is rendered */
            let wall = wallGenerator.wallTrackers[0] as MLWall
            
            let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
            if wallLocation.x < hero.position.x {
                wallGenerator.wallTrackers.removeAtIndex(0)
                let pointsLabel = childNodeWithName("pointsLabel") as! MLPointsLabel
                pointsLabel.increment()
            }
        }
    }
    
    // touching detenction
    func didBeginContact(contact: SKPhysicsContact) {
        if !isGameOver{
            gameOver()
        }
    }
    
    //Animation
    func blinkAnimation() -> SKAction{
        let duration = 0.4
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatActionForever(blink)
        
    }
}

