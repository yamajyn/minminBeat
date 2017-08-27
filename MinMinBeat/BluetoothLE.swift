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
    
    func posDataToUInt8(posData:PosData){
        let array : [UInt8] = [UInt8(0),UInt8(posData.x),UInt8(posData.y)]
        let sendData = Data(bytes: array)
        self.update(data: sendData)
        printBytes(bytes: array)
    }
    
    func nameToUInt8(name:String){
        if let data = name.data(using: .utf8){
            self.update(data:data)
        }
    }
    
    func printBytes(bytes:[UInt8]){
        let hexStr = Data(bytes: bytes).map {
            String(format: "%.2hhx", $0)
            }.joined()
        print(hexStr)
    }
}
