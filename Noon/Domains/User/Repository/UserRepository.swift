//
//  UserRepository.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation

protocol UserRepository {
    func getUser() -> UserEntity?
    func createUser(user: UserEntity)
    func updateUser(id: UUID, user: UserEntity)
    
    func getUserSchedule() -> [UserScheduleEntity]
    func createUserSchedule(schedule: UserScheduleEntity)
    func updateUserSchedule(id: UUID, schedule: UserScheduleEntity)
    func deleteUserSchedule(id: UUID)
}
