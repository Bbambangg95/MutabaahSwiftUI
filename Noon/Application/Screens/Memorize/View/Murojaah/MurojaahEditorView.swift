//
//  MurojaahEditorView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import SwiftUI

struct MurojaahEditorView: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @EnvironmentObject var memorizeVM: MemorizeViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var murojaahVM = MurojaahViewModel()
    @State private var selectedJuzs: Set<String> = []
    let juzData = JuzData()
    var student: StudentEntity
    var disableSaveButton: Bool {
        murojaahVM.key.isEmpty || murojaahVM.value.isEmpty
    }
    var body: some View {
        Form {
            MurojaahCategoryPicker(category: $murojaahVM.category)
            switch murojaahVM.category {
            case MurojaahAmountOptions.perPage.rawValue:
                MurojaahPerPageForm(key: $murojaahVM.key, value: $murojaahVM.value)
            case MurojaahAmountOptions.perJuz.rawValue:
                MurojaahPerJuzForm(key: $murojaahVM.key, value: $murojaahVM.value)
            default:
                EmptyView()
            }
        }
        .scrollContentBackground(.hidden)
        .toolbar {
            Button {
                murojaahVM.createMurojaah(studentId: student.id)
                studentVM.fetchStudent()
                memorizeVM.fetchMemorize()
            } label: {
                Text("Save")
            }
            .disabled(disableSaveButton)
        }
    }
}
