//
//  GameScene.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit



class GameScene: SKScene,ButtonTappedDelegate,PadTappedDelegate{
    
    
    var cicadaBlock : CicadaBlock?
    var cicadaButtons : CicadaButtons?
    let masterButton = SKButton(size: CGSize(width: 80, height: 80), offTexture: "start", onTexture: "stop")
    
    var slideLast: CFTimeInterval!
    var padTapLast: CFTimeInterval!
    var lightLast : CFTimeInterval!
    var current: CFTimeInterval!
    
    let ble = BluetoothLE()
    let wButtonNum = 5
    let hButtonNum = 4
    var recLast: [CFTimeInterval?] = [nil,nil,nil,nil,nil]
    var recLength: [CFTimeInterval?] = [nil,nil,nil,nil,nil]
    var cicada = SKSpriteNode(imageNamed:"cicada")
    
    override init(size:CGSize){
        
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        //Create cicadaBlock node
        let w = self.size.width * 0.4
        let h = self.size.height * 0.8
        let size = CGSize(width: w, height: h)
        self.cicadaBlock = CicadaBlock(
            size: size,
            position: CGPoint(x: self.size.width * 11 / 20, y: self.size.height / 10),
            valueRange: CGPoint(x:255,y:255)
        )
        self.addChild(self.cicadaBlock!)
        self.cicadaBlock!.padDelegate = self
        
        //Create cicadaButton
        self.cicadaButtons =  CicadaButtons(
            w:wButtonNum,
            h:hButtonNum,
            size: size,
            position: CGPoint(x: self.size.width / 15, y: self.size.height / 15)
        )
        for i in 0...hButtonNum - 1 {
            for j in 0...wButtonNum - 1{
                self.cicadaButtons?.buttons[i][j].tapDelegate = self
            }
        }
        self.addChild(cicadaButtons!)
        
        
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: w, height: 50))
        slider.layer.position = CGPoint(x: self.size.width / 12 + w / 2, y: self.size.height / 4)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.maximumTrackTintColor = .gray
        slider.minimumTrackTintColor = .red
        slider.setThumbImage(UIImage(named:"slider.png"), for: UIControlState.normal)
        slider.value = 50
        slider.addTarget(self,
                         action: #selector(onMySlider(_:)),
                         for: UIControlEvents.valueChanged)
        self.view?.addSubview(slider)
        
        masterButton.tapDelegate = self
        masterButton.position = CGPoint(x: self.size.width / 20, y: self.size.height * 8 / 9)
        self.addChild(masterButton)
        masterButton.button.size = CGSize(width: self.size.width / 20, height: self.size.width / 20)
        masterButton.value = false
        masterButton.name = "master"
        masterButton.zPosition = 20
        self.backgroundColor = UIColor(colorLiteralRed: 0.156, green: 0.117, blue: 0.117, alpha: 1.0)
        
        cicada.size = CGSize(width: 30, height: 30)
        cicada.position = CGPoint(x: self.size.width / 8, y: self.size.height * 8 / 9 + self.size.width / 20 - 30)
        self.addChild(cicada)
        
        
    }
    
    func onMySlider (_ sender: UISlider){
        if !(slideLast != nil) {
            slideLast = current
        }
        if slideLast + 0.1 <= current{
            ble.volumeToUInt8(volume: Int(sender.value))
            slideLast = current
        }

    }

    func buttonTapEnded(_ name: String){
        if name == "master"{
            if masterButton.value{
                let rotate = SKAction.rotate(byAngle: CGFloat(Double.pi/2), duration: 0.1)
                let wait = SKAction.wait(forDuration: 0.5)
                let action = SKAction.group([rotate,wait])
                let loop = SKAction.repeatForever(action)
                cicada.run(loop)
                cicada.zRotation = 0
            }else{
                cicada.removeAllActions()
            }
            
            ble.masterToUInt8(state: masterButton.value)
            return
        }
        ble.nameToUInt8(name: name)
        
        let type = name.substring(to: name.index(before: name.endIndex))
        if type == "track"{
            if let index = Int(name.substring(from: name.index(before: name.endIndex))){
                self.recLength[index] = CFTimeInterval(pow(2.0, Double(index)-1))
            }
        }
    }
    
    func padTap() {
        //タップした位置データ取得
        if let posData  = self.cicadaBlock!.posData {
            //位置データをDataに変換
            if !(padTapLast != nil) {
                padTapLast = current
            }
            if padTapLast + 0.1 <= current{
                self.ble.posDataToUInt8(posData: posData)
                padTapLast = current
            }
        }
    }
    
    func resetButtonState(){
    }
    
    override func update(_ currentTime: TimeInterval) {
        current = currentTime
        recEnd()
    }
    
    func recEnd(){
        
        for (i,recLen) in recLength.enumerated(){
            if let len = recLen{
                if !(recLast[i] != nil) {
                    recLast[i] = current
                }
                if recLast[i]! + len <= current{
                    self.cicadaButtons!.buttons[1][i].resetButtonState()
                    recLength[i] = nil
                    recLast[i] = nil
                }
            }
        }
        
    }
}
