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
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar {
                ToolbarItems.topTrailingBarItems(
                    userDetailScreen: UserDetailScreen()
                )
            }
            .toolbar {
                ToolbarItems.bottomBarItems(
                    presentMemorizeSheet: $presentMemorizeSheet,
                    presentAttendanceSheet: $presentAttendanceSheet
                )
            }
            .toolbar {
                ToolbarItems.topLeadingBarItems(userName: userVM.name.components(separatedBy: " ").first ?? "User")
            }
        }
        .sheet(isPresented: $presentMemorizeSheet) {
            MemorizeListScreen()
        }
        .sheet(isPresented: $presentAttendanceSheet) {
            AttendanceEditorScreen()
        }
        .sheet(isPresented: $presentTodaysUpdateSheet) {
            TodaysUpdateListSheet(
                memorize: memorizeVM.memorize
            )
        }
    }
}
