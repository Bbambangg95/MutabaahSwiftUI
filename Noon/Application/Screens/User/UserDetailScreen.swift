//
//  UserDetailView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 01/07/23.
//

import SwiftUI


struct UserDetailScreen: View {
    var body: some View {
        List {
            UserProfileView()
            UserPreferenceView()
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailView()
//    }
//}
