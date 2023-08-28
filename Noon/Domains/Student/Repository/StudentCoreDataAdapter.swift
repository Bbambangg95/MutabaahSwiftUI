//
//  StudentCoreDataAdapter.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation
import CoreData

class StudentCoreDataAdapter: StudentRepository {
    private let viewContext = PersistenceController.shared.container.viewContext
    func getStudents(completion: @escaping (Result<[StudentEntity], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            let students = try viewContext.fetch(fetchRequest)
            let studentEntities = students.map { student in
                StudentEntity(
                    id: student.id ?? UUID(),
                    name: student.name ?? "",
                    birthDate: student.birthDate ?? Date(),
                    startProgram: student.startProgram ?? Date(),
                    address: student.address ?? "",
                    gender: Int(student.gender),
                    completedZiyadah: convertToCompletedZiyadahArray(
                        completedZiyadahSet: student.completedZiyadah
                    ) ?? [],
                    createdAt: student.createdAt ?? Date(),
                    updatedAt: student.updatedAt ?? Date(),
                    studentPreference: convertToStudentPreferenceEntity(studentPreference: student.studentPreference),
                    attendanceData: convertToAttendanceArray(attendanceSet: student.attendance) ?? [],
                    ziyadahData: convertToZiyadahArray(ziyadahSet: student.ziyadah) ?? [],
                    murojaahData: convertToMurojaahArray(murojaahSet: student.murojaah) ?? []
                )
            }
            completion(.success(studentEntities))
        } catch {
            completion(.failure(error))
        }
    }
    
