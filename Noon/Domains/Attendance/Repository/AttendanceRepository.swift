//
//  AttendanceRepository.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 09/08/23.
//

import Foundation

protocol AttendanceRepository {
    func createAttendance(studentId: UUID, attendance: AttendanceEntity)
    func updateAttendance(id: UUID, attendance: AttendanceEntity)
}
