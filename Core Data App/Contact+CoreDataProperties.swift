//
//  Contact+CoreDataProperties.swift
//  Core Data App
//
//  Created by Guangzu on 7/11/19.
//  Copyright © 2019 Guangzu. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: Int64
    @NSManaged public var rawDate: NSDate?

}
