//
//  StudentExtension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 03/08/23.
//

import Foundation

extension Student {
    public var attendanceDataArray: [Attendance] {
        let set = attendance as? Set<Attendance> ?? []
        return set.sorted {
            $0.wrappedCreatedAt > $1.wrappedCreatedAt
        }
    }
    public var memorizeDataArray: [Ziyadah] {
        let memorizeSet = ziyadah as? Set<Ziyadah> ?? []
        return memorizeSet.sorted {
            $0.wrappedCreatedAt > $1.wrappedCreatedAt
        }
    }
    public var completedZiyadahArray: [CompletedZiyadah] {
        let memorizeSet = completedZiyadah as? Set<CompletedZiyadah> ?? []
        return memorizeSet.sorted {
            $0.wrappedCreatedAt > $1.wrappedCreatedAt
        }
    }
}
