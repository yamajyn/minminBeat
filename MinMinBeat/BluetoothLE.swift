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
        var dataKey:Int = 0
        let dataName:String = name.substring(to: name.index(name.endIndex, offsetBy: -1))
        switch dataName {
        case "semi":
            dataKey = 1
        case "track":
            dataKey = 2
        case "recLength":
            dataKey = 3
        case "mutetrack":
            dataKey = 4
        case "sample":
            dataKey = 5
        case "master":
            dataKey = 7
        default:
            print("データが受信できません")
            return
        }
        
        if let dataValue = Int(name.substring(from: name.index(name.endIndex, offsetBy: -1))){
            let array: [UInt8] = [UInt8(dataKey),UInt8(dataValue - 1)]
            let data = Data(bytes: array)
            self.update(data:data)
            printBytes(bytes: array)
        }
    }
    
    func volumeToUInt8(posData:PosData){
        let array: [UInt8] = [UInt8(6),UInt8(posData.y)]
        let sendData = Data(bytes: array)
        self.update(data: sendData)
        printBytes(bytes: array)
    }
    
    func printBytes(bytes:[UInt8]){
        let hexStr = Data(bytes: bytes).map {
            String(format: "%.2hhx", $0)
            }.joined()
        print(hexStr)
    }
}
