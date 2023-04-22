//
//  PatientDetails+CoreDataProperties.swift
//  Blood Helper
//
//  Created by MacOS on 12/04/23.
//
//

import Foundation
import CoreData


extension PatientDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientDetails> {
        return NSFetchRequest<PatientDetails>(entityName: "PatientDetails")
    }

    @NSManaged public var cBloodGroup: String?
    @NSManaged public var cName: String?
    @NSManaged public var cPhone: String?

}

extension PatientDetails : Identifiable {

}
