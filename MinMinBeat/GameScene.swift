//
//  GameScene.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreBluetooth



class GameScene: SKScene,ButtonTappedDelegate,PadTappedDelegate{
    
    private let center = NotificationCenter.default
    var ble : BluetoothLE!
    var cicadaBlock : CicadaBlock?
    var sendData : Data?
    private var buttons : [SKButton] = []
    
    override func didMove(to view: SKView) {
        
        //initialize ble
        ble = BluetoothLE()
        
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
        if let data = name.data(using: .utf8){
        ble.update(data: data)
        }
    }
    
    func padTap() {
        //タップした位置データ取得
        if let posData  = self.cicadaBlock!.posData {
            //位置データをDataに変換
            let array : [UInt8] = [UInt8(posData.x),UInt8(posData.y)]
            self.sendData = Data(bytes: array)
            if let d = self.sendData{
                ble.update(data:d)
                printBytes(bytes: array)
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func printBytes(bytes:[UInt8]){
        let hexStr = Data(bytes: bytes).map {
            String(format: "%.2hhx", $0)
            }.joined()
        print(hexStr)
    }
    
}
