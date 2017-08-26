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



class GameScene: SKScene{
    
    private let center = NotificationCenter.default
    var ble : BluetoothLE!
    var cicadaBlock : CicadaBlock?
    var sendData : Data?
    var cicadas : CicadaButtons?
    
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
        }
        
        //Create cicadaButtons
        cicadas = CicadaButtons(size: CGSize(width: len * 0.8, height: 100))
        if let cicadas = cicadas{
            cicadas.position = CGPoint(x: len / 10, y: 100)
            self.addChild(cicadas)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if let posData  = self.cicadaBlock!.posData {
            let array : [UInt8] = [UInt8(posData.x),UInt8(posData.y)]
            self.sendData = Data(bytes: array)
            if let d = self.sendData{
                ble.update(data:d)
                printBytes(bytes: array)
                
            }
        }
    }
    
    func printBytes(bytes:[UInt8]){
        let hexStr = Data(bytes: bytes).map {
            String(format: "%.2hhx", $0)
            }.joined()
        print(hexStr)
    }
    
    
    
}
