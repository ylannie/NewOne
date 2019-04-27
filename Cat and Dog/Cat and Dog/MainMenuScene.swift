//
//  MainMenuScene.swift
//  Cat and Dog
//
//  Created by 程明卓 on 4/25/19.
//  Copyright © 2019 程明卓. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode()
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundColor = SKColor.blue
        addChild(background)
    }
    
    func sceneTapped(){
        let myscene = GameScene(size: size)
        myscene.scaleMode = scaleMode
        let reveal = SKTransition.fade(withDuration: 0.5)
        view?.presentScene(myscene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneTapped()
    }

}
