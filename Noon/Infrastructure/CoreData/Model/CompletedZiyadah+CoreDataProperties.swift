//
//  CompletedZiyadah+CoreDataProperties.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//
//

import Foundation
import CoreData

extension CompletedZiyadah {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompletedZiyadah> {
        return NSFetchRequest<CompletedZiyadah>(entityName: "CompletedZiyadah")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var juz: Int16
    @NSManaged public var updatedAt: Date?
    @NSManaged public var origin: Student?

}

extension CompletedZiyadah: Identifiable {}
