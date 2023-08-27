//
//  StudentList.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 01/07/23.
//
import SwiftUI

struct StudentListScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @State private var alertDeleteStudent: Bool = false
    @State private var studentToDelete: StudentEntity?
    var body: some View {
        List {
            ForEach(studentVM.students) { student in
                StudentListRowView(student: student) {
                    studentToDelete = student
                    alertDeleteStudent.toggle()
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Students")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            Button {
                studentVM.presentNewStudentSheet = true
            } label: {
                Text("Add")
                    .font(.headline)
            }
        }
        .sheet(isPresented: $studentVM.presentNewStudentSheet) {
            StudentEditorScreen()
        }
        .alert("Delete", isPresented: $alertDeleteStudent) {
            Button(role: .destructive) {
                if let student = studentToDelete {
                    studentVM.deleteStudent(id: student.id) { result in
                        // Handle delete completion if needed
                    }
                }
                studentToDelete = nil
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                studentToDelete = nil
            } label: {
                Text("Cancel")
            }
        } message: {
                Text("All data related to \(studentToDelete?.name ?? "") will be permanently deleted. Are you sure you want to proceed?")
        }
    }
}

