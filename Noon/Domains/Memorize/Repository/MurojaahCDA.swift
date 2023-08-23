//
//  MurojaahCDA.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 11/08/23.
//

import CoreData

class MurojaahCDA: MurojaahRepository {
    private let viewContext = PersistenceController.shared.container.viewContext
    func createMurojaah(studentId: UUID, murojaah: MurojaahEntity) {
        let fetchStudent: NSFetchRequest<Student> = Student.fetchRequest()
        fetchStudent.predicate = NSPredicate(format: "id == %@", studentId as CVarArg)
        do {
            let students = try viewContext.fetch(fetchStudent)
            if let student = students.first {
                let newMurojaah = Murojaah(context: viewContext)
                newMurojaah.id = UUID()
                newMurojaah.category = murojaah.category
                newMurojaah.key = murojaah.key
                newMurojaah.value = murojaah.value
                newMurojaah.createdAt = Date()
                newMurojaah.updatedAt = Date()
                student.addToMurojaah(newMurojaah)
                try viewContext.save()
                print("New murojaah created succesfully")
            }
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    func getMurojaah() -> [MurojaahEntity] {
        let fetchRequest: NSFetchRequest<Murojaah> = Murojaah.fetchRequest()
        do {
            let fetchedMurojaah = try viewContext.fetch(fetchRequest)
            return fetchedMurojaah.map { murojaah in
                MurojaahEntity(
                    id: murojaah.id ?? UUID(),
                    category: murojaah.category ?? "",
                    key: murojaah.key ?? "",
                    value: murojaah.value ?? "",
                    createdAt: murojaah.createdAt ?? Date(),
                    updatedAt: murojaah.updatedAt ?? Date(),
                    studentName: murojaah.origin?.name ?? "")
            }
        } catch let error {
            print("Failed to fetch murojaah: \(error)")
            return []
        }
    }
    func deleteMurojaah(id: UUID) {
        let fetchRequest: NSFetchRequest<Murojaah> = Murojaah.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedMurojaah = try viewContext.fetch(fetchRequest)
            if let murojaah = fetchedMurojaah.first {
                viewContext.delete(murojaah)
                try viewContext.save()
                print("Murojaah deleted succesfully")
            }
        } catch let error {
            print("Error delete murojaah \(error)")
        }
    }
}
