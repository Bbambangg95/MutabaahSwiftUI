//
//  UserScheduleEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct UserScheduleEntity: Identifiable, Equatable {
    var id: UUID = UUID()
    var timeLabel: String = ""
    var startTime: Date = Date()
    var endTime: Date = Date()
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
