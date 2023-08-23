//
//  MurojaahCategoryPicker.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/08/23.
//

import SwiftUI

struct MurojaahCategoryPicker: View {
    @Binding var category: String
    var body: some View {
        Section {
            Picker(selection: $category) {
                ForEach(MurojaahAmountOptions.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option.rawValue)
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "tray.2.fill", color: Color.orange)
                    Text("Category")
                }
            }
            .pickerStyle(.navigationLink)
        } header: {
            Text("Detail")
        }
    }
}
