//
//  StudentDetailView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/07/23.
//

import SwiftUI

struct StudentEditorScreen: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var studentVM: StudentViewModel
    @StateObject var studentEditorVM: StudentEditorViewModel
    init(student: StudentEntity? = nil) {
        _studentEditorVM = StateObject(wrappedValue: StudentEditorViewModel(student: student))
    }
    var disableForm: Bool { studentEditorVM.name.isEmpty || studentEditorVM.address.isEmpty }
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Identity") {
                    TextField("Full Name", text: $studentEditorVM.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .textInputAutocapitalization(.words)
                    TextField("Address", text: $studentEditorVM.address)
                    Picker(selection: $studentEditorVM.gender, label: Text("Gender")) {
                        ForEach(GenderOption.allCases, id: \.self) { option in
                            Text(option.description).tag(option.rawValue)
                        }
                    }
                    .pickerStyle(.automatic)
                    DatePicker("Date of Birth", selection: $studentEditorVM.birthDate, displayedComponents: .date)
                        .pickerStyle(.automatic)
                }
                Section ("Program") {
                    DatePicker("Start Program", selection: $studentEditorVM.startProgram, displayedComponents: .date)
                        .pickerStyle(.automatic)
                }
                Section ("Current Status") {
                    Picker(selection: $studentEditorVM.memorizeStatus, content: {
                        ForEach(MemorizeCategory.allCases, id: \.self) { item in
                            Text(item.rawValue).tag(item.rawValue)
                        }
                    }, label: {
                        Text("Memorization")
                    })
                    DatePicker("Start Sprint", selection: $studentEditorVM.startSprint, displayedComponents: .date)
                        .pickerStyle(.automatic)
                    DatePicker("End Sprint", selection: $studentEditorVM.endSprint, displayedComponents: .date)
                        .pickerStyle(.automatic)
                }
                
                Section("Monthly Target (Pages)") {
                    TextField("Total Pages", value: $studentEditorVM.monthlyTarget, format: .number)
                        .keyboardType(.numberPad)
                }
                Section {
                    TextField("Total Juz", value: $studentEditorVM.yearlyTarget, format: .number)
                        .keyboardType(.numberPad)
                } header: {
                    Text("Yearly Target (Juz)")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        studentVM.isLoading = true
                        if studentEditorVM.id == nil {
                            newStudentSaveAction()
                        } else {
                            editStudentSaveAction()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .fontWeight(.bold)
                    }
                    .disabled(disableForm)
                }
            }
            .toolbarRole(.editor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
    private func newStudentSaveAction() {
        studentVM.createStudent(
            student: StudentEntity(
                name: studentEditorVM.name,
                birthDate: studentEditorVM.birthDate,
                startProgram: studentEditorVM.startProgram,
                address: studentEditorVM.address,
                gender: studentEditorVM.gender
            ), studentPreference: StudentPreferenceEntity(
                memorizeStatus: studentEditorVM.memorizeStatus,
                monthlyTarget: studentEditorVM.monthlyTarget,
                yearlyTarget: studentEditorVM.yearlyTarget,
                startSprint: studentEditorVM.startSprint,
                endSprint: studentEditorVM.endSprint)
        ) { result in
            switch result {
            case .success:
                studentVM.isLoading = false
                studentVM.presentNewStudentSheet = false
            case .failure(let error):
                print(error)
            }
        }
    }
    private func editStudentSaveAction() {
        studentVM.updateStudent(
            id: studentEditorVM.id!,
            newStudent: StudentEntity(
                id: studentEditorVM.id!,
                name: studentEditorVM.name,
                birthDate: studentEditorVM.birthDate,
                startProgram: studentEditorVM.startProgram,
                address: studentEditorVM.address,
                gender: studentEditorVM.gender
            ),
            preferenceId: studentEditorVM.preferenceId!,
            studentPreference: StudentPreferenceEntity(
                memorizeStatus: studentEditorVM.memorizeStatus,
                monthlyTarget: studentEditorVM.monthlyTarget,
                yearlyTarget: studentEditorVM.yearlyTarget,
                startSprint: studentEditorVM.startSprint,
                endSprint: studentEditorVM.endSprint)
        ) { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                print(error)
            }
        }
    }
}
