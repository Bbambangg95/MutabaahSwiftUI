//
//  Murojaah+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData

extension Murojaah {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Murojaah> {
        return NSFetchRequest<Murojaah>(entityName: "Murojaah")
    }

    @NSManaged public var category: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var key: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var value: String?
    @NSManaged public var origin: Student?

}

extension Murojaah: Identifiable {

}
