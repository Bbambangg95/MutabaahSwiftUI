//
//  EntitlementManager.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/04/24.
//

import SwiftUI

class EntitlementManager: ObservableObject {
    static let userDefaults = UserDefaults(suiteName: "group.mutabaah.app")!
    
    @AppStorage("hasPro", store: userDefaults)
    var hasPro: Bool = false
}
