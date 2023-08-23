//
//  AttendanceViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 18/07/23.
//

import Foundation

class AttendanceViewModel: ObservableObject {
    private let attendanceService = AttendanceService(attendanceRepository: AttendanceCDA())
    func createAttendance(student: StudentEntity, timeLabel: String, attendStatus: Bool) {
        let newAttendance = AttendanceEntity(
            attendStatus: attendStatus,
            timeLabel: timeLabel
        )
        let filteredAttendance = student.attendanceData.filter { item in
            Calendar.current.isDateInToday(item.createdAt) &&
            item.timeLabel == timeLabel
        }
        if filteredAttendance.isEmpty {
            // Create new attendance
            print("Data belum ada")
            attendanceService.createAttendance(studentId: student.id, attendance: newAttendance)
        } else {
            // Get the id of the existing attendance
            guard let id = filteredAttendance.first?.id else {
                print("Error: Unable to get the id of the existing attendance")
                return
            }

            // Update existing attendance
            print("Data sudah ada")
            attendanceService.updateAttendance(id: id, attendance: newAttendance)
        }
    }
}
