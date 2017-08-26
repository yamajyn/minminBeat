//
//  ButtonTappedDelegate.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/26.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import Foundation

@objc protocol ButtonTappedDelegate : class {
    func buttonTapBegan(_ name:String)
    @objc optional func buttonTapEnded(_ name:String)
    @objc optional func buttonTapCancelled(_ name:String)
}