    func createStudent(
        student: StudentEntity,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    ) {
        let newStudent = Student(context: viewContext)
        newStudent.id = UUID()
        newStudent.name = student.name
        newStudent.address = student.address
        newStudent.gender = Int32(student.gender)
        newStudent.birthDate = student.birthDate
        newStudent.startProgram = student.startProgram
        newStudent.createdAt = Date()
        newStudent.updatedAt = Date()
        newStudent.studentPreference = createStudentPreference(studentPreference: studentPreference)
        
        do {
            try viewContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateStudent(
        id: UUID,
        student: StudentEntity,
        preferenceId: UUID,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    ) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedStudents = try viewContext.fetch(fetchRequest)
            if let fetchedStudent = fetchedStudents.first {
                fetchedStudent.name = student.name
                fetchedStudent.address = student.address
                fetchedStudent.gender = Int32(student.gender)
                fetchedStudent.birthDate = student.birthDate
                fetchedStudent.startProgram = student.startProgram
                fetchedStudent.updatedAt = Date()
                updateStudentPreference(id: preferenceId, studentPreference: studentPreference)
                try viewContext.save()
                completion(.success(true))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func deleteStudent(
        id: UUID,
        completion: @escaping CompletionHandler
    ) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedStudents = try viewContext.fetch(fetchRequest)
            if let fetchedStudent = fetchedStudents.first {
                // Delete related studentPreference objects
                if let studentPreference = fetchedStudent.studentPreference {
                    viewContext.delete(studentPreference)
                }
                // Delete all related Attendance objects
                if let attendances = fetchedStudent.attendance as? Set<Attendance> {
                    for attendance in attendances {
                        viewContext.delete(attendance)
                    }
                }
                // Delete all related Ziyadah objects
                if let ziyadahs = fetchedStudent.ziyadah as? Set<Ziyadah> {
                    for ziyadah in ziyadahs {
                        viewContext.delete(ziyadah)
                    }
                }
                // Delete all related Murojaah objects
                if let murojaahs = fetchedStudent.murojaah as? Set<Murojaah> {
                    for murojaah in murojaahs {
                        viewContext.delete(murojaah)
                    }
                }
                // Delete the student entity itself
                viewContext.delete(fetchedStudent)
                try viewContext.save()
                completion(.success(true))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func updateCompletedZiyadah(
        id: UUID,
        juz: Int,
        completion: @escaping CompletionHandler
    ) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedStudents = try viewContext.fetch(fetchRequest)
            if let fetchedStudent = fetchedStudents.first {
                let newCompletedZiyadah = CompletedZiyadah(context: viewContext)
                newCompletedZiyadah.id = UUID()
                newCompletedZiyadah.juz = Int16(juz)
                newCompletedZiyadah.createdAt = Date()
                newCompletedZiyadah.updatedAt = Date()
                fetchedStudent.addToCompletedZiyadah(newCompletedZiyadah)
                try viewContext.save()
                completion(.success(true))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}

extension StudentCoreDataAdapter {
    private func createStudentPreference(studentPreference: StudentPreferenceEntity) -> StudentPreference {
        let preference = StudentPreference(context: viewContext)
        preference.id = UUID()
        preference.memorizeStatus = studentPreference.memorizeStatus
        preference.monthlyTarget = Int32(studentPreference.monthlyTarget)
        preference.yearlyTarget = Int32(studentPreference.yearlyTarget)
        preference.startSprint = studentPreference.startSprint
        preference.endSprint = studentPreference.endSprint
        preference.createdAt = Date()
        preference.updatedAt = Date()
        do {
            try viewContext.save()
            print("StudentPreference created successfully")
        } catch {
            print("Failed to create StudentPreference: \(error)")
        }
        return preference
    }
    private func deleteStudentPreference(id: UUID) {
        let fetchRequest: NSFetchRequest<StudentPreference> = StudentPreference.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedPreferences = try viewContext.fetch(fetchRequest)
            if let fetchedPreference = fetchedPreferences.first {
                viewContext.delete(fetchedPreference)
                try viewContext.save()
                print("StudentPreference deleted successfully")
            } else {
                print("StudentPreference not found")
            }
        } catch let error {
            print("Error deleting student preference: \(error)")
        }
    }
    private func updateStudentPreference(id: UUID, studentPreference: StudentPreferenceEntity) {
        let fetchRequest: NSFetchRequest<StudentPreference> = StudentPreference.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let fetchedPreferences = try viewContext.fetch(fetchRequest)
            if let fetchedPreference = fetchedPreferences.first {
                fetchedPreference.memorizeStatus = studentPreference.memorizeStatus
                fetchedPreference.monthlyTarget = Int32(studentPreference.monthlyTarget)
                fetchedPreference.yearlyTarget = Int32(studentPreference.yearlyTarget)
                fetchedPreference.startSprint = studentPreference.startSprint
                fetchedPreference.endSprint = studentPreference.endSprint
                fetchedPreference.updatedAt = Date()
                try viewContext.save()
                print("Student updated successfully")
            } else {
                print("Student not found")
            }
        } catch let error {
            print("Error updating student: \(error)")
        }
    }
    private func convertToStudentPreferenceEntity(studentPreference: StudentPreference?) -> StudentPreferenceEntity? {
        guard let preference = studentPreference else {
            return nil
        }
        return StudentPreferenceEntity(id: preference.id ?? UUID(),
                                       memorizeStatus: preference.memorizeStatus ?? "",
                                       monthlyTarget: Int(preference.monthlyTarget),
                                       yearlyTarget: Int(preference.yearlyTarget),
                                       startSprint: preference.startSprint,
                                       endSprint: preference.endSprint,
                                       createdAt: preference.createdAt ?? Date(),
                                       updatedAt: preference.updatedAt ?? Date())
    }
    private func convertToAttendanceArray(attendanceSet: NSSet?) -> [AttendanceEntity]? {
        guard let attendanceSet = attendanceSet else {
            return nil
        }
        return attendanceSet.compactMap { attendance in
            if let attendance = attendance as? Attendance {
                return AttendanceEntity(
                    id: attendance.id ?? UUID(),
                    attendStatus: attendance.attendStatus,
                    timeLabel: attendance.timeLabel ?? "",
                    reason: attendance.reason ?? "",
                    createdAt: attendance.createdAt ?? Date(),
                    updatedAt: attendance.updatedAt ?? Date()
                )
            }
            return nil
        }
    }
    private func convertToZiyadahArray(ziyadahSet: NSSet?) -> [ZiyadahEntity]? {
        guard let ziyadahSet = ziyadahSet else {
            return nil
        }
        return ziyadahSet.compactMap { ziyadah in
            if let ziyadah = ziyadah as? Ziyadah {
                return ZiyadahEntity(
                    id: ziyadah.id ?? UUID(),
                    juz: Int(ziyadah.juz),
                    page: Int(ziyadah.page),
                    memorizeValue: (MemorizeValue(rawValue: ziyadah.memorizeValue ?? "") ?? .aValue).rawValue,
                    recitationValue: (MemorizeValue(rawValue: ziyadah.recitationValue ?? "") ?? .aValue).rawValue,
                    createdAt: ziyadah.createdAt ?? Date(),
                    updatedAt: ziyadah.updatedAt ?? Date()
                )
            }
            return nil
        }
    }
    private func convertToMurojaahArray(murojaahSet: NSSet?) -> [MurojaahEntity]? {
        guard let murojaahSet = murojaahSet else {
            return nil
        }
        return murojaahSet.compactMap { murojaah in
            if let murojaah = murojaah as? Murojaah {
                return MurojaahEntity(
                    id: murojaah.id ?? UUID(),
                    category: murojaah.category ?? "",
                    key: murojaah.key ?? "",
                    value: murojaah.value ?? "",
                    createdAt: murojaah.createdAt ?? Date(),
                    updatedAt: murojaah.updatedAt ?? Date()
                )
            }
            return nil
        }
    }
    private func convertToCompletedZiyadahArray(completedZiyadahSet: NSSet?) -> [CompletedZiyadahEntity]? {
        guard let completedZiyadahSet = completedZiyadahSet else {
            return nil
        }
        return completedZiyadahSet.compactMap { completedZiyadah in
            if let completedZiyadah = completedZiyadah as? CompletedZiyadah {
                return CompletedZiyadahEntity(
                    id: completedZiyadah.id ?? UUID(),
                    juz: Int(completedZiyadah.juz),
                    createdAt: completedZiyadah.createdAt ?? Date(),
                    updatedAt: completedZiyadah.updatedAt ?? Date())
            }
            return nil
        }
    }
}
