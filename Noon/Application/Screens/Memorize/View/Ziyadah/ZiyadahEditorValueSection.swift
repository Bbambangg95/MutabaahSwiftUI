//
//  ZiyadahEditorValueSection.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 22/08/23.
//

import SwiftUI

struct ZiyadahEditorValueSection: View {
    @Binding var memorizeValue: String
    @Binding var recitationValue: String
    var body: some View {
        Section(header: Text("Value")) {
            Picker(selection: $memorizeValue) {
                ForEach(MemorizeValue.allCases, id: \.self) { value in
                    Text(value.rawValue).tag(value.rawValue)
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "brain.head.profile", color: Color.orange)
                    Text("Memorization Value")
                }
            }
            .pickerStyle(.automatic)
            Picker(selection: $recitationValue) {
                ForEach(MemorizeValue.allCases, id: \.self) { value in
                    Text(value.rawValue).tag(value.rawValue)
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "waveform.and.mic", color: Color.teal)
                    Text("Recitation Value")
                }
            }
            .pickerStyle(.automatic)
        }
    }
}
