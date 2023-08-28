//
//  AttendanceEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct AttendanceEntity: Identifiable, DateCreatableEntity, Hashable {
    var id: UUID = UUID()
    var attendStatus: Bool = false
    var timeLabel: String = ""
    var reason: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
