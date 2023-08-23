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
            DashboardScreen()
                .environment(\.managedObjectContext, persistanceController.container.viewContext)
                .environmentObject(studentVM)
                .environmentObject(userScheduleVM)
                .environmentObject(userVM)
                .environmentObject(memorizeVM)
        }
    }
}
