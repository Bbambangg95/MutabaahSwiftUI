//
//  StudentPreferenceEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct StudentPreferenceEntity: Identifiable {
    var id: UUID = UUID()
    var memorizeStatus: String = MemorizeCategory.ziyadah.rawValue
    var monthlyTarget: Int = 0
    var yearlyTarget: Int = 0
    var startSprint: Date?
    var endSprint: Date?
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

