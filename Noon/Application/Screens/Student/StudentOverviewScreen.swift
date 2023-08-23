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
    @StateObject private var studentOverviewVM: StudentOverviewViewModel
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
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink {
                StudentEditorScreen(studentEditorVM: StudentEditorViewModel(student: student))
            } label: {
                Image(systemName: "square.and.pencil")
            }
        }
    }
    private var profileSection: some View {
        Section {
            Text(student.name)
                .fontWeight(.semibold)
            StudentOverviewRowView(
                label: "Date of Birth",
                date: student.birthDate,
                imageName: "calendar",
                color: Color.yellow)
            StudentOverviewRowView(
                label: "Gender",
                value: "\((student.gender != 0) ? "Female" : "Male")",
                imageName: "person.fill",
                color: Color.green)
            StudentOverviewRowView(
                label: "Address",
                value: student.address,
                imageName: "location.fill",
                color: Color.blue)
        } header: {
            Text("Identity")
        }
    }
    private var overviewSection: some View {
        Section {
            StudentOverviewRowView(
                label: "Total Memorization",
                value: "\(student.completedZiyadah.count) Juz",
                imageName: "text.book.closed.fill",
                color: Color.green
            )
            HStack(alignment: .top) {
                ImageWithRectangleView(imageName: "info.square.fill", color: Color.gray)
                Text("Detail Juz")
                Spacer()
                Text(completedZiyadah)
            }
            StudentOverviewRowView(
                label: "Program Duration",
                relativeDate: student.startProgram,
                imageName: "person.crop.circle.badge.clock.fill",
                color: Color.orange)
        } header: {
            Text("Overview")
        }
    }
    private var currentStatusSection: some View {
        Section {
            StudentOverviewRowView(
                label: "Memorization",
                value: student.studentPreference?.memorizeStatus ?? "Status not set",
                imageName: "info.square.fill",
                color: Color.teal)
            StudentOverviewRowView(
                label: "Sprint Duration",
                value: "\(sprintDaysLeft) Days (\(dayLeftMessage))",
                imageName: "timer.circle.fill",
                color: Color.yellow)
            HStack(alignment: .top) {
                ImageWithRectangleView(imageName: "calendar.badge.exclamationmark", color: Color.gray)
                    .hidden()
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
            .foregroundColor(Color.gray)
        } header: {
            Text("Current Status")
        }
    }
    private var ziyadahSection: some View {
        Section {
            StudentOverviewRowView(
                label: "Monthly Target",
                value: "\(student.studentPreference?.monthlyTarget ?? 0) Pages",
                imageName: "target",
                color: Color.red)
            StudentOverviewRowView(
                label: "Yearly Target",
                value: "\(student.studentPreference?.yearlyTarget ?? 0) Juz",
                imageName: "target",
                color: Color.yellow)
            VStack(alignment: .leading) {
                Text("Ziyadah History Per Month")
                    .foregroundColor(Color.gray)
                if studentOverviewVM.ziyadahChartData.count > 0 {
                    ChartView(data: studentOverviewVM.ziyadahChartData)
                } else {
                    Text("No Data Available")
                }
            }
        } header: {
            Text("Ziyadah Progress")
        }
    }
}
