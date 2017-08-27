//
//  GameScene.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene,ButtonTappedDelegate,PadTappedDelegate{
    
    
    var cicadaBlock : CicadaBlock?
    private var buttons : [SKButton] = []
    var count = 0
    
    var last: CFTimeInterval!
    var current: CFTimeInterval!
    
    let ble = BluetoothLE()
    
    
    override func didMove(to view: SKView) {
        
        //Create cicadaBlock node
        let len = self.size.width
        self.cicadaBlock = CicadaBlock(
            size: CGSize(width:len * 0.8,height:len * 0.8),
            valueRange: CGPoint(x:255,y:255)
        )
        if let block = self.cicadaBlock{
            block.position = CGPoint(x: self.size.width / 10, y: self.size.height / 3)
            self.addChild(block)
            block.padDelegate = self
        }
        
        //Create cicadaButton
        for i in 0...4{
            let buttonSize = CGSize(width: len * 9 / 50, height: len * 9 / 50)
            let interval = (len * 0.9 - buttonSize.width) / 4
            let x = len / 20 + CGFloat(i) * interval
            self.buttons.append(SKButton(size:buttonSize, imageNamed: "semi0" + String(i+1)))
            buttons[i].position = CGPoint(x:x,y:100)
            buttons[i].tapDelegate = self
            self.addChild(buttons[i])
        }
    }
    
    func buttonTapBegan(_ name: String) {
        ble.nameToUInt8(name: name)
    }
    
    func padTap() {
        //タップした位置データ取得
        if let posData  = self.cicadaBlock!.posData {
            //位置データをDataに変換
            if !(last != nil) {
                last = current
            }
            if last + 0.1 <= current{
                self.ble.posDataToUInt8(posData: posData)
                last = current
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        current = currentTime
    }
    
}
