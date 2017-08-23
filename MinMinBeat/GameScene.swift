//
//  GameScene.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    private var cicadaBlock : CicadaBlock?
    private var cicadaButton : [CicadaButton] = []
    
    
    override func didMove(to view: SKView) {
        
        //Create cicadaBlock node
        let len = self.size.width * 0.8
        self.cicadaBlock = CicadaBlock(
            size: CGSize(width:len,height:len),
            valueRange: CGPoint(x:100,y:100)
        )
        if let block = self.cicadaBlock{
            block.position = CGPoint(x: self.size.width / 10, y: self.size.height / 3)
            self.addChild(block)
        }
        
        cicadaButton = [
            CicadaButton(
                index:1,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:2,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:3,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:4,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:5,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            )
        ]
        for i in 0...4{
            cicadaButton.append(CicadaButton(
                index:i+1,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ))
            cicadaButton[i].position = CGPoint(x: 100 + i * 150, y: 200)
            self.addChild(cicadaButton[i])
        }

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
