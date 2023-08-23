//
//  StudentList.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 01/07/23.
//
import SwiftUI

struct StudentListScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
    var body: some View {
        List {
            ForEach(studentVM.students) { student in
                StudentListRowView(student: student) {
                    studentVM.deleteStudent(id: student.id)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Students")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            NavigationLink {
                StudentEditorScreen(studentEditorVM: StudentEditorViewModel())
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
