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
            .pickerStyle(.automatic)
            HStack {
                HStack {
                    ImageWithRectangleView(imageName: "books.vertical.fill", color: Color.green)
                    Text("Juz")
                }
                Spacer()
                Menu {
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
                } label: {
                    HStack {
                        if !selectedJuzs.isEmpty {
                            Text(value)
                                .opacity(0.5)
                        } else {
                            Text("Select")
                        }
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.subheadline)
                    }
                    .foregroundStyle(Color.gray)
                }
                .menuActionDismissBehavior(.disabled)
            }
        }
    }
}
