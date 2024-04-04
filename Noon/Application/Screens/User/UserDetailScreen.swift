//
//  UserDetailView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 01/07/23.
//

import SwiftUI


struct UserDetailScreen: View {
    var body: some View {
        NavigationStack {
            List {
//                UserProfileView()
                UserPreferenceView()
                
                SubscriptionView()
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
        }
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailView()
//    }
//}
