//
//  AddMemorizeView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/07/23.
//

import SwiftUI

struct MemorizeListScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
//    var students: [StudentEntity]
    var body: some View {
        NavigationStack {
            List {
                ForEach(studentVM.students) { student in
                    MemorizeListRowView(student: student)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Memorize")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
