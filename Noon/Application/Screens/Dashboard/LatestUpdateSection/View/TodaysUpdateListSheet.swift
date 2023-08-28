//
//  ActivityScreen.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct TodaysUpdateListSheet: View {
    var memorize: [MemorizeEntity] = []
    var body: some View {
        NavigationStack {
            List {
                ForEach(memorize.prefix(50)) { memorize in
                    TodaysUpdateRowView(memorize: memorize)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Latest Update")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

