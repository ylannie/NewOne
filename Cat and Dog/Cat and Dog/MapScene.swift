//
//  MapScene.swift
//  Cat and Dog
//
//  Created by 程明卓 on 4/27/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import SpriteKit
import UIKit

class MapScene: SKScene{
    
    let returnIcon = SKShapeNode(rect: CGRect(origin: CGPoint(x: 100, y: playableRect.minY + 100), size: CGSize(width: 100, height: 100)))
    let returnLabel = SKLabelNode()
    var villageIcon = SKShapeNode()
    var caveIcon = SKShapeNode()
    var forestIcon = SKShapeNode()
    var gameScene: SKScene
    var reveal: SKTransition
    
    override init(size: CGSize) {
        gameScene = GameScene(size: size)
        reveal = SKTransition.fade(withDuration: 0.5)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        shapUI()
    }
    
    func shapUI(){
        
        backgroundColor = SKColor.white
        
        returnLabel.position = CGPoint(x: 100, y: playableRect.minY + 300)
        returnLabel.text = "RETURN"
        returnLabel.fontSize = 100
        returnLabel.fontColor = SKColor.brown
        returnLabel.horizontalAlignmentMode = .left
        returnLabel.verticalAlignmentMode = .top
        addChild(returnLabel)
        
        returnIcon.zPosition = 10
        returnIcon.lineWidth = 4.0
        returnIcon.strokeColor = SKColor.black
        addChild(returnIcon)
        
        villageIcon = SKShapeNode(rect: CGRect(origin: CGPoint(x: 300, y: size.height/2), size: CGSize(width: 300, height: 200)))
        villageIcon.fillColor = SKColor.gray
        addChild(villageIcon)
        let villageLabel = SKLabelNode(text: "Get food from village")
        villageLabel.position = CGPoint(x:300, y: size.height/2 - 50)
        villageLabel.fontColor = SKColor.black
        villageLabel.fontSize = 50
        villageLabel.horizontalAlignmentMode = .left
        villageLabel.verticalAlignmentMode = .bottom
        villageLabel.zPosition = 100
        addChild(villageLabel)
        
        caveIcon = SKShapeNode(rect: CGRect(origin: CGPoint(x: 900, y: size.height/2), size: CGSize(width: 300, height: 200)))
        caveIcon.fillColor = SKColor.brown
        addChild(caveIcon)
        let caveLabel = SKLabelNode(text: "Get stone from cave")
        caveLabel.position = CGPoint(x:900, y: size.height/2 - 50)
        caveLabel.fontColor = SKColor.black
        caveLabel.fontSize = 50
        caveLabel.horizontalAlignmentMode = .left
        caveLabel.verticalAlignmentMode = .bottom
        caveLabel.zPosition = 100
        addChild(caveLabel)
        
        forestIcon = SKShapeNode(rect: CGRect(origin: CGPoint(x: 1500, y: size.height/2), size: CGSize(width: 300, height: 200)))
        forestIcon.fillColor = SKColor.green
        addChild(forestIcon)
        let forestLabel = SKLabelNode(text: "Get woods from forest")
        forestLabel.position = CGPoint(x:1500, y: size.height/2 - 50)
        forestLabel.fontColor = SKColor.black
        forestLabel.fontSize = 50
        forestLabel.horizontalAlignmentMode = .left
        forestLabel.verticalAlignmentMode = .bottom
        forestLabel.zPosition = 100
        addChild(forestLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        if touchLocation.x >= 100 &&
           touchLocation.x <= 200 &&
           touchLocation.y >= playableRect.minY + 100 &&
           touchLocation.y <= playableRect.minY + 200{
            
            removeAllChildren()
            gameScene.scaleMode = scaleMode
            view?.presentScene(gameScene, transition: reveal)
        }
        
        if touchLocation.x >= 300 &&
           touchLocation.x <= 600 &&
           touchLocation.y >= size.height/2 &&
           touchLocation.y <= size.height/2 + 200{
            days += 1
            food += 100
            print("You get 100 food")
            
            removeAllChildren()
            gameScene.scaleMode = scaleMode
            view?.presentScene(gameScene, transition: reveal)
        }
        
        if touchLocation.x >= 900 &&
            touchLocation.x <= 1200 &&
            touchLocation.y >= size.height/2 &&
            touchLocation.y <= size.height/2 + 200{
            days += 1
            stone += 100
            print("You get 100 stone")
            
            removeAllChildren()
            gameScene.scaleMode = scaleMode
            view?.presentScene(gameScene, transition: reveal)
        }
        
        if touchLocation.x >= 1500 &&
            touchLocation.x <= 1800 &&
            touchLocation.y >= size.height/2 &&
            touchLocation.y <= size.height/2 + 200{
            days += 1
            woods += 100
            print("You get 100 woods")
            
            removeAllChildren()
            gameScene.scaleMode = scaleMode
            view?.presentScene(gameScene, transition: reveal)
        }
    }
    
}
