//
//  AttendanceHistorySheet.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 28/08/23.
//

import SwiftUI

struct AttendanceHistorySheet: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @EnvironmentObject var userScheduleVM: UserScheduleViewModel
    var attendanceData: [AttendanceEntity]
    var body: some View {
        NavigationStack {
            List {
                rowView
            }
            .scrollIndicators(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("Attendance History")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color(UIColor.systemGray6))
    }
    private var rowView: some View {
        ForEach(groupedAttendanceData, id: \.self) { dayAttendance in
            Section(header: Text(dayAttendance.first?.createdAt ?? Date(), style: .date)) {
                ForEach(dayAttendance.sorted(by: { $0.createdAt > $1.createdAt })) { item in
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("\(userScheduleVM.userSchedule.first { $0.id.uuidString == item.timeLabel }?.timeLabel ?? "")")
                                .font(.subheadline)
                            HStack {
                                Text(item.createdAt, style: .time)
                            }
                            .font(.footnote)
                            .foregroundColor(Color.secondary)
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: item.attendStatus ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(item.attendStatus ? Color.green : Color.red)
                                Text("\(item.attendStatus ? "Present" : "Absent")")
                            }
                        }
                        .font(.subheadline)
                    }
                }
            }
        }
    }

    private var groupedAttendanceData: [[AttendanceEntity]] {
        Dictionary(grouping: attendanceData, by: { Calendar.current.startOfDay(for: $0.createdAt) })
            .values
            .sorted { $0.first?.createdAt ?? Date() > $1.first?.createdAt ?? Date() }
    }

//    private var rowView: some View {
//        ForEach(attendanceData.sorted(by: { $0.createdAt > $1.createdAt })) { item in
//            HStack(alignment: .bottom) {
//                VStack(alignment: .leading) {
//                    Text("\(userScheduleVM.userSchedule.first { $0.id.uuidString == item.timeLabel }?.timeLabel ?? "")")
//                        .font(.subheadline)
//                    HStack {
//                        Text(item.createdAt , style: .date)
//                        Text(item.createdAt , style: .time)
//                    }
//                    .font(.footnote)
//                    .foregroundColor(Color.secondary)
//                }
//                Spacer()
//                VStack {
//                    HStack {
//                        Image(systemName: item.attendStatus ? "checkmark.circle.fill" : "xmark.circle.fill")
//                            .foregroundColor(item.attendStatus ? Color.green : Color.red)
//                        Text("\(item.attendStatus ? "Present" : "Absent")")
//                    }
//                }
//                .font(.subheadline)
//            }
//            .swipeActions(edge: .trailing) {
//                Button {
//                    isDelete.toggle()
//                    itemToDelete = item
//                } label: {
//                    Image(systemName: "trash")
//                }
//                .tint(Color.red)
//            }
//        }
//    }
}
