//
//  UserService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation

class UserService {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func getUser() -> UserEntity? {
        return userRepository.getUser()
    }
    func createUser(user: UserEntity) {
        return userRepository.createUser(user: user)
    }
    
    func updateUser(id: UUID, user: UserEntity) {
        return userRepository.updateUser(id: id, user: user)
    }
    
    func getUserSchedule() -> [UserScheduleEntity] {
        return userRepository.getUserSchedule()
    }
    
    func createUserSchedule(schedule: UserScheduleEntity) {
        return userRepository.createUserSchedule(schedule: schedule)
    }
    
    func updateUserSchedule(id: UUID, schedule: UserScheduleEntity) {
        return userRepository.updateUserSchedule(id: id, schedule: schedule)
    }
    
    func deleteUserSchedule(id: UUID) {
        return userRepository.deleteUserSchedule(id: id)
    }
}
