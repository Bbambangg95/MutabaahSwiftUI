//
//  CompletedZiyadahEntity.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//

import Foundation

struct CompletedZiyadahEntity: Identifiable {
    var id: UUID = UUID()
    var juz: Int = 0
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
