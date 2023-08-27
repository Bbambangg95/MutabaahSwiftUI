//
//  ActivityScreen.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct TodaysUpdateListView: View {
    @Binding var showFullscreenCover: Bool
    var memorize: [MemorizeEntity] = []
    var body: some View {
        VStack {
            headerView
            ScrollView {
                LazyVStack {
                    ForEach(memorize) { memorize in
                        TodaysUpdateRowView(memorize: memorize)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
        }
    }
    private var headerView: some View {
        HStack {
            Spacer()
            Button {
                showFullscreenCover = false
            } label: {
                Text("Close")
                    .font(.headline)
            }
        }
        .padding()
    }
}

