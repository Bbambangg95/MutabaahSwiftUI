//
//  AttendanceService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 09/08/23.
//

import Foundation

class AttendanceService {
    private let attendanceRepository: AttendanceRepository
    init(attendanceRepository: AttendanceRepository) {
        self.attendanceRepository = attendanceRepository
    }
    func createAttendance(studentId: UUID, attendance: AttendanceEntity) {
        return attendanceRepository.createAttendance(studentId: studentId, attendance: attendance)
    }
    func updateAttendance(id: UUID, attendance: AttendanceEntity) {
        return attendanceRepository.updateAttendance(id: id, attendance: attendance)
    }
}
