//
//  StudentViewModel+Extension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 15/08/23.
//

import Foundation

protocol DateCreatableEntity {
    var createdAt: Date { get }
}

extension StudentViewModel {
    static func createChartData<T: DateCreatableEntity>(data: [T]) -> [ChartData] {
        let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -11, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/yy"
        
        let filteredData = data.filter { $0.createdAt >= sixMonthsAgo }
        let groupedData = Dictionary(grouping: filteredData) { dateFormatter.string(from: $0.createdAt) }
        
        let chartData = groupedData.map { (key, value) in
            ChartData(xValue: key, yValue: value.count)
        }.sorted { (data1, data2) in
            return dateFormatter.date(from: data1.xValue)! < dateFormatter.date(from: data2.xValue)!
        }
        
        return chartData
    }

    static func createZiyadahChartData(data: [ZiyadahEntity]) -> [ChartData] {
        let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -11, to: Date())!
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "M/yy"
        return data.filter { $0.createdAt >= sixMonthsAgo }
            .reduce(into: [String: Int]()) { acc, next in
                let key = dateFormatter.string(from: next.createdAt)
                acc[key, default: 0] += 1
            }
            .map { ChartData(xValue: $0.key, yValue: $0.value) }
            .sorted { dateFormatter.date(from: $0.xValue)! < dateFormatter.date(from: $1.xValue)! }
    }
    static func createAttendanceChartData(data: [AttendanceEntity]) -> [ChartData] {
        let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -11, to: Date())!
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateFormat = "M/yy"
        return data.filter { $0.createdAt >= sixMonthsAgo }
            .reduce(into: [String: Int]()) { acc, next in
                let key = dateFormatter.string(from: next.createdAt)
                acc[key, default: 0] += 1
            }
            .map { ChartData(xValue: $0.key, yValue: $0.value) }
            .sorted { dateFormatter.date(from: $0.xValue)! < dateFormatter.date(from: $1.xValue)! }
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
    static func updateCompletedZiyadah(
        id: UUID,
        juz: Int,
        completion: @escaping CompletionHandler
    ) {
        let studentService = StudentService(studentRepository: StudentCoreDataAdapter())
        studentService.updateCompletedZiyadah(id: id, juz: juz) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
