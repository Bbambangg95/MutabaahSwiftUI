//
//  MurojaahPerJuzForm.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/08/23.
//

import SwiftUI

struct MurojaahPerJuzForm: View {
    @Binding var key: String
    @Binding var value: String
    @State private var selectedJuzs: Set<String> = []
    let juzData = JuzData()
    var body: some View {
        Section(header: Text("Detail")) {
            Picker(selection: $key) {
                Text("Select Total Juz...").tag("")
                ForEach(MurojaahPerJuzAmount.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option.rawValue)
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "list.bullet.rectangle.fill", color: Color.blue)
                    Text("Total Juz")
                }
            }
            .listStyle(.automatic)
            .pickerStyle(.navigationLink)
            NavigationLink {
                List {
                    ForEach(juzData.juzData, id: \.self) { juz in
                        Button {
                            if self.selectedJuzs.contains("\(juz.juzNumber)") {
                                self.selectedJuzs.remove("\(juz.juzNumber)")
                            } else {
                                self.selectedJuzs.insert("\(juz.juzNumber)")
                            }
                            self.value = self.selectedJuzs.isEmpty
                            ? ""
                            : self.selectedJuzs.sorted().joined(separator: ",")
                        } label: {
                            HStack {
                                Text("Juz \(juz.juzNumber)")
                                    .foregroundColor(.black)
                                Spacer()
                                if self.selectedJuzs.contains("\(juz.juzNumber)") {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                .disabled(MurojaahPerJuzAmount.moreThanTwenty.maxValue == 0)
                .listStyle(.automatic)
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "books.vertical.fill", color: Color.green)
                    Text("Select Juz")
                    Spacer()
                    Text(value)
                        .opacity(0.5)
                }
            }
        }
    }
}
