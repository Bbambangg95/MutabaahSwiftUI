//
//  ZiyadahCDA.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 10/08/23.
//

import Foundation
import CoreData

class ZiyadahCDA: ZiyadahRepository {
    private let viewContext = PersistenceController.shared.container.viewContext
    func createZiyadah(studentId: UUID, ziyadah: ZiyadahEntity, completion: @escaping (Bool) -> Void) {
        let fetchStudent: NSFetchRequest<Student> = Student.fetchRequest()
        fetchStudent.predicate = NSPredicate(format: "id == %@", studentId as CVarArg)
        do {
            let students = try viewContext.fetch(fetchStudent)
            if let student = students.first {
                let newZiyadah = Ziyadah(context: viewContext)
                newZiyadah.id = UUID()
                newZiyadah.juz = Int32(ziyadah.juz)
                newZiyadah.page = Int32(ziyadah.page)
                newZiyadah.memorizeValue = ziyadah.memorizeValue
                newZiyadah.recitationValue = ziyadah.recitationValue
                newZiyadah.createdAt = ziyadah.createdAt
                newZiyadah.updatedAt = Date()
                student.addToZiyadah(newZiyadah)
                do {
                    try viewContext.save()
                    completion(true)
                    print("New ziyadah created successfully")
                } catch let error {
                    print("Error saving data: \(error)")
                    completion(false)
                }
            } else {
                completion(false)
            }
        } catch let error {
            print("Error saving data: \(error)")
            completion(false)
        }
    }
    func getZiyadah() -> [ZiyadahEntity] {
        let fetchRequest: NSFetchRequest<Ziyadah> = Ziyadah.fetchRequest()
        do {
            let fetchedZiyadah = try viewContext.fetch(fetchRequest)
            return fetchedZiyadah.map { ziyadah in
                ZiyadahEntity(
                    id: ziyadah.id ?? UUID(),
                    juz: Int(ziyadah.juz),
                    page: Int(ziyadah.page),
                    memorizeValue: ziyadah.memorizeValue ?? "",
                    recitationValue: ziyadah.recitationValue ?? "",
                    createdAt: ziyadah.createdAt ?? Date(),
                    updatedAt: ziyadah.updatedAt ?? Date(),
                    studentName: ziyadah.origin?.name ?? "")
            }
        } catch let error {
            print("Failed to fetch ziyadah: \(error)")
            return []
        }
    }
    func deleteZiyadah(id: UUID, completion: CompletionHandler) {
        let fetchRequest: NSFetchRequest<Ziyadah> = Ziyadah.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedZiyadah = try viewContext.fetch(fetchRequest)
            if let ziyadah = fetchedZiyadah.first {
                viewContext.delete(ziyadah)
                try viewContext.save()
                completion(.success(true))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}
