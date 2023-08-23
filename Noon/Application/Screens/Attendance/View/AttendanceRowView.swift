//
//  AttendanceRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 09/08/23.
//

import SwiftUI

struct AttendanceRowView: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @StateObject private var attendanceVM = AttendanceViewModel()
    @EnvironmentObject var userScheduleVM: UserScheduleViewModel
    var student: StudentEntity
    var body: some View {
        HStack {
            Text(student.name)
                .font(.headline)
                .lineLimit(1)
            Spacer()
            switch getTodayAttendanceData(attendanceData: student.attendanceData) {
            case true:
                Image(systemName: AttendanceIconSign.present.rawValue)
            case false:
                Image(systemName: AttendanceIconSign.absent.rawValue)
            case nil:
                Image(systemName: AttendanceIconSign.notUpdated.rawValue)
            default:
                EmptyView()
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                withAnimation {
                    attendanceAction(student: student, attendStatus: false)
                }
            } label: {
                Image(systemName: AttendanceIconSign.absent.rawValue)
            }
            Button {
                withAnimation {
                    attendanceAction(student: student, attendStatus: true)
                }
            } label: {
                Image(systemName: AttendanceIconSign.present.rawValue)
            }
            .tint(.green)
        }
    }
    private func getTodayAttendanceData(attendanceData: [AttendanceEntity]) -> Bool? {
        let filteredAttendance = attendanceData.filter { item in
            Calendar.current.isDateInToday(item.createdAt) &&
            item.timeLabel == userScheduleVM.selectedClassTime
        }
        if let existingAttendance = filteredAttendance.first {
            let attendStatus = existingAttendance.attendStatus
            return attendStatus
        } else {
            return nil
        }
    }
    private func attendanceAction(student: StudentEntity, attendStatus: Bool) {
        attendanceVM.createAttendance(
            student: student,
            timeLabel: userScheduleVM.selectedClassTime,
            attendStatus: attendStatus
        )
        studentVM.fetchStudent()
    }
}
