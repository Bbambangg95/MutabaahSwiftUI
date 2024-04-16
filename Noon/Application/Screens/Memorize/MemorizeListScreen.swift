//
//  AddMemorizeView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/07/23.
//

import SwiftUI

struct MemorizeListScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @State private var presentSummaryZiyadah: Bool = false
    @State private var watchAds: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(studentVM.students.sorted { $0.name < $1.name}) { student in
                    MemorizeListRowView(student: student)
                }
            }
            .sheet(isPresented: $presentSummaryZiyadah) {
                SummaryZiyadah(students: studentVM.students)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Memorization")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                            presentSummaryZiyadah.toggle()
                    } label: {
                        Image(systemName: "chart.bar.xaxis")
                    }
                }
            }
            
        }
    }
}
