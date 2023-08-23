//
//  UserEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct UserEntity: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var address: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var userSchedule: [UserScheduleEntity] = []
}
