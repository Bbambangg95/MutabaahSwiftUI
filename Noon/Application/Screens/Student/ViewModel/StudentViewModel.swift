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
    @Published var presentNewStudentSheet: Bool = false
    @Published var isLoading: Bool = false
    
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    private let studentService = StudentService(studentRepository: StudentCoreDataAdapter())
    
    init() {
        fetchStudents()
    }
    func fetchStudents() {
        isLoading = true

        getStudents { [weak self] students in
            DispatchQueue.main.async {
                self?.students = students
                self?.isLoading = false
            }
        }
    }
    func getStudents(completion: @escaping ([StudentEntity]) -> Void) {
        studentService.getStudents { result in
            switch result {
            case .success(let students):
                completion(students)
            case .failure:
                completion([])
            }
        }
    }
    func createStudent(
        student: StudentEntity,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    ) {
        studentService.createStudent(
            student: student,
            studentPreference: studentPreference
        ) {
            result in
            self.responseHandler(result, completion: completion)
        }
    }
    func updateStudent(
        id: UUID,
        newStudent: StudentEntity,
        preferenceId: UUID,
        studentPreference: StudentPreferenceEntity,
        completion: @escaping CompletionHandler
    ) {
        studentService.updateStudent(
            id: id,
            student: newStudent,
            preferenceId: preferenceId,
            studentPreference: studentPreference
        ) { result in
            self.responseHandler(result, completion: completion)
        }
    }
    func deleteStudent(
        id: UUID,
        completion: @escaping CompletionHandler
    ) {
        studentService.deleteStudent(id: id) { result in
            self.responseHandler(result, completion: completion)
        }
    }
    private func responseHandler(_ result: Result<Bool, Error>, completion: @escaping CompletionHandler) {
        switch result {
        case .success:
            completion(.success(true))
            self.fetchStudents()
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
