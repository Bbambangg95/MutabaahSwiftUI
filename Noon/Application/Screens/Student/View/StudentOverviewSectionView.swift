//
//  StudentOverviewSectionView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 15/08/23.
//

import SwiftUI



struct StudentOverviewSectionView<Content: View>: View {
    var title: String
    var content: Content
    init(title: String, @ViewBuilder content: () -> Content) {
            self.title = title
            self.content = content()
        }
    var body: some View {
        Section {
            content
        } header: {
            Text(title)
        }
    }
}
