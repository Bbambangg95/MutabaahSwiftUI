//
//  ZiyadahEditorDateSection.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 22/08/23.
//

import SwiftUI

struct ZiyadahEditorDateSection: View {
    @Binding var createdAt: Date
    var body: some View {
        Section {
            DatePicker(selection: $createdAt, displayedComponents: .date) {
                HStack {
                    ImageWithRectangleView(imageName: "calendar", color: Color.teal)
                    Text("Custom Date")
                }
            }
        } header: {
            Text("Custom Date")
        }
    }
}
