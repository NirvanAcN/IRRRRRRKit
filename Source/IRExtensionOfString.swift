//
//  IRExtensionOfString.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/3/30.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - 正则
    /**
     ir_正则表达式匹配
     
     - parameter regular: 正则表达式
     
     - returns: Bool
     */
    func ir_regularByRegular(regular:String) -> Bool {
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regular)
        return predicate.evaluateWithObject(self)
        
    }
    
    enum Operators : Int {
        case ChinaMobile = 0, ChinaUnicom, ChinaTelecom, OtherOperator
    }
    
    /**
     ir_手机正则
     
     - returns: Bool
     */
    func ir_regularOfPhoneNumber() -> Bool {
        let allRegulars = [
            "^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-47-8])\\d{8}$",//移动号段
            "^1(3[0-2]|4[5]|5[5-6]|7[5-6]|8[5-6])\\d{8}$",//联通号段
            "^1(3[3]|5[3]|7[7]|8[0-19])\\d{8}$",//电信号段
            "^170\\d{8}$"//虚拟运营商
        ]
        
        for i in 0..<allRegulars.count {
            if self.ir_regularByRegular(allRegulars[i]) {
                switch i {
                case Operators.ChinaMobile.rawValue:
                    print("移动号段")
                    return true
                case Operators.ChinaUnicom.rawValue:
                    print("联通号段")
                    return true
                case Operators.ChinaTelecom.rawValue:
                    print("电信号段")
                    return true
                default:
                    print("虚拟运营商")
                    return true
                }
            }
        }
        return false
        
    }
    
    // MARK: - 拼音
    func ir_pinyin() -> String {
        let transed = NSMutableString(string:self) as CFMutableString
        if CFStringTransform(transed, nil, kCFStringTransformMandarinLatin, false) == true {
            if CFStringTransform(transed, nil, kCFStringTransformStripDiacritics, false) == true {
         
            }
        }
        return transed as String
        
    }
    
}