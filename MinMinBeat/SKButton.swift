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
    var onButton:SKTexture?
    var offButton:SKTexture?
    
    internal init(imageNamed: String) {
        button = SKSpriteNode(imageNamed: imageNamed)
        offButton = button.texture!
        super.init()
        self.isUserInteractionEnabled = true
        self.addChild(button)
        self.name = imageNamed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let onButton = onButton{
            button.texture = onButton
        }
        tapDelegate.buttonTapBegan(self.name!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let offButton = offButton{
            button.texture = offButton
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
