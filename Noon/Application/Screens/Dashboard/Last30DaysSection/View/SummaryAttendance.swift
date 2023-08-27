//
//  SummaryAttendance.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 26/08/23.
//

import SwiftUI

struct SummaryAttendance: View {
    @State private var selectedCategory: String = "Today"
    let category: [String] = ["Today", "Week", "Month", "Year"]
    var students: [StudentEntity]
    var studentByAttendance: [UUID: (trueCount: Int, falseCount: Int)] {
        let calendar = Calendar.current
        let currentDate = Date() // Current date
        
        return students.reduce(into: [UUID: (trueCount: Int, falseCount: Int)]()) { counts, student in
            let recentAttendance = student.attendanceData.filter { data in
                switch selectedCategory {
                case "Today":
                    return calendar.isDateInToday(data.createdAt)
                case "Week":
                    return calendar.isDate(data.createdAt, inSameDayAs: currentDate) ||
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .weekOfYear)
                case "Month":
                    return calendar.isDate(data.createdAt, inSameDayAs: currentDate) ||
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .month)
                case "Year":
                    return calendar.isDate(data.createdAt, inSameDayAs: currentDate) ||
                    calendar.isDate(data.createdAt, equalTo: currentDate, toGranularity: .year)
                default:
                    return false
                }
            }
            
            let trueCount = recentAttendance.filter { $0.attendStatus }.count
            let falseCount = recentAttendance.filter { !$0.attendStatus }.count
            
            counts[student.id] = (trueCount: trueCount, falseCount: falseCount)
        }
    }
    
    var body: some View {
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
                    ForEach(studentByAttendance.sorted(by: { $0.value > $1.value }), id: \.key) { id, count in
                        VStack(alignment: .leading) {
                            Text(students.first(where: { $0.id == id })?.name ?? "Unknown")
                                .font(.headline)
                                .lineLimit(1)
                            HStack {
                                Text("\(count.trueCount + count.falseCount) sessions")
                                    .foregroundColor(.secondary)
                                Spacer()
                                HStack {
                                    Image(systemName: AttendanceIconSign.present.rawValue)
                                        .foregroundColor(Color.green)
                                    Text("\(count.trueCount)")
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Image(systemName: AttendanceIconSign.absent.rawValue)
                                        .foregroundColor(Color.red)
                                    Text("\(count.falseCount)")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .font(.subheadline)
                        }
                    }
                }
            }
        }
        .background(Color(UIColor.systemGray6))
        .onAppear {
            print(DateUtils.getDateFromMonth(month: 1, year: 1000))
        }
        .navigationTitle("Attendance")
    }
}
