//
//  NoonApp.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 01/07/23.
//

import SwiftUI

@main
struct NoonApp: App {
    @StateObject private var studentVM = StudentViewModel()
    @StateObject private var userScheduleVM = UserScheduleViewModel()
    @StateObject private var userVM = UserViewModel()
    @StateObject var memorizeVM = MemorizeViewModel()
    
    let persistanceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
//                DashboardScreen()
//                    .tabItem {
//                        Image(systemName: "square.grid.2x2.fill")
//                        Text("Dashboard")
//                    }
                StudentListScreen()
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Students")
                    }
                
                MemorizeListScreen()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Memorization")
                    }
                AttendanceEditorScreen()
                    .tabItem {
                        Image(systemName: "text.badge.checkmark")
                        Text("Attendance")
                    }
                UserDetailScreen()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .environment(\.managedObjectContext, persistanceController.container.viewContext)
            .environmentObject(studentVM)
            .environmentObject(userScheduleVM)
            .environmentObject(userVM)
            .environmentObject(memorizeVM)
        }
    }
}
