//
//  BLE.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/25.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import CoreBluetooth

class BluetoothLE{
    
    var sendData : Data?
    
    var targetPeripheral: CBPeripheral?
    var targetService: CBService!
    var targetCharacteristic: CBCharacteristic?
    
    public func setPeripheral(targetpPeripheral:CBPeripheral){
        self.targetPeripheral = targetpPeripheral
    }
    
    public func setCharacter(targetCharacteristic:CBCharacteristic){
        self.targetCharacteristic = targetCharacteristic
    }
    
    func update(data:Data){
        if let targetChara = self.targetCharacteristic{
            if let targetPeriphe = self.targetPeripheral{
                targetPeriphe.writeValue(data, for: targetChara,type:CBCharacteristicWriteType.withResponse)
                print("complete")
            }
        }
    }
}
