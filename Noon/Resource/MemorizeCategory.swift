//
//  MemorizeCategory.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 19/07/23.
//

import Foundation
import SwiftUI

enum MemorizeCategory: String, CaseIterable {
    case ziyadah = "Ziyadah"
    case murojaah = "Murojaah"
}

extension MemorizeCategory {
    var color: Color {
        switch self {
        case .ziyadah:
            return .green
        case .murojaah:
            return .yellow
        }
    }
}
