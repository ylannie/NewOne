//
//  GameScene.swift
//  Cat and Dog
//
//  Created by 程明卓 on 4/25/19.
//  Copyright © 2019 程明卓. All rights reserved.
//
//  UIVIEW to SKview Center: (367, 206)
//  200 = 558
//  2.79

import SpriteKit
import UIKit

class GameScene: SKScene{
    
    let playableRect: CGRect
    var manRect: CGRect
    var itemRect: CGRect
    var mapRect: CGRect
    var itemBoxShowed = false
    let itemBox = SKShapeNode()

    var lastTouchPosition: CGPoint?
    var dt: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0

    override init(size:CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        manRect = CGRect(x: size.width/2, y: playableRect.minY + playableRect.height/2, width: 200, height: 200)
        itemRect = CGRect(x: 200, y: playableRect.minY + playableRect.height/10,
                         width: 100, height: 100)
        mapRect = CGRect(x: 400, y: playableRect.minY + playableRect.height/10,
                         width: 100, height: 100)
        
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode()
        backgroundColor = SKColor.white
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -10
        addChild(background)
        shapeUI()
        
    }
    
    func shapeUI(){
        let labelDays = SKLabelNode()
        labelDays.position = CGPoint(x: 50, y: 1300)
        labelDays.fontColor = SKColor.red
        labelDays.text = "Day: \(days)"
        labelDays.fontSize = 100
        labelDays.horizontalAlignmentMode = .left
        labelDays.verticalAlignmentMode = .top
        labelDays.zPosition = 100
        addChild(labelDays)
        
        let man = SKShapeNode()
        let manPath = CGMutablePath()
        manPath.addRect(manRect)
        man.path = manPath
        man.strokeColor = SKColor.red
        man.lineWidth = 4.0
        addChild(man)
        
        let itemIcon = SKShapeNode()
        let itemPath = CGMutablePath()
        itemPath.addRect(itemRect)
        itemIcon.path = itemPath
        itemIcon.strokeColor = SKColor.black
        itemIcon.lineWidth = 4.0
        itemIcon.zPosition = 10
        addChild(itemIcon)
        
        let itemBoxpath = CGMutablePath()
        itemBoxpath.addRect(CGRect(origin: CGPoint(x: size.width*(2.0/3.0), y: playableRect.minY),
                                   size: CGSize(width: size.width*(2.0/3.0), height: playableRect.height)))
        itemBox.path = itemBoxpath
        itemBox.zPosition = 10
        itemBox.strokeColor = SKColor.black
        itemBox.lineWidth = 4.0
        
        let itemLabel = SKLabelNode()
        itemLabel.text = "ITEM"
        itemLabel.fontColor = SKColor.black
        itemLabel.fontSize = 80
        itemLabel.zPosition = 150
        itemLabel.horizontalAlignmentMode = .left
        itemLabel.verticalAlignmentMode = .top
        itemLabel.position = CGPoint(
            x: 200,
            y: itemRect.height + playableRect.minY + playableRect.height/5)
        addChild(itemLabel)
        
        let mapVillage = SKShapeNode(rect: mapRect)
        mapVillage.fillColor = SKColor.blue
        mapVillage.zPosition = 10
        addChild(mapVillage)
        
        let labelMap = SKLabelNode()
        labelMap.text = "MAP"
        labelMap.fontColor = SKColor.black
        labelMap.fontSize = 80
        labelMap.zPosition = 150
        labelMap.horizontalAlignmentMode = .left
        labelMap.verticalAlignmentMode = .top
        labelMap.position = CGPoint(
            x: 400,
            y: mapRect.height + playableRect.minY + playableRect.height/5)
        addChild(labelMap)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }else{
            dt = 0
        }
        lastUpdateTime = currentTime
        
    }
    
    func itemIconTouched(){
        addChild(itemBox)
        itemBoxShowed = true
        for i in 1...6{
            for j in 1...10{
                let itemShapenode = SKShapeNode()
                let itemPath = CGMutablePath()
                let itemRect = CGRect(origin: CGPoint(x: size.width*(2.0/3.0) + CGFloat(50) + CGFloat((i-1) * (100)), y: playableRect.minY + CGFloat(50) + CGFloat((j-1) * 100)),
                                      size: CGSize(width: 70, height: 70))
                itemShapenode.name = "item"
                itemPath.addRect(itemRect)
                itemShapenode.path = itemPath
                itemShapenode.strokeColor = SKColor.brown
                itemShapenode.lineWidth = 4.0
                itemShapenode.zPosition = 20
                itemBox.addChild(itemShapenode)
            }
        }
    }
    
    func itemTouched(touchLoaction:CGPoint){
        var itemx: CGFloat = 0
        var itemy: CGFloat = 0
        var itemNum: CGFloat = 0
        var item: [CGFloat] = []
        
        for i in 1...60{
            item.append(CGFloat(i))
        }
        lastTouchPosition = touchLoaction
        for i in 1...6{
            if lastTouchPosition?.x ?? 0 >= size.width*(2.0/3.0) + CGFloat(50) + CGFloat((i-1) * (100))
                && lastTouchPosition?.x ?? 0 <= size.width*(2.0/3.0) + CGFloat(50) + CGFloat(i * (100)){
                itemx = CGFloat( i )
            }
        }
        for j in 1...10{
            if lastTouchPosition?.y ?? 0 >= playableRect.minY + CGFloat(50) + CGFloat((j-1) * 100) &&
                lastTouchPosition?.y ?? 0 <= playableRect.minY + CGFloat(50) + CGFloat(j * 100) {
                itemy = CGFloat( j )
            }
        }
        itemNum = 6 * (itemy - 1) + itemx - 1
        print("\(item[Int(itemNum)])")
    }
    
    func mapIconTouched(){
        let mapScene = MapScene(size: size)
        mapScene.scaleMode = scaleMode
        let reveal = SKTransition.fade(withDuration: 0.5)
        removeAllChildren()
        view?.presentScene(mapScene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        if itemBoxShowed{
            
        if (touchLocation.x <= size.width*(2.0/3.0)) {
            itemBox.removeAllChildren()
            itemBox.removeFromParent()
            itemBoxShowed = false
        }else{
            itemTouched(touchLoaction: touchLocation)
            }
            
        }else{
        
        if (touchLocation.x >= itemRect.minX &&
            touchLocation.x <= itemRect.maxX &&
            touchLocation.y >= itemRect.minY &&
            touchLocation.y <= itemRect.maxY) {
            itemIconTouched()
        }else{
            if(touchLocation.x >= mapRect.minX &&
               touchLocation.x <= mapRect.maxX &&
               touchLocation.y >= mapRect.minY &&
               touchLocation.y <= mapRect.maxY){
            mapIconTouched()
            }
            }

        }
        
    }

    
    
    
    
    
    
    
}
