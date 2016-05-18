//
//  IRExtensionOfUINavigationBar.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/5/12.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
        /// 改变导航栏标题颜色
    var ir_titleColor:UIColor {
        set {
            titleTextAttributes = [NSForegroundColorAttributeName:newValue]
            objc_setAssociatedObject(self, "ir_titleColorKey", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, "ir_titleColorKey") as! UIColor
        }
    }
    
}