//
//  DashboardScreen.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct DashboardScreen: View {
    @State private var presentMemorizeSheet: Bool = false
    @State private var presentAttendanceSheet: Bool = false
    @State private var presentTodaysUpdateSheet: Bool = false
    @State private var testState: String = "Label"
    @State private var isExpand: Bool = false
    @EnvironmentObject var memorizeVM: MemorizeViewModel
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        NavigationStack {
            List {
                TodaysOverview()
                SummarySection()
                TodaysUpdateSection(
                    presentTodaysUpdateSheet: $presentTodaysUpdateSheet,
                    memorize: memorizeVM.memorize
                )
            }
            .background(Color(uiColor: .systemGray6))
            .navigationTitle("Dashboard")
        }
        .sheet(isPresented: $presentTodaysUpdateSheet) {
            TodaysUpdateListSheet(
                memorize: memorizeVM.memorize
            )
        }
    }
}
