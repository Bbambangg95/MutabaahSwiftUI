//
//  ZiyadahEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct ZiyadahEntity: Identifiable, DateCreatableEntity {
    var id: UUID = UUID()
    var juz: Int = 1
    var page: Int = 1
    var memorizeValue: String = ""
    var recitationValue: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var studentName: String = ""
}
