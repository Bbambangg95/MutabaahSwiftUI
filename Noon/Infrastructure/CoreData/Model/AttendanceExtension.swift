//
//  AttendanceExtension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

extension Attendance {
    public var wrappedCreatedAt: Date {
        createdAt ?? Date()
    }
}
