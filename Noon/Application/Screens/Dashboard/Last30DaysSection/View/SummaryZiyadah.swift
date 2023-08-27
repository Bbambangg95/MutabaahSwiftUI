//
//  Last30DaysZiyadah.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/08/23.
//

import SwiftUI

struct Last30DaysZiyadah: View {
    @State private var selectedMonth: Date = Date()
    
    var students: [StudentEntity]
    var studentByZiyadah: [UUID: Int] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: selectedMonth)
        let currentYear = calendar.component(.year, from: selectedMonth)
        
        return students.reduce(into: [UUID: Int]()) { counts, student in
            let recentZiyadah = student.ziyadahData.filter { data in
                let components = calendar.dateComponents([.month, .year], from: data.createdAt)
                return components.month == currentMonth && components.year == currentYear
            }
            counts[student.id] = recentZiyadah.count
        }
    }
    var body: some View {
        List {
            Section {
                ForEach(studentByZiyadah.sorted(by: { $0.value > $1.value }), id: \.key) { id, count in
                    HStack {
                        Text(students.first(where: { $0.id == id })?.name ?? "Unknown")
                            .font(.headline)
                        Spacer()
                        Text("\(count) times")
                    }
                }
            } header: {
                Text("\(DateUtils.getMonthName(date: selectedMonth))")
            }
        }
        .onAppear {
            print(DateUtils.getDateFromMonth(month: 1, year: 1000))
        }
        .navigationTitle("Ziyadah")
    }
}
