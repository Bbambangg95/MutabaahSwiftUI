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
            VStack(alignment: .leading) {
                Text(Date(), style: .date)
                    .font(.footnote)
                Text("Hi, \(userName)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
    }
    static func topTrailingBarItems(userDetailScreen: UserDetailScreen) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                userDetailScreen
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color.primary)
//                Image("img")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 40)
//                    .clipShape(Circle())
//                    .clipped()
            }
        }
    }
    static func bottomBarItems(isMemoModalPresented: Binding<Bool>, isAttendModalPresented: Binding<Bool>) -> some ToolbarContent {
        return ToolbarItemGroup(placement: .bottomBar) {
            Button {
                isMemoModalPresented.wrappedValue = true
            } label: {
                Label("Add Memorize", systemImage: "note.text.badge.plus")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.blue)
                    .labelStyle(.titleAndIcon)
            }
            Button {
                isAttendModalPresented.wrappedValue = true
            } label: {
                Label("Attend", systemImage: "calendar.badge.plus")
                    .foregroundColor(Color.blue)
                    .labelStyle(.titleAndIcon)
            }
        }
    }
}
