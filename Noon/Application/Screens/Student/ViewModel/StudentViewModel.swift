//
//  StudentViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 17/07/23.
//

import Foundation
import CoreData
import SwiftUI

class StudentViewModel: ObservableObject {
    @Published var students: [StudentEntity] = []
    private let studentService = StudentService(studentRepository: StudentCoreDataAdapter())
    init() {
        fetchStudent()
    }
    func fetchStudent() {
        self.students = getStudents()
    }
    func getStudents() -> [StudentEntity] {
        return studentService.getStudents()
    }
    func createStudent(student: StudentEntity, studentPreference: StudentPreferenceEntity) {
        studentService.createStudent(student: student, studentPreference: studentPreference)
        fetchStudent()
    }
    func updateStudent(id: UUID, newStudent: StudentEntity, preferenceId: UUID, studentPreference: StudentPreferenceEntity) {
        studentService.updateStudent(id: id, student: newStudent, preferenceId: preferenceId, studentPreference: studentPreference)
        fetchStudent()
    }
    func deleteStudent(id: UUID) {
        studentService.deleteStudent(id: id)
        students.removeAll(where: { $0.id == id })
    }
}
