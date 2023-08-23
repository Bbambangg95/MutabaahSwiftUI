//
//  StudentService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation

class StudentService {
    private let studentRepository: StudentRepository
    
    init(studentRepository: StudentRepository) {
        self.studentRepository = studentRepository
    }
    
    func getStudents() -> [StudentEntity] {
        return studentRepository.getStudents()
    }
    
    func createStudent(student: StudentEntity, studentPreference: StudentPreferenceEntity) {
        return studentRepository.createStudent(student: student, studentPreference: studentPreference)
    }
    
    func updateStudent(id: UUID, student: StudentEntity, preferenceId: UUID, studentPreference: StudentPreferenceEntity) {
        return studentRepository.updateStudent(id: id, student: student, preferenceId: preferenceId, studentPreference: studentPreference)
    }
    
    func deleteStudent(id: UUID) {
        return studentRepository.deleteStudent(id: id)
    }
    
    func updateCompletedZiyadah(id: UUID, juz: Int) {
        return studentRepository.updateCompletedZiyadah(id: id, juz: juz)
    }
}
