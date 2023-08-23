//
//  StudentPreference+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData


extension StudentPreference {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentPreference> {
        return NSFetchRequest<StudentPreference>(entityName: "StudentPreference")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var endSprint: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var memorizeStatus: String?
    @NSManaged public var monthlyTarget: Int32
    @NSManaged public var startSprint: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var yearlyTarget: Int32
    @NSManaged public var origin: Student?

}

extension StudentPreference : Identifiable {

}
