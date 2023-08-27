//
//  AttendanceHistorySection.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct SummarySection: View {
    @EnvironmentObject var studentVM: StudentViewModel
    var body: some View {
        Section {
            SummaryRowView(
                destination: SummaryZiyadah(students: studentVM.students),
                imageName: "z.square.fill",
                title: "Ziyadah",
                color: Color.green)
            SummaryRowView(
                destination: SummaryAttendance(students: studentVM.students),
                imageName: "text.badge.checkmark",
                title: "Attendance",
                color: Color.orange)
        } header: {
            headerView
        }
    }
    private var headerView: some View {
        HStack {
            HStack {
                Image(systemName: "square.stack.3d.up.fill")
                Text("Summary")
            }
            .font(.headline)
            .textCase(nil)
            Spacer()
        }
    }
}
