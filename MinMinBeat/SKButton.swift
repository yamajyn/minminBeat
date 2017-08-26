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
    var onButton:SKTexture?//offの状態のテクスチャを変えたい時設定しておく
    var offButton:SKTexture?
    
    internal init(imageNamed: String) {
        button = SKSpriteNode(imageNamed: imageNamed)
        offButton = button.texture!
        super.init()
        self.isUserInteractionEnabled = true
        self.addChild(button)
        self.name = imageNamed
    }
    
    convenience init(x: CGFloat, y: CGFloat, imageNamed: String){
        self.init(imageNamed:imageNamed)
        self.position = CGPoint(x: x + self.button.size.width / 2, y: y + self.button.size.height / 2)
    }
    
    convenience init(x: CGFloat, y: CGFloat, offTexture:String,onTexture: String){
        self.init(imageNamed:offTexture)
        self.onButton = SKTexture(imageNamed: onTexture)
        self.position = CGPoint(x: x + self.button.size.width / 2, y: y + self.button.size.height / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let onButton = onButton{
            button.texture = onButton
        }else{
            let action = SKAction.scale(to: 0.9, duration: 0.03)
            button.run(action)
        }
        tapDelegate.buttonTapBegan(self.name!)
        print("touched")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let offButton = offButton{
            button.texture = offButton
        }
        if onButton == nil{
            let action = SKAction.scale(to: 1.0, duration: 0.03)
            button.run(action)
        }
        tapDelegate.buttonTapEnded?(self.name!)
    }
}

@objc protocol ButtonTappedDelegate : class {
    //Buttonクラスでタッチされた
    func buttonTapBegan(_ name:String)
    @objc optional func buttonTapEnded(_ name:String)
    @objc optional func buttonTapCancelled(_ name:String)
}
