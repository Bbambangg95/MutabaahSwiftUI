//
//  ToolbarItems.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation
import SwiftUI


struct TopLeadingBarItems: ToolbarContent {
    var userName: String
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Hi, \(userName)")
                .font(.headline)
        }
    }
}

struct ToolbarItems {
    static func topLeadingBarItems(userName: String) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Hi, \(userName)")
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
        }
    }
    static func topTrailingBarItems(userDetailScreen: UserDetailScreen) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                userDetailScreen
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color.blue)
                    .font(.headline)
            }
        }
    }
    static func bottomBarItems(presentMemorizeSheet: Binding<Bool>, presentAttendanceSheet: Binding<Bool>) -> some ToolbarContent {
        return ToolbarItemGroup(placement: .bottomBar) {
            Button {
                presentMemorizeSheet.wrappedValue = true
            } label: {
                Label("Add Memorize", systemImage: "note.text.badge.plus")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.blue)
                    .labelStyle(.titleAndIcon)
            }
            Button {
                presentAttendanceSheet.wrappedValue = true
            } label: {
                Label("Attend", systemImage: "calendar.badge.plus")
                    .foregroundColor(Color.blue)
                    .labelStyle(.titleAndIcon)
            }
        }
    }
}
