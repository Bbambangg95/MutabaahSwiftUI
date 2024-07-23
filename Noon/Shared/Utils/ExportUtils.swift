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
            var csvString = "No,\(NSLocalizedString("Name", comment: "")),\(NSLocalizedString("Address", comment: "")),\(NSLocalizedString("Memorization", comment: "")),\(NSLocalizedString("Latest Status", comment: "")),Ziyadah,Murojaah,\(NSLocalizedString("Present", comment: "")),\(NSLocalizedString("Absent", comment: ""))\n"
            
            for (index, student) in students.enumerated() {
                let completedZiyadahCount = student.completedZiyadah.count
                var latestData: String = "no data"

                // Get the latest Ziyadah data within the specified date range
                let latestZiyadahData = student.ziyadahData.filter { $0.createdAt >= startDate && $0.createdAt <= dueDate }
                    .sorted(by: { $0.createdAt > $1.createdAt }).first

                // Get the latest Murojaah data within the specified date range
                let latestMurojaahData = student.murojaahData.filter { $0.createdAt >= startDate && $0.createdAt <= dueDate }
                    .sorted(by: { $0.createdAt > $1.createdAt }).first

                // Determine the latest data between Ziyadah and Murojaah
                if let latestZiyadah = latestZiyadahData, let latestMurojaah = latestMurojaahData {
                    if latestZiyadah.createdAt > latestMurojaah.createdAt {
                        latestData = "Ziyadah (Juz \(latestZiyadah.juz) \(NSLocalizedString("Page", comment: "")) \(latestZiyadah.page))"
                    } else {
                        if latestMurojaah.category == MurojaahAmountOptions.perJuz.rawValue {
                            latestData = "Murojaah (\(latestMurojaah.category) | \(latestMurojaah.key))"
                        } else {
                            latestData = "Murojaah (\(latestMurojaah.category) | Juz \(latestMurojaah.key) \(NSLocalizedString("Page", comment: "")) \(latestMurojaah.value))"
                        }
                    }
                } else if let latestZiyadah = latestZiyadahData {
                    latestData = "Ziyadah (Juz \(latestZiyadah.juz) \(NSLocalizedString("Page", comment: "")) \(latestZiyadah.page))"
                } else if let latestMurojaah = latestMurojaahData {
                    if latestMurojaah.category == MurojaahAmountOptions.perJuz.rawValue {
                        latestData = "Murojaah (\(latestMurojaah.category) | \(latestMurojaah.key))"
                    } else {
                        latestData = "Murojaah (\(latestMurojaah.category) | Juz \(latestMurojaah.key) \(NSLocalizedString("Page", comment: "")) \(latestMurojaah.value))"
                    }
                }

                // Use `latestData` as needed
                
                let presentCount = student.attendanceData.filter { $0.attendStatus == true && $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                let absentCount = student.attendanceData.filter { $0.attendStatus == false && $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                let ziyadahCount = student.ziyadahData.filter { $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                let murojaahCount = student.murojaahData.filter { $0.createdAt >= startDate && $0.createdAt <= dueDate }.count
                
                csvString.append("\(index+1),\(student.name),\(student.address),\(completedZiyadahCount) Juz,\(latestData),\(ziyadahCount) \(NSLocalizedString("pages", comment: "")), \(murojaahCount) \(NSLocalizedString("times", comment: "")), \(presentCount) \(NSLocalizedString("times", comment: "")), \(absentCount) \(NSLocalizedString("times", comment: ""))\n")
            }
            
            return csvString
        }
    }
}
