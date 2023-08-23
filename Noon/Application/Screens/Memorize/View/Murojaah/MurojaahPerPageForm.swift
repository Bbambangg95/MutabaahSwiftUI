//
//  MurojaahPerPageForm.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/08/23.
//

import SwiftUI

struct MurojaahPerPageForm: View {
    @Binding var key: String
    @Binding var value: String
    let juzData = JuzData()
    var body: some View {
        Section {
            Picker(selection: $key) {
                Text("Select Juz...").tag("")
                ForEach(juzData.juzData, id: \.self) { juz in
                    Text("Juz \(juz.juzNumber)").tag("\(juz.juzNumber)")
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "books.vertical.fill", color: Color.blue)
                    Text("Juz")
                }
            }
            .listStyle(.automatic)
            .pickerStyle(.navigationLink)
            Picker(selection: $value) {
                Text("Select Page...").tag("")
                ForEach(juzData.getPageDetailNumber(selectedJuz: Int(key) ?? 0), id: \.self) { page in
                    Text("Page \(page.pageNumber) (\(page.pageOrder))")
                        .tag("\(page.pageNumber)")
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "book.fill", color: Color.green)
                    Text("Page")
                }
            }
            .listStyle(.plain)
            .pickerStyle(.navigationLink)
        } header: {
            Text("Detail")
        }
    }
}
