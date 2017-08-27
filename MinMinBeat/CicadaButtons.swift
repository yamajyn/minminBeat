//
//  CicadaButtons.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/27.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit


class CicadaButtons : SKNode{
    
    
    public var buttons : [[SKButton]] = [[]]
    
    private let buttonNames = ["semi","track","sample","recLength"]
    
    public var muteMark:[SKSpriteNode] = []
    
    init(w:Int, h:Int, size:CGSize, position: CGPoint){
        super.init()
        self.position = position
        self.zPosition = 10
        let width = size.width
        let height = size.height
        for i in 0...h-1{
            self.buttons.append([])
            for j in 0...w-1{
                let buttonSize = CGSize(width: width * 9 / 50, height: width * 9 / 50)
                let intervalW = buttonSize.width  + width / 20
                let intervalH = height / 4
                self.buttons[i].append(SKButton(size:buttonSize, imageNamed: buttonNames[h-1-i] + String(j)))
                let xPos = CGFloat(j) * intervalW
                let yPos = height / 10 + CGFloat(i) * intervalH
                buttons[i][j].position.x = xPos
                buttons[i][j].position.y = yPos
                self.addChild(buttons[i][j])
                if i == 2{
                    muteMark.append(SKSpriteNode(imageNamed:"mute"))
                    muteMark[j].position.x = xPos + buttonSize.width / 2
                    muteMark[j].position.y = yPos + buttonSize.height * 1.3
                    muteMark[j].size = CGSize(
                        width: buttonSize.width * 0.3,
                        height: buttonSize.height * 0.3
                    )
                    self.muteMark[j].alpha = 0.0
                    self.addChild(muteMark[j])
                }
            }
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
