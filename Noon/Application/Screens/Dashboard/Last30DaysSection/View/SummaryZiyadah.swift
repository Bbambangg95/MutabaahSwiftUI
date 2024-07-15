//
//  Last30DaysZiyadah.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 23/08/23.
//

import SwiftUI

struct SummaryZiyadah: View {
    @State private var selectedCategory: String = "Today"
    let category: [String] = ["Today", "Week", "Month", "Year"]
    var students: [StudentEntity]
    var studentByZiyadah: [UUID: Int] {
        let calendar = Calendar.current
        let currentDate = Date() // Current date
        
        return students.reduce(into: [UUID: Int]()) { counts, student in
            let recentZiyadah: [ZiyadahEntity]
            
            switch selectedCategory {
            case "Today":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDateInToday(data.createdAt)
                }
            case "Week":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDate(data.createdAt, inSameDayAs: currentDate) ||
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .weekOfYear)
                }
            case "Month":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDate(data.createdAt, inSameDayAs: currentDate) ||
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .month)
                }
            case "Year":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDate(data.createdAt, inSameDayAs: currentDate) ||
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .year)
                }
            default:
                recentZiyadah = []
            }
            
            counts[student.id] = recentZiyadah.count
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedCategory) {
                    ForEach(category, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                List {
                    Section {
                        ForEach(studentByZiyadah.sorted(by: { $0.value > $1.value }), id: \.key) { id, count in
                            HStack {
                                Text(students.first(where: { $0.id == id })?.name ?? "Unknown")
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "checkmark.icloud.fill")
                                    .foregroundColor(Color.green)
                                Text("\(count) times")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                            }
                        }
                        
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Ziyadah Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
