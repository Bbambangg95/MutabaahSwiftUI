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
                if !SubscriptionManager.shared.isSubscribed {
                    NavigationLink {
                        SubscriptionView()
                    } label: {
                        HStack {
                            Image(systemName: "graduationcap.fill")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.blue)
                                )
                            Text("Subscription")
                                .foregroundStyle(.white)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.blue)
                        )
                    }
                    .listRowBackground(Color.blue)
                }
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
