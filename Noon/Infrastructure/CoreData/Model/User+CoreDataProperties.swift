//
//  User+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var userSchedule: NSSet?

}

// MARK: Generated accessors for userSchedule
extension User {

    @objc(addUserScheduleObject:)
    @NSManaged public func addToUserSchedule(_ value: UserSchedule)

    @objc(removeUserScheduleObject:)
    @NSManaged public func removeFromUserSchedule(_ value: UserSchedule)

    @objc(addUserSchedule:)
    @NSManaged public func addToUserSchedule(_ values: NSSet)

    @objc(removeUserSchedule:)
    @NSManaged public func removeFromUserSchedule(_ values: NSSet)

}

extension User : Identifiable {

}
