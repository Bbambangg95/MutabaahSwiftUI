//
//  Attendance+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData

extension Attendance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attendance> {
        return NSFetchRequest<Attendance>(entityName: "Attendance")
    }

    @NSManaged public var attendStatus: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var reason: String?
    @NSManaged public var timeLabel: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var origin: Student?

}

extension Attendance: Identifiable {}
