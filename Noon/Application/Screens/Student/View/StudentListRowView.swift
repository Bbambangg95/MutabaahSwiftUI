//
//  StudentListView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 04/08/23.
//

import SwiftUI

struct StudentListRowView: View {
    var student: StudentEntity
    var deleteStudent: () -> Void
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
