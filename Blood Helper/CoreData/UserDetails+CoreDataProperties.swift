//
//  UserDetails+CoreDataProperties.swift
//  Blood Helper
//
//  Created by MacOS on 07/04/23.
//
//

import Foundation
import CoreData


extension UserDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetails> {
        return NSFetchRequest<UserDetails>(entityName: "UserDetails")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var conformPassword: String?
    @NSManaged public var mobile: String?
    @NSManaged public var gender: String?
    @NSManaged public var bloodType: String?
    @NSManaged public var available: String?

}

extension UserDetails : Identifiable {

}
