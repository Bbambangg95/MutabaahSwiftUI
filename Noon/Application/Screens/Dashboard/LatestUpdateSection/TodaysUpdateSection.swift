//
//  HistoryCardView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct TodaysUpdateSection: View {
    @Binding var presentTodaysUpdateSheet: Bool
    var memorize: [MemorizeEntity]
    var body: some View {
        Section {
            ForEach(memorize.prefix(5)) { memorize in
                TodaysUpdateRowView(memorize: memorize)
            }
        } header: {
            headerView
        }
    }
    private var headerView: some View {
        HStack {
            Image(systemName: "clock.arrow.circlepath")
            Text("Latest Update")
            Spacer()
            Button {
                presentTodaysUpdateSheet = true
            } label: {
                Text("See All")
            }
        }
        .font(.headline)
        .textCase(nil)
    }
}
