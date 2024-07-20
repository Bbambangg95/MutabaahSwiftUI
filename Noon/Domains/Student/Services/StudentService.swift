//
//  StudentService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation

class StudentService {
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    private let studentRepository: StudentRepository
    
    init(studentRepository: StudentRepository) {
        self.studentRepository = studentRepository
    }
    
    func getStudents(completion: @escaping (Result<[StudentEntity], Error>) -> Void) {
        return studentRepository.getStudents(completion: completion)
    }
    
    func createStudent(
        student: StudentEntity,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    ) {
        return studentRepository.createStudent(
            student: student,
            studentPreference: studentPreference,
            completion: completion
        )
    }
    
    func updateStudent(
        id: UUID,
        student: StudentEntity,
        preferenceId: UUID,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    ) {
        return studentRepository.updateStudent(
            id: id,
            student: student,
            preferenceId: preferenceId,
            studentPreference: studentPreference,
            completion: completion
        )
    }
    
    func deleteStudent(
        id: UUID,
        completion: @escaping CompletionHandler
    ) {
        return studentRepository.deleteStudent(
            id: id,
            completion: completion
        )
    }
    
    func updateCompletedZiyadah(
        id: UUID,
        juz: Int,
        completion: @escaping CompletionHandler
    ) {
        return studentRepository.updateCompletedZiyadah(
            id: id,
            juz: juz,
            completion: completion
        )
    }
    func deleteCompletedZiyadah(
        id: UUID,
        completion: @escaping CompletionHandler
    ) {
        return studentRepository.deleteCompletedZiyadah(
            id: id, 
            completion: completion
        )
    }
}
