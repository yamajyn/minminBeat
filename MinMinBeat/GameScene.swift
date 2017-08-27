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
    
    var last2: CFTimeInterval!
    var last: CFTimeInterval!
    var current: CFTimeInterval!
    
    let ble = BluetoothLE()
    let wButtonNum = 5
    let hButtonNum = 3
    
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
        slider.layer.position = CGPoint(x: self.size.width * 2 / 7, y: self.size.height * 2 / 7)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(self,
                         action: #selector(onMySlider(_:)),
                         for: UIControlEvents.valueChanged)
        self.view?.addSubview(slider)
    }
    
    func onMySlider (_ sender: UISlider){
        if !(last2 != nil) {
            last2 = current
        }
        if last2 + 0.1 <= current{
            ble.volumeToUInt8(volume: Int(sender.value))
            last2 = current
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
