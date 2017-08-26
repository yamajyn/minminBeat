//
//  CicadaButton.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/23.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit

class CicadaButtons:SKNode,ButtonTappedDelegate{
    
    private var buttons : [SKButton] = []
    
    init(size:CGSize) {
        super.init()
        //Create cicadaButton
        for i in 0...4{
            let buttonSize = CGSize(width: size.width / 7, height: size.width / 7)
            let interval = (size.width - buttonSize.width) / 4
            let x = CGFloat(i) * interval
            self.buttons.append(SKButton(x: x,y:0,imageNamed: "semi0" + String(i+1)))
            buttons[i].tapDelegate = self
            buttons[i].button.size = buttonSize
            self.addChild(buttons[i])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func buttonTapBegan(_ name: String) {
        print(name)
    }
}
