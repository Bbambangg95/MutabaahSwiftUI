//
//  StudentListView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 04/08/23.
//

import SwiftUI

struct StudentListRowView: View {
    private let student: StudentEntity
    init(student: StudentEntity) {
        self.student = student
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
    }
}
