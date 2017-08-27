//
//  SKButton.swift
//  Uteshimu
//
//  Created by 山本隼也 on 2016/10/11.
//  Copyright © 2016年 Yama. All rights reserved.
//

import SpriteKit

class SKButton : SKNode{
    
    weak var tapDelegate: ButtonTappedDelegate!
    
    var button:SKSpriteNode
    var onButton:SKTexture? //offの状態のテクスチャを変えたい時設定しておく
    var offButton:SKTexture?
    var value = false
    var touchedPos:CGPoint?
    var flicked = false
    
    override init(){
        button = SKSpriteNode()
        super.init()
    }
    
    internal init(size: CGSize,imageNamed: String) {
        button = SKSpriteNode(imageNamed: imageNamed)
        offButton = button.texture!
        super.init()
        self.isUserInteractionEnabled = true
        self.addChild(button)
        self.name = imageNamed
        self.button.size = size
        self.button.position = CGPoint(
            x: self.button.size.width / CGFloat(2),
            y: self.button.size.height / CGFloat(2)
        )
    }
    
    convenience init(size: CGSize, offTexture:String,onTexture: String){
        self.init(size:size, imageNamed:offTexture)
        self.onButton = SKTexture(imageNamed: onTexture)
        self.button.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchedPos = touch.location(in: self)
        }
        valueSwich()
        if value{
            if let onButton = onButton{
                button.texture = onButton
            }else{
                let action = SKAction.scale(to: 0.9, duration: 0.03)
                button.run(action)
            }
        }else{
            if let offButton = offButton{
                button.texture = offButton
            }
            if onButton == nil{
                let action = SKAction.scale(to: 1.0, duration: 0.03)
                button.run(action)
            }
        }
        //tapDelegate.buttonTapBegan!(self.name!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if let touched = self.touchedPos{
                let dist = touch.location(in: self).y - touched.y
                if dist < -20{
                    tapDelegate.buttonFlicked!(self.name!)
                    self.touchedPos = nil
                    self.flicked = true
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !flicked{
            tapDelegate.buttonTapEnded?(self.name!)
        }
        flicked = false
    }
    
    func valueSwich(){
        self.value = !self.value
    }
}


