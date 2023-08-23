//
//  SectionHeaderView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct SectionHeaderView: View {
    @Binding var showFullscreenCover: Bool
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Button {
                showFullscreenCover = true
            } label: {
                Text("See All")
            }
        }
    }
}
