//
//  StudentSettingView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/07/23.
//

import SwiftUI


struct UserEditorScreen: View {
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        Form {
            Section ("User Identity") {
                TextField("Full Name", text: $userVM.name)
                    .textInputAutocapitalization(.words)
                TextField("Address", text: $userVM.address)
                    .textInputAutocapitalization(.words)
            }
        }
        .onDisappear {
            userVM.updateUser()
        }
        .navigationTitle("Personal Information")
        .formStyle(.grouped)
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
    }
}
//struct StudentSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentSettingView()
//    }
//}
