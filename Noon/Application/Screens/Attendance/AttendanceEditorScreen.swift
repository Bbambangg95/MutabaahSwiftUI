//
//  FormAttendView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/07/23.
//

import SwiftUI

struct AttendanceEditorScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @EnvironmentObject var userScheduleVM: UserScheduleViewModel
    private var disableForm: Bool { userScheduleVM.userSchedule.isEmpty }
    private var unCheckStudent: [StudentEntity] {
        return studentVM.students.filter { student in
            student.attendanceData.filter { item in
                Calendar.current.isDateInToday(item.createdAt) &&
                item.timeLabel == userScheduleVM.selectedClassTime
            }.isEmpty
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                if disableForm {
                    setupScheduleSection
                } else {
                    picker
                    attendanceList
                }
            }
            .navigationTitle("Attendance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var setupScheduleSection: some View {
        Section {
            Text("You currently don't have any schedule set up. Please set up your schedule to ensure the attendance data is updated accurately.")
                .font(.headline)
                .padding()
            NavigationLink(destination: UserDetailScreen()) {
                Text("Set up schedule")
            }
        }
    }
    private var picker: some View {
        Picker("", selection: $userScheduleVM.selectedClassTime) {
            ForEach(userScheduleVM.userSchedule, id: \.timeLabel) { item in
                Text(item.timeLabel).tag(item.timeLabel)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    private var attendanceList: some View {
        List {
            AttendanceSectionView(
                students: unCheckStudent,
                title: "Not Updated",
                imageName: AttendanceIconSign.notUpdated.rawValue
            )
            AttendanceSectionView(
                students: StudentViewModel.getFilteredStudent(
                    students: studentVM.students,
                    attendStatus: true,
                    timeLabel: userScheduleVM.selectedClassTime
                ),
                title: "Present",
                imageName: AttendanceIconSign.present.rawValue
            )
            AttendanceSectionView(
                students: StudentViewModel.getFilteredStudent(
                    students: studentVM.students,
                    attendStatus: false,
                    timeLabel: userScheduleVM.selectedClassTime
                ),
                title: "Absent",
                imageName: AttendanceIconSign.absent.rawValue)
        }
        .disabled(disableForm)
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
    }
}
