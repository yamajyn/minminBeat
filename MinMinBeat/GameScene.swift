//
//  GameScene.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    public var cicadaBlock : CicadaBlock?
    
    
    override func didMove(to view: SKView) {
        
        //Create cicadaBlock node
        let len = self.size.width * 0.8
        self.cicadaBlock = CicadaBlock(length:len)
        
        if let block = self.cicadaBlock{
            block.position = CGPoint(x: self.size.width / 10, y: self.size.height / 3)
            self.addChild(block)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
