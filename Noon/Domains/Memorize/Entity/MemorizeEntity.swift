//
//  MemorizeEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 11/08/23.
//

import Foundation

struct MemorizeEntity: Identifiable {
    var id: UUID = UUID()
    var studentName: String = ""
    var memorizeCategory: String = ""
    var murojaahCategory: String = ""
    var key: String = ""
    var value: String = ""
    var createdAt: Date = Date()
}
