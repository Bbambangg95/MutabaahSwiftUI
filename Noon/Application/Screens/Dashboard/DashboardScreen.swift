//
//  DashboardScreen.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct DashboardScreen: View {
    @State var isMemoModalPresented: Bool = false
    @State var isAttendModalPresented: Bool = false
    var body: some View {
        NavigationStack {
            List {
                TodaysOverview()
                SummarySection()
                TodaysUpdateSection()
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar {
                ToolbarItems.topTrailingBarItems(
                    userDetailScreen: UserDetailScreen()
                )
            }
            .toolbar {
                ToolbarItems.bottomBarItems(
                    isMemoModalPresented: $isMemoModalPresented,
                    isAttendModalPresented: $isAttendModalPresented
                )
            }
        }
        .sheet(isPresented: $isMemoModalPresented) {
            MemorizeListScreen()
        }
        .sheet(isPresented: $isAttendModalPresented) {
            AttendanceEditorScreen()
        }
    }
}
