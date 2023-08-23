//
//  AttendanceCDA.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 09/08/23.
//

import Foundation
import CoreData

class AttendanceCDA: AttendanceRepository {
    private let viewContext = PersistenceController.shared.container.viewContext
    func createAttendance(studentId: UUID, attendance: AttendanceEntity) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", studentId as CVarArg)
        do {
            let students = try viewContext.fetch(fetchRequest)
            if let student = students.first {
                let newAttendance = Attendance(context: viewContext)
                newAttendance.id = UUID()
                newAttendance.attendStatus = attendance.attendStatus
                newAttendance.timeLabel = attendance.timeLabel
                newAttendance.reason = attendance.reason
                newAttendance.createdAt = Date()
                newAttendance.updatedAt = Date()
                student.addToAttendance(newAttendance)
                try viewContext.save()
                print("Attendance saved successfully")
            }
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    func updateAttendance(id: UUID, attendance: AttendanceEntity) {
        let fetchRequest: NSFetchRequest<Attendance> = Attendance.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let attendances = try viewContext.fetch(fetchRequest)
            if let existingAttendance = attendances.first {
                existingAttendance.attendStatus = attendance.attendStatus
                existingAttendance.reason = attendance.reason
                try viewContext.save()
                print("Attendance updated successfully")
            }
        } catch let error {
            print("Error updating data: \(error)")
        }
    }
}
