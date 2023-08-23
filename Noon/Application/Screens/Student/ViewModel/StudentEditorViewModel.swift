//
//  StudentDetailViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation

class StudentEditorViewModel: ObservableObject {
    
    @Published var newStudent: StudentEntity?
    // Student Biodata
    @Published var id: UUID?
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var gender: Int = GenderOption.male.rawValue
    @Published var birthDate: Date = Date()
    @Published var startProgram: Date = Date()
    
    // Student Preference
    @Published var preferenceId: UUID?
    @Published var memorizeStatus: String = MemorizeCategory.ziyadah.rawValue
    @Published var monthlyTarget: Int = 0
    @Published var yearlyTarget: Int = 0
    @Published var startSprint: Date = Date()
    @Published var endSprint: Date = Date()
    
    var student: StudentEntity?
    
    init(student: StudentEntity? = nil) {
        self.student = student
        if let student = student {
            self.id = student.id
            self.name = student.name
            self.address = student.address
            self.gender = student.gender
            self.birthDate = student.birthDate
            self.startProgram = student.startProgram
            
            self.preferenceId = student.studentPreference?.id
            self.memorizeStatus = student.studentPreference?.memorizeStatus ?? MemorizeCategory.ziyadah.rawValue
            self.monthlyTarget = student.studentPreference?.monthlyTarget ?? 0
            self.yearlyTarget = student.studentPreference?.yearlyTarget ?? 0
            self.startSprint = student.studentPreference?.startSprint ?? Date()
            self.endSprint = student.studentPreference?.endSprint ?? Date()
        }
    }
}

