//
//  StudentRepository.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

protocol StudentRepository {
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    func getStudents(completion: @escaping (Result<[StudentEntity], Error>) -> Void)
    func createStudent(
        student: StudentEntity,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    )
    func updateStudent(
        id: UUID,
        student: StudentEntity,
        preferenceId: UUID,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    )
    func deleteStudent(
        id: UUID,
        completion: @escaping CompletionHandler
    )
    func updateCompletedZiyadah(
        id: UUID,
        juz: Int,
        completion: @escaping CompletionHandler
    )
    func deleteCompletedZiyadah(
        id: UUID,
        completion: @escaping CompletionHandler
    )
}
