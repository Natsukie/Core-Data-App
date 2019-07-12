//
//  Contact+CoreDataClass.swift
//  Core Data App
//
//  Created by Guangzu on 7/11/19.
//  Copyright © 2019 Guangzu. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    var date:Date? {
        get{
            return rawDate as Date?
        }set{
            rawDate = newValue as NSDate?
    }
  }
    convenience init?(name: String?, phone: Int64, date: Date?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        
        self.init(entity: Contact.entity()    ,insertInto:  managedContext )
        
        self.name = name
        self.phone = phone
        self.date = date
  
    }
}
