//
//  UpdateMemoView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/07/23.
//

import SwiftUI

struct MemorizeEditorScreen: View {
    @State private var memorizeCategory: String = MemorizeCategory.ziyadah.rawValue
    var student: StudentEntity
    var body: some View {
            VStack {
                Picker("Category", selection: $memorizeCategory) {
                    ForEach(MemorizeCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding([.horizontal, .top])
                switch memorizeCategory {
                case MemorizeCategory.ziyadah.rawValue:
                    ZiyadahEditorView(student: student)
                case MemorizeCategory.murojaah.rawValue:
                    MurojaahEditorView(student: student)
                default:
                    EmptyView()
                }
            }
            .background(.gray.opacity(0.2))
            .toolbarRole(.editor)
            .navigationTitle(student.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}
