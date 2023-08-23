//
//  MurojaahEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

struct MurojaahEntity: Identifiable {
    var id: UUID = UUID()
    var category: String = ""
    var key: String = ""
    var value: String = ""
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var studentName: String = ""
}
