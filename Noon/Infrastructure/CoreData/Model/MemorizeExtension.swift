//
//  MemorizeExtension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 03/08/23.
//

import Foundation

extension Ziyadah {
    public var wrappedCreatedAt: Date {
        createdAt ?? Date()
    }
}
