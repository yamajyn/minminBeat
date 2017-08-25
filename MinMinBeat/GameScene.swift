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
    
    let center = NotificationCenter.default
    public var cicadaBlock : CicadaBlock?
    private var cicadaButton : [CicadaButton] = []
    let ble = BluetoothLE()
    
    var sendData:Data?
    
    
    
    override func didMove(to view: SKView) {
        
        //Create cicadaBlock node
        let len = self.size.width * 0.8
        self.cicadaBlock = CicadaBlock(
            size: CGSize(width:len,height:len),
            valueRange: CGPoint(x:255,y:255)
        )
        if let block = self.cicadaBlock{
            block.position = CGPoint(x: self.size.width / 10, y: self.size.height / 3)
            self.addChild(block)
        }
        
        cicadaButton = [
            CicadaButton(
                index:1,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:2,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:3,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:4,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ),
            CicadaButton(
                index:5,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            )
        ]
        for i in 0...4{
            cicadaButton.append(CicadaButton(
                index:i+1,
                imageNamed:"mushi_aburazemi",
                size: CGSize(width:150,height:150)
            ))
            cicadaButton[i].position = CGPoint(x: 70 + i * 150, y: 200)
            self.addChild(cicadaButton[i])
            
        }
        center.addObserver(self, selector: #selector(self.mode1), name: Notification.Name(rawValue:String(1)), object: nil)
        center.addObserver(self, selector: #selector(self.mode2), name: Notification.Name(rawValue:String(2)), object: nil)
        center.addObserver(self, selector: #selector(self.mode3), name: Notification.Name(rawValue:String(3)), object: nil)
        center.addObserver(self, selector: #selector(self.mode4), name: Notification.Name(rawValue:String(4)), object: nil)
        center.addObserver(self, selector: #selector(self.mode5), name: Notification.Name(rawValue:String(5)), object: nil)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let posData  = self.cicadaBlock!.posData {
            let array : [UInt8] = [UInt8(posData.x),UInt8(posData.y)]
            //let data = NSData(bytes: &value, length: 10)
            self.sendData = Data(bytes: array)
            if let d = self.sendData{
                ble.update(data:d)
                let hexStr = Data(bytes: array).map {
                    String(format: "%.2hhx", $0)
                    }.joined()
                print(hexStr)
            }
            //var value: UInt = 0x0000FF80808080808000
            //let data: NSData = NSData(bytes: &value, length: 10)
        }
    }
    
    func mode1(){
        self.cicadaBlock!.setMode(mode:1)
    }
    func mode2(){
        self.cicadaBlock!.setMode(mode:2)
    }
    func mode3(){
        self.cicadaBlock!.setMode(mode:3)
    }
    func mode4(){
        self.cicadaBlock!.setMode(mode:4)
    }
    func mode5(){
        self.cicadaBlock!.setMode(mode:5)
    }
    
}
