//
//  GameViewController.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/22.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreBluetooth


class GameViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    var centralManager: CBCentralManager!
    var targetPeripheral: CBPeripheral!
    var targetService: CBService!
    var targetCharacteristic: CBCharacteristic!
    let serviceUuids = [CBUUID(string: "abcd")]
    let characteristicUuids = [CBUUID(string: "12ab")]
    var scene : GameScene?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        
        if let view = self.view as! SKView? {
            
            scene = GameScene(size:CGSize(width:2048,height:2732))
            // Set the scale mode to scale to fit the window
            scene!.scaleMode = .aspectFill
            scene!.size = view.frame.size
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            //view.frameInterval = 12
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    Bluetooth処理
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("state:\(central.state)")
        switch central.state{
        case .poweredOff:
            print("Bluetoothの電源がOff")
            //BluetoothがOffの時にアラートを出して知らせる
            let bleOffAlert=UIAlertController(title: "警告", message: "bluettothをONにしてください", preferredStyle: .alert)
            bleOffAlert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
                )
            )
            self.present(bleOffAlert, animated: true, completion:nil )
        case .poweredOn:
            print("Bluetooth-On")
            //指定UUIDでPeripheralを検索する
            centralManager.scanForPeripherals(withServices: serviceUuids, options: nil)
            print("検索開始")
        default:
            print("bluetoothが準備中又は無効")
        }
    }
    
    //peripheralが見つかると呼び出される。
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        self.targetPeripheral = peripheral
        //アラートを出してユーザーの接続許可を得る
        let bleOnAlert = UIAlertController(title: "Peripheralを発見",message: "接続します",preferredStyle:.alert)
        bleOnAlert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                //Peripheralへの接続命令
                handler: {(action)->Void in
                        self.centralManager.connect(self.targetPeripheral, options: nil)
            })
        )
        bleOnAlert.addAction(
            UIAlertAction(
                title: "cencel",
                style: UIAlertActionStyle.cancel,
                handler: {(action)->Void in
                    print("canceled")
                    self.centralManager.stopScan()
            })
        )
        self.present(bleOnAlert, animated: true, completion: nil)
    }
    
    //Peripheralへの接続が成功した時呼ばれる
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        peripheral.delegate = self
        //指定されたUUIDでサービスを検索
        peripheral.discoverServices(serviceUuids)
    }
    //サービスを検索した時に呼び出される
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(peripheral.services ?? "peripheral.services is nil value")
        peripheral.delegate = self
        targetService = peripheral.services![0]
        //指定のUUIDでcharacteristicを検索する
        peripheral.discoverCharacteristics(characteristicUuids, for: targetService)
    }
    //characteristicを検索した時に呼び出される
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let e = error{
            print("error:\(e.localizedDescription)")
        }else{
            targetCharacteristic = service.characteristics![0]
            if let scene = self.scene{
                scene.ble.setPeripheral(targetpPeripheral: self.targetPeripheral)
                scene.ble.setCharacter(targetCharacteristic: self.targetCharacteristic)
            }
        }
        
    }
}
