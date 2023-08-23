//
//  MurojaahAmountOptions.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import Foundation

enum MurojaahAmountOptions: String, CaseIterable {
    case perPage = "Per Page"
    case perJuz = "Per Juz"
}

enum MurojaahPerJuzAmount: String, CaseIterable {
    case oneJuz = "1 Juz"
    case twoUntilFive = "2 - 5 Juz"
    case sixUntilTen = "6 - 10 Juz"
    case elevenUntilTwenty = "11 - 20 Juz"
    case moreThanTwenty = "21 - 30 Juz"
}

extension MurojaahPerJuzAmount {
    var maxValue: Int {
        switch self {
        case .oneJuz:
            return 1
        case .twoUntilFive:
            return 5
        case .sixUntilTen:
            return 10
        case .elevenUntilTwenty:
            return 20
        case .moreThanTwenty:
            return 30
        }
    }
    var minValue: Int {
        switch self {
        case .oneJuz:
            return 1
        case .twoUntilFive:
            return 2
        case .sixUntilTen:
            return 6
        case .elevenUntilTwenty:
            return 11
        case .moreThanTwenty:
            return 21
        }
    }
}
