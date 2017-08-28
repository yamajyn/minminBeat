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
    
    private let buttonNames = ["semi","sample","track"]
    
    public var muteMark:[SKSpriteNode] = []
    private let muteMarkPos:Int = 1
    
    init(w:Int, h:Int, size:CGSize, position: CGPoint){
        super.init()
        self.position = position
        self.zPosition = 10
        let width = size.width
        let height = size.height
        let buttonSize = CGSize(width: width * 9 / 50, height: width * 9 / 50)
        let intervalW = buttonSize.width  + width / 20
        let intervalH = height / 5
        for i in 0...h-1{
            self.buttons.append([])
            for j in 0...w-1{
                let xPos = CGFloat(j) * intervalW
                var yPos:CGFloat
                //ミュートボタン
                if(i == 0){
                    self.buttons[i].append(
                        SKButton(size: buttonSize, offTexture: "mute_off", onTexture: "mute_on")
                    )
                    self.buttons[i][j].name = "mutetrack" + String(j)
                    yPos = CGFloat(i+1) * intervalH - size.height / 10
                }else{
                    //それ以外
                    self.buttons[i].append(SKButton(size:buttonSize, imageNamed: buttonNames[h-1-i] + String(j)))
                    yPos = CGFloat(i) * intervalH
                }
                buttons[i][j].position.x = xPos
                buttons[i][j].position.y = yPos
                self.addChild(buttons[i][j])
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
