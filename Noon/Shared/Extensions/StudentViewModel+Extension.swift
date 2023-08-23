//
//  StudentViewModel+Extension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 15/08/23.
//

import Foundation

extension StudentViewModel {
    static func countDataForLastSixMonths(data: [ZiyadahEntity]) -> [ChartData] {
        let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -11, to: Date())!
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "M/yy"
        return data.filter { $0.createdAt >= sixMonthsAgo }
            .reduce(into: [String: Int]()) { acc, next in
                let key = dateFormatter.string(from: next.createdAt)
                acc[key, default: 0] += 1
            }
            .map { ChartData(xValue: $0.key, yValue: $0.value) }
            .sorted { dateFormatter.date(from: $0.xValue)! > dateFormatter.date(from: $1.xValue)! }
    }
    static func getFilteredStudent(
        students: [StudentEntity],
        attendStatus: Bool?,
        timeLabel: String) -> [StudentEntity] {
        return students.filter { student in
            return !(student.attendanceData.filter { item in
                let isDateInToday = Calendar.current.isDateInToday(item.createdAt)
                let isAttendStatusMatch = attendStatus == nil || item.attendStatus == attendStatus
                let isTimeLabelMatch = item.timeLabel == timeLabel
                return isDateInToday && isAttendStatusMatch && isTimeLabelMatch
            }.isEmpty)
        }
    }
    static func updateCompletedZiyadah(id: UUID, juz: Int) {
        let studentService = StudentService(studentRepository: StudentCoreDataAdapter())
        studentService.updateCompletedZiyadah(id: id, juz: juz)
    }
}
