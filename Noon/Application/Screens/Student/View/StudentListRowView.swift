//
//  StudentListView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 04/08/23.
//

import SwiftUI

struct StudentListRowView: View {
    private let student: StudentEntity
    private let deleteStudent: () -> Void
    init(student: StudentEntity, deleteStudent: @escaping () -> Void) {
        self.student = student
        self.deleteStudent = deleteStudent
    }
    var body: some View {
        HStack{
            NavigationLink {
                StudentOverviewScreen(student: student)
            } label: {
                VStack(alignment: .leading) {
                    Text(student.name )
                        .font(.headline)
                        .lineLimit(1)
                    HStack(alignment: .bottom) {
                        Image(systemName: "books.vertical.fill")
                            .foregroundColor(Color.blue)
                            .font(.subheadline)
                        Text("\(student.completedZiyadah.count) Juz")
                            .font(.subheadline)
                    }
                }
            }
        }
        .swipeActions(edge: .trailing, content: {
            Button(role: .destructive) {
                withAnimation {
                    deleteStudent()
                }
            } label: {
                Image(systemName: "trash")
            }
        })
    }
}
