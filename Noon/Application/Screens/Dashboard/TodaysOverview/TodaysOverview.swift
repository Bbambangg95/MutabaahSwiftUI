//
//  StudentCardView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct TodaysOverview: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @EnvironmentObject var userScheduleVM: UserScheduleViewModel
    var checkedInStudent: [StudentEntity] {
        StudentViewModel.getFilteredStudent(
            students: studentVM.students,
            attendStatus: nil,
            timeLabel: userScheduleVM.selectedClassTime
        )
    }
    var body: some View {
        Section {
                attendanceCard
        } header: {
                headerView
        }
    }
    var progressColor: Color {
        checkedInStudent.count == studentVM.students.count ? Color.blue : Color.orange
    }
    private var headerView: some View {
        HStack(alignment: .center) {
            Text(Date(), style: .date)
            Spacer()
            Picker("", selection: $userScheduleVM.selectedClassTime) {
                ForEach(userScheduleVM.userSchedule) { schedule in
                    Text(schedule.timeLabel).tag(schedule.id.uuidString)
                        .textCase(nil)
                }
            }
            .pickerStyle(.menu)
        }
    }
    private var attendanceCard: some View {
            HStack {
                HStack {
                    Image(systemName: checkedInStudent.count == studentVM.students.count ? AttendanceIconSign.present.rawValue : "circle.inset.filled")
                        .font(.title2)
                        .scaledToFill()
                        .foregroundColor(progressColor)
                        .padding(6)
                        .background(
                            Circle()
                                .foregroundColor(progressColor.opacity(0.2))
                        )
                    VStack(alignment: .leading) {
                        Text("\(checkedInStudent.count)/\(studentVM.students.count)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(progressColor)
                        Text("Updated")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
                CardView(
                    number: StudentViewModel.getFilteredStudent(students: studentVM.students, attendStatus: true, timeLabel: userScheduleVM.selectedClassTime).count,
                    title: NSLocalizedString("Present", comment: ""),
                    color: Color.green,
                    imageName: "person.crop.circle.fill.badge.checkmark"
                )
                CardView(
                    number: StudentViewModel.getFilteredStudent(students: studentVM.students, attendStatus: false, timeLabel: userScheduleVM.selectedClassTime).count,
                    title: NSLocalizedString("Absent", comment: ""),
                    color: Color.red,
                    imageName: "person.crop.circle.fill.badge.xmark")
            }
        
    }
}
