//
//  IRExtensionOfUIViewController.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/3/30.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     ir_两个按钮的提示框
     
     - parameter title:   标题
     - parameter message: 副标题
     - parameter action:  确定按钮点击事件
     */
    func ir_alert(title:String, message:String, action:(alertAction:UIAlertAction)->(Void)) -> Void {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction.init(title: "取消", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: "确定", style: .Default, handler:action))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    /**
     ir_一个按钮的提示框
     
     - parameter title:   标题
     - parameter message: 副标题
     - parameter action:  确定按钮点击事件
     */
    func ir_alertSimple(title:String, message:String, action:(alertAction:UIAlertAction)->(Void)) -> Void {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .Default, handler:action))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    private struct Ir_keys {
        static var haha:String?
    }
    
    var haha :String {
        get {
            return objc_getAssociatedObject(self, &Ir_keys.haha) as! String
        }
        set {
            objc_setAssociatedObject(self, &Ir_keys.haha, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}