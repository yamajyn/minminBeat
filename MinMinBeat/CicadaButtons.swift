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
                self.buttons[i].append(SKButton(size:buttonSize, imageNamed: "semi01"))
                buttons[i][j].position.x = CGFloat(j) * intervalW
                buttons[i][j].position.y = height / 10 + CGFloat(i) * intervalH
                self.addChild(buttons[i][j])
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
