//
//  IRExtensionOfNSTimer.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/3/31.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import Foundation

private typealias Ir_closures = @convention(block)(NSTimer)->(Void)
extension NSTimer {

    @objc private class func ir_onTimerValueChange(sender:NSTimer) -> Void {
        if sender.userInfo != nil {
            let closure = unsafeBitCast(sender.userInfo, Ir_closures.self)
            closure(sender)
        }
    }
    
    class func ir_scheduledTimer(ti:NSTimeInterval, repeats:Bool, event:(ir_timerSender:NSTimer)->(Void)) -> NSTimer {
        let wrappedBlock:Ir_closures = event
        let wrappedObject = unsafeBitCast(wrappedBlock, AnyObject.self)
        return NSTimer.scheduledTimerWithTimeInterval(ti, target: self, selector: #selector(NSTimer.ir_onTimerValueChange(_:)), userInfo: wrappedObject, repeats: repeats)
    }
}