//
//  CicadaBlock.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import SpriteKit
import GameplayKit

struct TouchPos{
    var x:Int
    var y:Int
}

class CicadaBlock : SKSpriteNode {
    
    public var maxPosValue = CGPoint(x: 100, y: 100) //四角内の座標値の範囲
    public var touchedPos : CGPoint?
    //private var fingerNode : SKShapeNode?
    
    private var particle:SKEmitterNode?
    
    init(length:CGFloat) {
        
        super.init(texture: SKTexture(imageNamed: "block"), color: UIColor.blue, size: CGSize(width: length, height: length))
        self.isUserInteractionEnabled = true
        self.zPosition = 0
        self.anchorPoint = CGPoint(x: 0, y: 0)
        // Create shape node to use during mouse interaction
        //        self.fingerNode = SKShapeNode.init(rectOf: CGSize.init(width: 20, height: 20), cornerRadius: 5)
        //
        //        if let spinnyNode = self.fingerNode {
        //            spinnyNode.lineWidth = 2.5
        //            spinnyNode.zPosition = 10
        //
        //            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        //            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
        //                                              SKAction.fadeOut(withDuration: 0.5),
        //                                              SKAction.removeFromParent()]))
        //        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc = t.location(in: self)
            self.particle = SKEmitterNode(fileNamed: "TouchParticle.sks")
            if let particle = self.particle{
                particle.position = loc
                particle.targetNode = self
                self.addChild(particle)
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc = t.location(in: self)
            if loc.x > 0, loc.y>0, loc.x < self.size.width, loc.y < self.size.height{
                //                if let n = self.fingerNode?.copy() as! SKShapeNode? {
                ////                    n.position = loc
                ////                    n.strokeColor = SKColor.green
                ////                    self.addChild(n)
                //                    print(map(location: loc))
                //                    print(self.contains(loc))
                //                }
                
                
            }
            if let particle = self.particle{
                particle.position = loc
            }
            
        }
    }
    
    //座標値を欲しい範囲内に収める
    func map(location:CGPoint) -> TouchPos{
        let x = location.x / self.size.width * maxPosValue.x
        let y = location.y / self.size.height * maxPosValue.y
        let mappedPos =  TouchPos(x: Int(x), y: Int(y))
        return mappedPos
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let particle = self.particle{
            let wait = SKAction.wait(forDuration: TimeInterval(particle.particleLifetime))
            let remove = SKAction.removeFromParent()
            let action = SKAction.sequence([wait,remove])
            particle.run(action)
            particle.removeFromParent()
        }
    }
}


