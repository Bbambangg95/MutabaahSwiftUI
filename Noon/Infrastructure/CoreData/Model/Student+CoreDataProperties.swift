//
//  Student+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var address: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var createdAt: Date?
    @NSManaged public var gender: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startProgram: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var attendance: NSSet?
    @NSManaged public var murojaah: NSSet?
    @NSManaged public var studentPreference: StudentPreference?
    @NSManaged public var ziyadah: NSSet?
    @NSManaged public var completedZiyadah: NSSet?

}

// MARK: Generated accessors for attendance
extension Student {

    @objc(addAttendanceObject:)
    @NSManaged public func addToAttendance(_ value: Attendance)

    @objc(removeAttendanceObject:)
    @NSManaged public func removeFromAttendance(_ value: Attendance)

    @objc(addAttendance:)
    @NSManaged public func addToAttendance(_ values: NSSet)

    @objc(removeAttendance:)
    @NSManaged public func removeFromAttendance(_ values: NSSet)

}

// MARK: Generated accessors for murojaah
extension Student {

    @objc(addMurojaahObject:)
    @NSManaged public func addToMurojaah(_ value: Murojaah)

    @objc(removeMurojaahObject:)
    @NSManaged public func removeFromMurojaah(_ value: Murojaah)

    @objc(addMurojaah:)
    @NSManaged public func addToMurojaah(_ values: NSSet)

    @objc(removeMurojaah:)
    @NSManaged public func removeFromMurojaah(_ values: NSSet)

}

// MARK: Generated accessors for ziyadah
extension Student {

    @objc(addZiyadahObject:)
    @NSManaged public func addToZiyadah(_ value: Ziyadah)

    @objc(removeZiyadahObject:)
    @NSManaged public func removeFromZiyadah(_ value: Ziyadah)

    @objc(addZiyadah:)
    @NSManaged public func addToZiyadah(_ values: NSSet)

    @objc(removeZiyadah:)
    @NSManaged public func removeFromZiyadah(_ values: NSSet)

}

// MARK: Generated accessors for completedZiyadah
extension Student {

    @objc(addCompletedZiyadahObject:)
    @NSManaged public func addToCompletedZiyadah(_ value: CompletedZiyadah)

    @objc(removeCompletedZiyadahObject:)
    @NSManaged public func removeFromCompletedZiyadah(_ value: CompletedZiyadah)

    @objc(addCompletedZiyadah:)
    @NSManaged public func addToCompletedZiyadah(_ values: NSSet)

    @objc(removeCompletedZiyadah:)
    @NSManaged public func removeFromCompletedZiyadah(_ values: NSSet)

}

extension Student : Identifiable {

}
