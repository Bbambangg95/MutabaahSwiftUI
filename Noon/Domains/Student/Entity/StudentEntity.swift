//
//  StudentEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct StudentEntity: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var birthDate: Date = Date()
    var startProgram: Date = Date()
    var address: String = ""
    var gender: Int = 0
    var completedZiyadah: [CompletedZiyadahEntity] = []
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var studentPreference: StudentPreferenceEntity?
    var attendanceData: [AttendanceEntity] = []
    var ziyadahData: [ZiyadahEntity] = []
    var murojaahData: [MurojaahEntity] = []
}
