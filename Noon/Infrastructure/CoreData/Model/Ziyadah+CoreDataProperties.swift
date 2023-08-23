//
//  Ziyadah+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData

extension Ziyadah {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ziyadah> {
        return NSFetchRequest<Ziyadah>(entityName: "Ziyadah")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var juz: Int32
    @NSManaged public var memorizeValue: String?
    @NSManaged public var page: Int32
    @NSManaged public var recitationValue: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var origin: Student?

}

extension Ziyadah: Identifiable {}
