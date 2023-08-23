//
//  PersistanceController.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 10/07/23.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    private func seedUser(context: NSManagedObjectContext) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        var userCount: Int
        do {
            userCount = try context.count(for: request)
        } catch let error {
            print("Failed to get user count: \(error)")
            return
        }
        guard userCount == 0 else {
            print("COUNT: \(userCount)")
            print("NOT SEEDING! Because already has data!")
            return
        }
        let newUser = User(context: context)
        newUser.id = UUID()
        newUser.name = ""
        newUser.address = ""
        newUser.createdAt = Date()
        newUser.updatedAt = Date()
        do {
            try context.save()
            print("user seeded")
        } catch let error {
            print("Failed to save user: \(error)")
        }
    }

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        seedUser(context: container.viewContext)
    }
}
