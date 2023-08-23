//
//  CompletedZiyadahExtension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/08/23.
//

import Foundation

extension CompletedZiyadah {
    public var wrappedCreatedAt: Date {
        createdAt ?? Date()
    }
}
