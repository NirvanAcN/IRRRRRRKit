//
//  IRExtensionOfUITextView.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/4/1.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import Foundation
import UIKit

/*
 C函数指针
 　　Swift现在可以使用C函数指针，CFunctionPointer已不复存在。任何全局函数，嵌套函数和不捕获状态的闭包都可以作为一个C函数指针直接传递。你也可以调用来自C程序的函数。
 　　你可以显示地使用新属性@convention(c)，表示函数应该使用C调用约定，简单痛快！尽管我想不出在此对块（block）的支持有何用，作为所发生变化的一部分，@objc_block也被删掉了，使用@convention(block)取而代之。@convention(swift)默认支持所有函数和闭包。
 */
typealias Callback = @convention(block)(text:String)->()
extension UITextView {
    
    private struct MyPs {
        static var placeholder:String?
        static var valueChangeCallback:Callback?
    }
    
    var ir_placeholder:String {
        get {
            return objc_getAssociatedObject(self, &MyPs.placeholder) as! String
        }
        
        set {
            let placeholderView = UITextView.init(frame: bounds)
            placeholderView.text = newValue
            placeholderView.font = font
            placeholderView.textColor = UIColor.lightGrayColor()
            placeholderView.userInteractionEnabled = false
            placeholderView.backgroundColor = UIColor.clearColor()
            
            self.addSubview(placeholderView)
            MyPs.valueChangeCallback = {(text:String)->() in
                placeholderView.hidden = !(text.characters.count==0)
            }
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ir_valueChanged(_:)), name: UITextViewTextDidChangeNotification , object: nil)
            objc_setAssociatedObject(self, &MyPs.placeholder, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
    }
    
    private var valueChangeCallback: Callback? {
        get {
            return objc_getAssociatedObject(self, &MyPs.valueChangeCallback) as? Callback
        }
        set {
            if let newValue = newValue {
                let sub = unsafeBitCast(newValue, AnyObject.self)
                objc_setAssociatedObject(self, &MyPs.valueChangeCallback, sub, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    
    @objc private func ir_valueChanged(notification:NSNotification) {
        let ir_textView = notification.object as? UITextView
        MyPs.valueChangeCallback!(text: ir_textView!.text!)
    }
}