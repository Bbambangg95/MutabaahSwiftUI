//
//  ZiyadahEditorDetailSection.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 22/08/23.
//

import SwiftUI

struct ZiyadahEditorDetailSection: View {
    @ObservedObject var ziyadahVM: ZiyadahViewModel
    let juzData = JuzData()
    var body: some View {
        Section {
            Picker(selection: $ziyadahVM.juz) {
                ForEach(juzData.juzData, id: \.self) { juz in
                    Text("Juz \(juz.juzNumber)").tag(juz.juzNumber)
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "books.vertical.fill", color: Color.blue)
                    Text("Juz")
                }
            }
            .listStyle(.automatic)
            .pickerStyle(.navigationLink)
            Picker(selection: $ziyadahVM.page) {
                ForEach(juzData.getPageDetailNumber(selectedJuz: ziyadahVM.juz), id: \.self) { page in
                    Text("Page \(page.pageNumber) (\(page.pageOrder))").tag(page.pageNumber)
                }
            } label: {
                HStack {
                    ImageWithRectangleView(imageName: "book.fill", color: Color.green)
                    Text("Page")
                }
            }
            .disabled(true)
            .listStyle(.automatic)
            .pickerStyle(.navigationLink)
        } header: {
            Text("Detail")
        } footer: {
            Text("Warning: The Juz selection is based on the last ziyadah. Pages must be entered in sequential order.")
                .font(.caption2)
        }
    }
}
