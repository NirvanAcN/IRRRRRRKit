//
//  IRExtensionOfNSObject.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/4/1.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import Foundation

extension NSObject {
    struct MyPs {
        static var funk:String?
    }
    
    var className:String {
        get {
            return "\(self.dynamicType)"
        }
        
        set {
            objc_setAssociatedObject(self, &MyPs.funk, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}