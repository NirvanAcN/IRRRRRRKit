//
//  IRCoreDataManager.swift
//  CaidaProject
//
//  Created by iCe_Rabbit on 16/4/8.
//  Copyright © 2016年 HOME Ma. All rights reserved.
//

import UIKit
import CoreData

enum HOMECoreDataInsertMode {
    case Automatic
    case Manual
}

class IRCoreDataManager: NSObject {
    var ir_managedObjectContext:NSManagedObjectContext?
    class func ir_manager(nameForResource:String, success:((dbPath:String)->())!, failure:((localizedDescription:String)->())!) -> IRCoreDataManager {
        let kManager = IRCoreDataManager()
        guard let path = NSBundle.mainBundle().pathForResource(nameForResource, ofType: "momd") else {
            assert(false, "⚠️path not exist")
        }
        guard let managedObjectMode = NSManagedObjectModel.init(contentsOfURL: NSURL.fileURLWithPath(path)) else {
            assert(false, "⚠️create managedObjectMode faile")
        }
        let persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectMode)
        let dbPath = NSHomeDirectory().stringByAppendingString(String.init(format: "/Documents/%@.sqlite", nameForResource))
        do {
            _ = try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL.fileURLWithPath(dbPath), options: nil)
        } catch {
            failure?(localizedDescription:"addPersistentStoreWithType faile")
        }
        kManager.ir_managedObjectContext = NSManagedObjectContext.init(concurrencyType: .MainQueueConcurrencyType)
        guard let ir_managedObjectContext = kManager.ir_managedObjectContext else {
            assert(false, "⚠️create ir_managedObjectContext faile")
        }
        ir_managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        if success != nil {
            success(dbPath: dbPath)
        }
        return kManager
    }
    
    func ir_insertNewObject(entityForName:String, mode:HOMECoreDataInsertMode, managedObject:((managedObject:NSManagedObject)->())!, success:((managerObject:NSManagedObject)->())!, failure:((localizedDescription:String)->())!) -> Void {
        self.ir_managedObjectContext!.performBlockAndWait {
            let manageObject = NSEntityDescription.insertNewObjectForEntityForName(entityForName, inManagedObjectContext: self.ir_managedObjectContext!)
            if managedObject != nil {
                managedObject(managedObject: manageObject)
            }
            switch mode {
            case .Automatic:
                do {
                    try self.ir_managedObjectContext!.save()
                } catch {
                    failure?(localizedDescription:"⚠️insert entityForName faile")
                }
            case .Manual:
                if success != nil {
                    success(managerObject: manageObject)
                }
            }
        }
    }
    
    func ir_insertNewObjectsArrByManual(success:((result:Set<NSManagedObject>)->())!, failure:((localizedDescription:String)->())!) -> Void {
        self.ir_managedObjectContext!.performBlockAndWait {[weak self] in
            do {
                try self!.ir_managedObjectContext!.save()
            } catch {
                failure?(localizedDescription:"⚠️insert Set faile")
            }
            if success != nil {
                success(result: self!.ir_managedObjectContext!.registeredObjects)
            }
        }
    }

    func ir_deleteObjectWithResult(entity:NSManagedObject, success:(()->())!, failure:((localizedDescription:String)->())!) -> Void {
        self.ir_managedObjectContext!.performBlockAndWait { 
            self.ir_managedObjectContext!.deleteObject(entity)
            do {
                try self.ir_managedObjectContext!.save()
            } catch {
                failure?(localizedDescription:"⚠️delete entity faile")
            }
            if success != nil {
                success()
            }
        }
    }
    
    func ir_deleteObject(entity:NSManagedObject) -> Void {
        ir_managedObjectContext!.performBlockAndWait {[weak self] in
            self?.ir_deleteObjectWithResult(entity, success: nil, failure: nil)
        }
    }

    func ir_updateObject(entity:NSManagedObject, managedObject:((managedObject:NSManagedObject)->())!, failure:((localizedDescription:String)->())!) -> Void {
        ir_managedObjectContext!.performBlockAndWait { [weak self] in 
            if managedObject != nil {
                managedObject(managedObject:entity)
            }
            
            do {
                try self?.ir_managedObjectContext!.save()
            } catch {
                failure?(localizedDescription:"⚠️update Object faile")
            }
        }
    }
    
    func ir_selectWithEntity(entityName:String, success:((result:Array<AnyObject>)->())!, failure:((localizedDescription:String)->())!,predicateFormat: String?, _ args: CVarArgType...) -> Void {
        let fetchRequest = NSFetchRequest.init(entityName: entityName)
        if predicateFormat != nil {
            let predicate = NSPredicate.init(format: predicateFormat!, arguments: getVaList(args))
            fetchRequest.predicate = predicate
        }
        ir_managedObjectContext!.performBlockAndWait { [weak self] in
            do {
                let result = try self?.ir_managedObjectContext!.executeFetchRequest(fetchRequest)
                if success != nil {
                    success(result: result!)
                }
            } catch {
                failure?(localizedDescription:"⚠️select Entity faile")
            }
           
        }
    }
    
    func ir_selectWithEntityLimit(entityName:String, fetchLimit:Int, fetchOffset:Int, success:((result:Array<AnyObject>)->())!, failure:((localizedDescription:String)->())!, predicateFormat: String?, _ args: CVarArgType...) -> Void {
        let fetchRequest = NSFetchRequest.init(entityName: entityName)
        if fetchLimit > 0 {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        if fetchOffset > 0 {
            fetchRequest.fetchOffset = fetchOffset
        }
        
        if predicateFormat != nil {
            let predicate = NSPredicate.init(format: predicateFormat!, arguments: getVaList(args))
            fetchRequest.predicate = predicate
        }
        ir_managedObjectContext!.performBlockAndWait { [weak self] in
            do {
                let result = try self?.ir_managedObjectContext!.executeFetchRequest(fetchRequest)
                if success != nil {
                    success(result: result!)
                }
            } catch {
                failure?(localizedDescription:"⚠️select Entity faile")
            }
        }

    }
}
