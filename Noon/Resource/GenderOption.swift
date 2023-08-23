//
//  GenderOption.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation

enum GenderOption: Int, CaseIterable, Identifiable {
    case male = 0
    case female = 1
    var id: Int { self.rawValue }
    var description: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        }
    }
}
