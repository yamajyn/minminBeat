//
//  CicadaButton.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/23.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit

class CicadaButton:SKSpriteNode{
    
    let onTexture : SKTexture
    let offTexture : SKTexture
    
    init(index : Int, imageNamed : String, size:CGSize){
        self.onTexture = SKTexture(imageNamed: imageNamed + "_on")
        self.offTexture = SKTexture(imageNamed: imageNamed + "_off")
        super.init(texture: self.offTexture, color: UIColor.blue, size:size)
        self.isUserInteractionEnabled = true
        self.name = String(index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches{
            self.texture = onTexture
        }
        if let name = self.name{
            print(name)
            NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches{
            self.texture = offTexture
        }
    }
    
}
