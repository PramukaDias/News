//
//  PNUser+CoreDataProperties.swift
//  
//
//  Created by Pramuka Dias on 10/6/19.
//
//

import Foundation
import CoreData


extension PNUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PNUser> {
        return NSFetchRequest<PNUser>(entityName: "PNUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var fullname: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}
