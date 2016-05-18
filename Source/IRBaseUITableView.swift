//
//  IRBaseUITableView.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/4/1.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import UIKit

class IRBaseUITableView: UITableView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ir_sameFunction()
    }
    
    private func ir_sameFunction() {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 44.0
        switch (style) {
        case .Plain:
            tableFooterView = UIView()
            break
            
        default:
            break
        }
    }
    
    override func dequeueReusableCellWithIdentifier(identifier: String) -> UITableViewCell? {
        var cell = super.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            registerNib(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            cell = super.dequeueReusableCellWithIdentifier(identifier)
        }
        cell?.selectionStyle = .None
        return cell
        
    }
    
}
