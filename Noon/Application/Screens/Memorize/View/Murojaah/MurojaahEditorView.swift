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
    let juzData = JuzData()
    var student: StudentEntity
    var disableSaveButton: Bool {
        murojaahVM.key.isEmpty || murojaahVM.value.isEmpty
    }
    var body: some View {
        List {
            MurojaahCategoryPicker(category: $murojaahVM.category)
                .onChange(of: murojaahVM.category) { newValue in
                    murojaahVM.key = ""
                    murojaahVM.value = ""
                }
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
                murojaahVM.isLoading = true
                murojaahVM.createMurojaah(studentId: student.id) { success in
                    if success {
                        studentVM.fetchStudents()
                        memorizeVM.fetchMemorize()
                    }
                }
            } label: {
                Text("Save")
            }
            .disabled(disableSaveButton)
        }
        .alert(murojaahVM.alertContent?.title ?? "Untitled", isPresented: $murojaahVM.isLoading) {
            Button {
                dismiss()
            } label: {
                Text("Done")
            }
        } message: {
            Text(murojaahVM.alertContent?.message ?? "")
        }

    }
}
