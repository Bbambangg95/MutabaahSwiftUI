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
                VStack(alignment: .leading) {
                    Text(userVM.name.isEmpty ? "Name not provided" : userVM.name)
                        .font(.headline)
                        .lineLimit(1)
                    Text(userVM.address.isEmpty ? "Address not provided" : userVM.address)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        } header: {
            Text("User Identity")
        }
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
