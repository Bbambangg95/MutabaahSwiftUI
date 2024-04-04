//
//  ExportUtils.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 03/04/24.
//

import Foundation
import UIKit

class ExportUtils {
    typealias CompletionHandler = (Result<URL, Error>) -> Void
    
    static func exportCSV(
        students: [StudentEntity],
        startDate: Date,
        dueDate: Date,
        completion: @escaping CompletionHandler
    ) {
        do {
            let csvString = convertToCSV(students: students, startDate: startDate, dueDate: dueDate)
            let fileName = "Report(\(DateUtils.getDateString(date: Date()))).csv"
            guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
                completion(.failure(NSError(domain: "ExportError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error creating file URL"])))
                return
            }
            do {
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                print("CSV file saved at: \(fileURL)")
                completion(.success(fileURL))
            } catch let error {
                print("Error writing CSV: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        func convertToCSV(students: [StudentEntity], startDate: Date, dueDate: Date) -> String {
            var csvString = "No,Name,Address,Memorization,Latest Ziyadah,Ziyadah,Latest Murojaah,Murojaah,Present,Absent\n"
            
            for (index, student) in students.enumerated() {
                let completedZiyadahCount = student.completedZiyadah.count
                var latestZiyadah: String = "no data"
                if let latestZiyadahData = student.ziyadahData.filter({ $0.createdAt >= startDate && $0.createdAt <= dueDate }).sorted(by: { $0.createdAt > $1.createdAt }).first {
                    latestZiyadah = "Juz \(latestZiyadahData.juz) Page \(latestZiyadahData.page)"
                }
                
                var latestMurojaah: String = "no data"
                if let latestMurojaahData = student.murojaahData.filter({ $0.createdAt >= startDate && $0.createdAt <= dueDate }).sorted(by: { $0.createdAt > $1.createdAt }).first {
                    if latestMurojaahData.category == MurojaahAmountOptions.perJuz.rawValue {
                        latestMurojaah = "\(latestMurojaahData.category) | \(latestMurojaahData.key)"
                    } else {
                        latestMurojaah = "\(latestMurojaahData.category) | Juz \(latestMurojaahData.key) Page \(latestMurojaahData.value)"
                    }
                }
                
                let presentCount = student.attendanceData.filter { $0.attendStatus == true && $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                let absentCount = student.attendanceData.filter { $0.attendStatus == false && $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                let ziyadahCount = student.ziyadahData.filter { $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                let murojaahCount = student.murojaahData.filter { $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                
                csvString.append("\(index+1),\(student.name),\(student.address),\(completedZiyadahCount) Juz,\(latestZiyadah),\(ziyadahCount) pages, \(latestMurojaah), \(murojaahCount) times, \(presentCount) times, \(absentCount) times\n")
            }
            
            return csvString
        }
    }
}
