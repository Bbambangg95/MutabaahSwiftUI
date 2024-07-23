//
//  ZiyadahEditorView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import SwiftUI

struct ZiyadahEditorView: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @EnvironmentObject var memorizeVM: MemorizeViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var ziyadahVM: ZiyadahViewModel
    @State private var isLoading: Bool = false
    let juzData = JuzData()
    var student: StudentEntity
    init(student: StudentEntity) {
        self.student = student
        _ziyadahVM = StateObject(wrappedValue: ZiyadahViewModel(student: student))
    }
    var body: some View {
        List {
            ZiyadahEditorDetailSection(
                ziyadahVM: ziyadahVM
            )
            ZiyadahEditorValueSection(
                memorizeValue: $ziyadahVM.memorizeValue,
                recitationValue: $ziyadahVM.recitationValue
            )
            .scrollDisabled(true)
//            ZiyadahEditorDateSection(
//                createdAt: $ziyadahVM.createdAt
//            )
            Section {
                ZiyadahHistoryItemView(ziyadahData: student.ziyadahData)
//                    .listRowBackground(Color.white.opacity(0.5))
            } header: {
                Text("Ziyadah History")
            }
        }
        .scrollContentBackground(.hidden)
        .onChange(of: ziyadahVM.juz) { _ in
            ziyadahVM.setLatestPage()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isLoading {
                    ProgressView()
                } else {
                    Button {
                        saveZiyadah()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        .alert(ziyadahVM.alertContent?.title ?? "", isPresented: $isLoading) {
            Button("Done") {
                dismiss()
                ziyadahVM.setLatestPage()
            }
        } message: {
            Text(ziyadahVM.alertContent?.message ?? "")
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
    private func saveZiyadah() {
        isLoading = true
        ziyadahVM.createZiyadah(studentId: student.id) { success in
            if success {
                studentVM.fetchStudents()
                memorizeVM.fetchMemorize()
            }
        }
    }
}
