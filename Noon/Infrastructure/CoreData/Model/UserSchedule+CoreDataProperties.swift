//
//  UserSchedule+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData


extension UserSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSchedule> {
        return NSFetchRequest<UserSchedule>(entityName: "UserSchedule")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var startTime: Date?
    @NSManaged public var timeLabel: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var origin: User?

}

extension UserSchedule : Identifiable {

}
