//
//  PadTappedDelegate.swift
//  MinMinBeat
//
//  Created by 山本隼也 on 2017/08/26.
//  Copyright © 2017年 山本隼也. All rights reserved.
//

import Foundation

@objc protocol PadTappedDelegate : class {
    func padTap()
    @objc optional func padTapEnded()
    @objc optional func padTapCancelled()
}
