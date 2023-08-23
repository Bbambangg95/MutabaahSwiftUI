//
//  UserProfileView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 07/08/23.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        Section {
        NavigationLink(destination: UserEditorScreen()) {
            HStack {
                Image("img")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 60, maxHeight: 60)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.6), radius: 10)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(userVM.name)
                        .font(.headline)
                        .lineLimit(1)
                    Text(userVM.address)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
            .padding(.vertical, 5)
        }
        } header: {
            Text("Personal Information")
        }
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
