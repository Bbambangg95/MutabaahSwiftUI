//
//  HistoryCardView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/07/23.
//

import SwiftUI

struct TodaysUpdateSection: View {
    @EnvironmentObject var memorizeVM: MemorizeViewModel
    @State private var showFullscreenCover: Bool = false
    var body: some View {
        Section {
            ForEach(memorizeVM.memorize.prefix(3)) { memorize in
                TodaysUpdateRowView(memorize: memorize)
            }
        } header: {
            headerView
        }
        .sheet(isPresented: $showFullscreenCover) {
            TodaysUpdateListSheet(
                showFullscreenCover: $showFullscreenCover,
                memorize: memorizeVM.memorize
            )
        }
    }
    private var headerView: some View {
        HStack {
            Image(systemName: "clock.arrow.circlepath")
            Text("Latest Update")
            Spacer()
            Button {
                showFullscreenCover = true
            } label: {
                Text("See All")
            }
        }
        .font(.headline)
        .textCase(nil)
    }
}
