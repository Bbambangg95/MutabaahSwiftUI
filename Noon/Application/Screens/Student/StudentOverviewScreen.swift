//
//  StudentOverviewScreen.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 12/08/23.
//

import SwiftUI
import Charts
import Foundation

struct StudentOverviewScreen: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @StateObject private var studentOverviewVM: StudentOverviewViewModel
    @State private var presentProgressSheet: Bool = false
    @State private var presentAttendanceSheet: Bool = false
    @State private var watchAds: Bool = false
    
    var student: StudentEntity
    let (dayLeftMessage, color): (String, Color)
    
    init(student: StudentEntity) {
        self.student = student
        (dayLeftMessage, color) = DateUtils.daysLeftMessage(endSprint: student.studentPreference?.endSprint ?? Date())
        _studentOverviewVM = StateObject(wrappedValue: StudentOverviewViewModel(student: student))
    }
    
    var sprintDaysLeft: Int {
        DateUtils.calculateIntervalInDays(
            startDate: student.studentPreference?.startSprint ?? Date(),
            endDate: student.studentPreference?.endSprint ?? Date()
        )
    }
    var completedZiyadah: String {
        let juzValues = student.completedZiyadah.compactMap { $0.juz }
        
        if juzValues.isEmpty {
            return ""
        } else {
            let juzStrings = juzValues.map { String($0) }
            return juzStrings.joined(separator: ", ")
        }
    }
    
    var body: some View {
        List {
            profileSection
            overviewSection
            currentStatusSection
            ziyadahSection
//            attendanceSection
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    studentOverviewVM.presentEditStudentSheet = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                Button {
                        presentProgressSheet.toggle()
                } label: {
                    Image(systemName: "book.fill")
                }
                Button {
                        presentAttendanceSheet.toggle()
                } label: {
                    Image(systemName: "text.badge.checkmark")
                }
            }
        }
        .sheet(
            isPresented: $studentOverviewVM.presentEditStudentSheet,
            onDismiss: {
                studentOverviewVM.presentEditStudentSheet = false
        }) {
            StudentEditorScreen(student: student)
        }
        .sheet(
            isPresented: $presentProgressSheet, onDismiss: {
            presentProgressSheet = false
        }) {
                ProgressHistorySheet(
                    ziyadahData: student.ziyadahData,
                    murojaahData: student.murojaahData
                )
        }
        .sheet(
            isPresented: $presentAttendanceSheet,
            onDismiss: {
                presentAttendanceSheet = false
            }
        ) {
            AttendanceHistorySheet(
                attendanceData: student.attendanceData
            )
        }
    }
    private var profileSection: some View {
        Section {
            Text(student.name)
                .font(.title2)
                .fontWeight(.semibold)
            StudentOverviewRowView(
                label: "Date of Birth",
                date: student.birthDate)
            StudentOverviewRowView(
                label: "Gender",
                value: "\((student.gender != 0) ? "Female" : "Male")")
            StudentOverviewRowView(
                label: "Address",
                value: student.address)
        } header: {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                Text("Identity")
                Spacer()
            }
            .font(.subheadline)
        }
    }
    private var overviewSection: some View {
        Section {
            VStack {
                StudentOverviewRowView(
                    label: "Total Memorization",
                    value: "\(student.completedZiyadah.count) Juz"
                )
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Detail Juz")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(completedZiyadah)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .foregroundColor(Color.secondary)
                .font(.footnote)
            }
            VStack {
                StudentOverviewRowView(
                    label: "Program Duration",
                    relativeDate: student.startProgram
                )
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Start From")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(student.startProgram, style: .date)
                    }
                }
                .foregroundColor(Color.secondary)
                .font(.footnote)
            }
        } header: {
            HStack {
                Image(systemName: "square.stack.3d.up.fill")
                Text("Overview")
            }
            .font(.subheadline)
        }
    }
    private var currentStatusSection: some View {
        Section {
            StudentOverviewRowView(
                label: "Memorization",
                value: student.studentPreference?.memorizeStatus ?? "Status not set"
            )
            VStack {
                StudentOverviewRowView(
                    label: "Sprint Duration",
                    value: "\(sprintDaysLeft) Days (\(dayLeftMessage))"
                )
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Start Sprint")
                        Text("End Sprint")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(student.studentPreference?.startSprint ?? Date(), style: .date)
                        Text(student.studentPreference?.endSprint ?? Date(), style: .date)
                    }
                }
                .foregroundColor(Color.secondary)
                .font(.footnote)
            }
        } header: {
            HStack {
                Image(systemName: "info.circle")
                Text("Current Status")
            }
            .font(.subheadline)
        }
    }
    private var ziyadahSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Ziyadah Target")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text("\(student.studentPreference?.monthlyTarget ?? 0) Pages/Month")
                Text("\(student.studentPreference?.yearlyTarget ?? 0) Juz/Year")
                Text("Target Achievement")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .padding(.top, 1)
                if studentOverviewVM.ziyadahChartData.count > 0 {
                    ChartView(data: studentOverviewVM.ziyadahChartData)
                } else {
                    Text("No Data Available")
                }
            }
        } header: {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text("Progress")
                Spacer()
            }
            .font(.subheadline)
        }
    }
    private var attendanceSection: some View {
        Section {
            Button {
                presentAttendanceSheet.toggle()
            } label: {
                HStack {
                    Text("Attendance History")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .tint(Color.black)
            Button {
                presentProgressSheet.toggle()
            } label: {
                HStack {
                    Text("Memorize History")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .tint(Color.black)
        } header: {
            HStack {
                Image(systemName: "calendar.badge.clock")
                Text("History")
                Spacer()
            }
            .font(.subheadline)
        }
    }
}
