//
//  AttendanceHistorySection.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct Last30DaysSection: View {
    @State private var showFullscreenCover: Bool = false
    var body: some View {
        Section {
            Last30DaysRowView(
                destination: EmptyView(),
                imageName: "z.square.fill",
                title: "Ziyadah",
                data: "Based on all student",
                color: Color.green)
            Last30DaysRowView(
                destination: EmptyView(),
                imageName: "m.square.fill",
                title: "Murojaah",
                data: "Based on all student",
                color: Color.blue)
            Last30DaysRowView(
                destination: EmptyView(),
                imageName: "list.clipboard.fill",
                title: "Attendance",
                data: "Based on all student",
                color: Color.orange)
        } header: {
            headerView
        }
    }
    private var headerView: some View {
            Text("Last 30 Days")
    }
}
