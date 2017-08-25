//
//  BLE.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/25.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import CoreBluetooth

class BluetoothLE : NSObject,CBPeripheralManagerDelegate{
    
    var peripheralManager: CBPeripheralManager!
    let serviceUUID = CBUUID(string: "0001")
    var service: CBMutableService!
    let characteristicUUID = CBUUID(string: "0001")
    var characteristic: CBMutableCharacteristic!
    
    var sendData:Data?
    var sampleData:Int = 10
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOff:
            print("Bluetoothの電源がOff")
        case .poweredOn:
            print("Bluetoothの電源はOn")
            service = CBMutableService(type: serviceUUID, primary: true)
            let properties: CBCharacteristicProperties = [.notify, .read, .write]
            let permissions: CBAttributePermissions = [.readable, .writeable]
            characteristic = CBMutableCharacteristic(type: characteristicUUID, properties: properties,
                                                     value: nil, permissions: permissions)
            service.characteristics = [characteristic]
            peripheralManager.add(service)
            
            sendData = Data(bytes: &sampleData, count: 4)
            characteristic.value = sendData
            
            let advertisementData = [CBAdvertisementDataLocalNameKey: "MINMIN"]
            peripheralManager.startAdvertising(advertisementData)
            
            
        case .resetting:
            print("レスティング状態")
        case .unauthorized:
            print("非認証状態")
        case .unknown:
            print("不明")
        case .unsupported:
            print("非対応")
        }
        
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        
        if let error = error {
            print("Failed... error: \(error)")
            return
        }
        
        print("Advertising success")
        
        peripheralManager.stopAdvertising()
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        
        if let error = error {
            print("Failed... error: \(error)")
            return
        }
        
        print("Succeeded!")
        
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        
        if request.characteristic.uuid.isEqual(characteristic.uuid) {
            
            request.value = characteristic.value
            
            // リクエストに応答
            peripheralManager.respond(to: request, withResult: .success)
        }
    }
    
    func update(data:Data){
        self.peripheralManager.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
    }
    
}
