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
    
    typealias MemorizationCounts = (totalAll: Int, totalZiyadah: Int, totalMurojaah: Int)

    var studentByMemorizationCount: [UUID: MemorizationCounts] {
        let calendar = Calendar.current
        let currentDate = Date() // Current date
        
        return students.reduce(into: [UUID: MemorizationCounts]()) { counts, student in
            let recentZiyadah: [ZiyadahEntity]
            let recentMurojaah: [MurojaahEntity]
            
            switch selectedCategory {
            case "Today":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDateInToday(data.createdAt)
                }
                recentMurojaah = student.murojaahData.filter { data in
                    calendar.isDateInToday(data.createdAt)
                }
            case "Week":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .weekOfYear)
                }
                recentMurojaah = student.murojaahData.filter { data in
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .weekOfYear)
                }
            case "Month":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .month)
                }
                recentMurojaah = student.murojaahData.filter { data in
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .month)
                }
            case "Year":
                recentZiyadah = student.ziyadahData.filter { data in
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .year)
                }
                recentMurojaah = student.murojaahData.filter { data in
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .year)
                }
            default:
                recentZiyadah = []
                recentMurojaah = []
            }
            
            let totalZiyadahCount = recentZiyadah.count
            let totalMurojaahCount = recentMurojaah.count
            let totalAllCount = totalZiyadahCount + totalMurojaahCount
            
            counts[student.id] = (totalAllCount, totalZiyadahCount, totalMurojaahCount)
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
                        ForEach(studentByMemorizationCount.sorted(by: { $0.value.totalAll > $1.value.totalAll }), id: \.key) { id, counts in
                            if let student = students.first(where: { $0.id == id }) {
                                VStack(alignment: .leading) {
                                    Text(student.name)
                                        .font(.headline)
                                    HStack(alignment: .center) {
                                        Image(systemName: "checkmark.rectangle.stack.fill")
                                            .foregroundColor(Color.green)
                                            .font(.subheadline)
                                        Text("\(counts.totalAll) times")
                                            .font(.subheadline)
                                            .foregroundColor(Color.black)
                                        Text("(\(counts.totalZiyadah) Ziyadah | \(counts.totalMurojaah) Murojaah)")
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                    }
                                }
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
