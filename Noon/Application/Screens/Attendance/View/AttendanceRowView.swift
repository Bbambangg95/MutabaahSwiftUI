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
    var todayAttendance: Bool? {
        attendanceVM.getTodayAttendanceData(attendanceData: student.attendanceData, timeLabel: userScheduleVM.selectedClassTime)
    }
    var body: some View {
        HStack {
            Text(student.name)
                .font(.headline)
                .lineLimit(1)
            Spacer()
            switch todayAttendance {
            case true:
                Image(systemName: AttendanceIconSign.present.rawValue)
                    .foregroundColor(Color.green)
            case false:
                Image(systemName: AttendanceIconSign.absent.rawValue)
                    .foregroundColor(Color.red)
            case nil:
                Image(systemName: AttendanceIconSign.notUpdated.rawValue)
                    .foregroundColor(Color.gray)
            default:
                EmptyView()
            }
        }
        .swipeActions(edge: .trailing) {
            Button {
                withAnimation {
                    attendanceAction(student: student, attendStatus: false)
                }
            } label: {
                Image(systemName: AttendanceIconSign.absent.rawValue)
            }
            .tint(Color.red)
            Button {
                withAnimation {
                    attendanceAction(student: student, attendStatus: true)
                }
            } label: {
                Image(systemName: AttendanceIconSign.present.rawValue)
            }
            .tint(Color.green)
        }
    }
    private func attendanceAction(student: StudentEntity, attendStatus: Bool) {
        attendanceVM.createAttendance(
            student: student,
            timeLabel: userScheduleVM.selectedClassTime,
            attendStatus: attendStatus
        )
        studentVM.fetchStudents()
    }
}
