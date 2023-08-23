//
//  StudentRepository.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

protocol StudentRepository {
    func getStudents() -> [StudentEntity]
    func createStudent(student: StudentEntity, studentPreference: StudentPreferenceEntity)
    func updateStudent(id: UUID, student: StudentEntity, preferenceId: UUID, studentPreference: StudentPreferenceEntity)
    func deleteStudent(id: UUID)
    func updateCompletedZiyadah(id: UUID, juz: Int)
    
//    func createStudentPreference(studentPreference: StudentPreferenceEntity)
//    func updateStudentPreference(id: UUID, studentPreference: StudentPreferenceEntity)
//    func deleteStudentPreference(id: UUID)
    
}
