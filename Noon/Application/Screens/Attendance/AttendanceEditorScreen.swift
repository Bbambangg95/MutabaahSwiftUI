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
    @State private var presentAttendanceSummary: Bool = false
    @State private var adsOrSubscribe: Bool = false
    @State private var watchAds: Bool = false
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
            VStack(spacing: .zero) {
                if disableForm {
                    setupScheduleSection
                } else {
                    List {
                        TodaysOverview()
                        attendanceList
                    }
                    .disabled(disableForm)
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Attendance")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                            presentAttendanceSummary.toggle()
                    } label: {
                        Image(systemName: "chart.bar.doc.horizontal")
                    }
                }
            }
            .sheet(isPresented: $presentAttendanceSummary) {
                SummaryAttendance(students: studentVM.students)
            }
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
        VStack {
            Picker("", selection: $userScheduleVM.selectedClassTime) {
                ForEach(userScheduleVM.userSchedule, id: \.id) { item in
                    Text(item.timeLabel).tag(item.id.uuidString)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .background(Color(UIColor.systemGray6))
    }
    private var attendanceList: some View {
        Section {
            ForEach(studentVM.students.sorted { $0.name < $1.name}) { student in
                AttendanceRowView(student: student)
            }
            if studentVM.students.isEmpty {
                Text("None")
                    .italic()
                    .font(.caption)
            }
        } header: {
            HStack {
                Spacer()
                Label("Swipe to the left to update.", systemImage: "chevron.left.2")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
                    .italic()
            }
        }
        //        .scrollContentBackground(.hidden)
    }
}
