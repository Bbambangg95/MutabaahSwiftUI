//
//  UserViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: UserEntity?
    @Published var userSchedule: [UserScheduleEntity] = []
    
    @Published var id: UUID?
    @Published var name: String = ""
    @Published var address: String = ""
    
    init () {
        fetchUser()
        if let user = user {
            self.id = user.id
            self.name = user.name
            self.address = user.address
            self.userSchedule = user.userSchedule
        }
    }
    
    private let userService = UserService(userRepository: UserCoreDataAdapter())
    
    func fetchUser() {
        self.user = getUser()
    }
    
    func getUser() -> UserEntity? {
        return userService.getUser()
    }
    
    func updateUser() {
        var newUser = UserEntity()
        newUser.name = self.name
        newUser.address = self.address
        newUser.updatedAt = Date()
        
        self.user = newUser
        
        DispatchQueue.global().async {
            self.userService.updateUser(id: self.id ?? UUID(), user: newUser)
        }
    }

}
