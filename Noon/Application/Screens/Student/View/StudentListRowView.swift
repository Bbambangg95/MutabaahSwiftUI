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
                    HStack {
                        if let status = student.studentPreference?.memorizeStatus {
                            if status == MemorizeCategory.ziyadah.rawValue {
                                Image(systemName: "z.square.fill")
                                    .foregroundColor(Color.green)
                                Text(status)
                                    .font(.subheadline)
                            } else if status == MemorizeCategory.murojaah.rawValue  {
                                Image(systemName: "m.square.fill")
                                    .foregroundColor(Color.blue)
                                Text(status)
                                    .font(.subheadline)
                            }
                        }
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
