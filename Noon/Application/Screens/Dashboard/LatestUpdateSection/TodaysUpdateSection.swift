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
        VStack{
            SectionHeaderView(showFullscreenCover: $showFullscreenCover, title: "Todays Update")
            LazyVStack {
                ForEach(memorizeVM.memorize.prefix(3)) { memorize in
                    TodaysUpdateRowView(memorize: memorize)
                }
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $showFullscreenCover) {
            TodaysUpdateListView(showFullscreenCover: $showFullscreenCover, memorize: memorizeVM.memorize)
        }
    }
    private var headerView: some View {
        HStack {
            Text("Latest Update")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Button {
                showFullscreenCover = true
            } label: {
                Text("See All")
            }
        }
    }
}
