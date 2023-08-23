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
    private var headerView: some View {
        HStack {
            NavigationLink {
                StudentListScreen()
            } label: {
                HStack {
                    Image(systemName: "shippingbox.fill")
                    Text("Students")
                        .fontWeight(.semibold)
                        .textCase(nil)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
            }
            Spacer()
            Picker("", selection: $userScheduleVM.selectedClassTime) {
                ForEach(userScheduleVM.userSchedule) { schedule in
                    Text(schedule.timeLabel).tag(schedule.timeLabel)
                        .textCase(nil)
                }
            }
            .pickerStyle(.automatic)
        }
    }
    private var attendanceCard: some View {
        HStack {
            VStack {
                CardView(
                    number: studentVM.students.count,
                    title: "Total",
                    color: Color.blue,
                    imageName: "person.2.circle.fill"
                )
                CardView(
                    number: checkedInStudent.count,
                    title: "Checked In",
                    color: Color.orange,
                    imageName: "checkmark.seal.fill"
                )
            }
            VStack {
                CardView(
                    number: StudentViewModel.getFilteredStudent(students: studentVM.students, attendStatus: true, timeLabel: userScheduleVM.selectedClassTime).count,
                    title: "Present",
                    color: Color.green,
                    imageName: "person.crop.circle.fill.badge.checkmark"
                )
                CardView(
                    number: StudentViewModel.getFilteredStudent(students: studentVM.students, attendStatus: false, timeLabel: userScheduleVM.selectedClassTime).count,
                    title: "Absent",
                    color: Color.red,
                    imageName: "person.crop.circle.fill.badge.xmark")
            }
        }
    }
}
