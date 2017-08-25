//
//  CicadaBlock.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PosData{
    var x:Int
    var y:Int
}

class CicadaBlock : SKSpriteNode {
    
    public var posData : PosData? //送信する座標データ
    private var maxPosValue : CGPoint //四角内の座標値の範囲
    
    public var particle:SKEmitterNode?
    private let particleMode = ["TouchParticle","TouchParticle2","CicadaParticle","TouchParticle","TouchParticle2"]
    
    private var mode = 0
    
    
    init(size : CGSize, valueRange : CGPoint) {
        self.maxPosValue = valueRange
        super.init(texture: SKTexture(imageNamed: "block"), color: UIColor.blue, size:size)
        self.isUserInteractionEnabled = true
        self.zPosition = 0
        self.anchorPoint =  CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let touchPos = t.location(in: self)
            makeParticle(pos: touchPos)
        }
    }
    
    private func makeParticle(pos:CGPoint){
        if self.particle == nil{
            self.particle = SKEmitterNode(fileNamed: particleMode[self.mode] + ".sks")
            if let particle = self.particle{
                particle.position = pos
                particle.targetNode = self
                self.addChild(particle)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let touchPos = t.location(in: self)
            //particleを四角内に収める
            let loc = normalize(
                location: touchPos,
                min: CGPoint(x:0,y:0),
                max: CGPoint(x: self.size.width, y: self.size.height)
            )
            moveParticle(pos: loc)
            
            posData = map(location: loc)
            //print(posData!)
        }
    }
    
    private func moveParticle(pos:CGPoint){
        if let particle = self.particle{
            particle.position = pos
        }
    }
    
    //座標値を欲しい範囲内に収める
    private func map(location:CGPoint) -> PosData{
        let x = location.x / self.size.width * maxPosValue.x
        let y = location.y / self.size.height * maxPosValue.y
        let mappedPos =  PosData(x: Int(x), y: Int(y))
        return mappedPos
    }
    
    //範囲外に出た時の正規化
    private func normalize(location:CGPoint, min:CGPoint, max:CGPoint) -> CGPoint{
        var loc = location
        if loc.x < min.x{
            loc.x = min.x
        }else if loc.x > max.x{
            loc.x = max.x
        }
        if loc.y < min.y{
            loc.y = min.y
        }else if loc.y > max.y{
            loc.y = max.y
        }
        return loc
    }
    
    //particle削除
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            deleteParticle()
        }
    }
    
    private func deleteParticle(){
        if let particle = self.particle{
            particle.particleBirthRate = 0
            let wait = SKAction.wait(forDuration: TimeInterval(particle.particleLifetime))
            let remove = SKAction.removeFromParent()
            let action = SKAction.sequence([wait,remove])
            particle.run(action)
            self.particle = nil
        }
    }
    
    public func setMode(mode : Int){
        self.mode = mode - 1
    }
}


