//
//  PreferenceView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 07/08/23.
//

import SwiftUI

struct UserPreferenceView: View {
    var body: some View {
        Section {
            PreferenceRow(destination: UserScheduleEditorScreen())
        } header: {
            Text("Preference")
        }
    }
}

struct PreferenceRow<DestinationView: View>: View {
    var destination: DestinationView
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                Image(systemName: "calendar.badge.clock")
                    .foregroundColor(.white)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.yellow)
                    )
                Text("Schedule")
            }
        }
    }
}
