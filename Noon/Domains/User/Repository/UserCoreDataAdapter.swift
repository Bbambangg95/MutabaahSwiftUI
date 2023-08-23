//
//  UserCoreDataAdapter.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import Foundation
import CoreData

class UserCoreDataAdapter: UserRepository {
    private let viewContext = PersistenceController.shared.container.viewContext
    
    func getUser() -> UserEntity? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                return UserEntity(
                    id: user.id ?? UUID(),
                    name: user.name ?? "",
                    address: user.address ?? "",
                    createdAt: user.createdAt ?? Date(),
                    updatedAt: user.updatedAt ?? Date(),
                    userSchedule: convertToUserScheduleEntity(userSchedule: user.userScheduleDataArray) ?? []
                )
            } else {
                print("User not found")
                return nil
            }
        } catch let error {
            print("Error fetching user data: \(error)")
            return nil
        }
    }
    
    func createUser(user: UserEntity) {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.name = user.name
        newUser.address = user.address
        newUser.createdAt = Date()
        newUser.updatedAt = Date()
        
        do {
            try viewContext.save()
            print("User updated succesfully!")
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    func updateUser(id: UUID, user: UserEntity) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let fetchedUser = try viewContext.fetch(fetchRequest)
            
            if let existingUser = fetchedUser.first {
                existingUser.name = user.name
                existingUser.address = user.address
                existingUser.updatedAt = Date()
                
                try viewContext.save()
                print("User updated succesfully!")
            } else {
                print("User not found!")
            }
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    func getUserSchedule() -> [UserScheduleEntity] {
        let fetchRequest: NSFetchRequest<UserSchedule> = UserSchedule.fetchRequest()
        
        do {
            let schedules = try viewContext.fetch(fetchRequest)
            
            return schedules.map { schedule in
                UserScheduleEntity(
                    id: schedule.id ?? UUID(),
                    timeLabel: schedule.timeLabel ?? "",
                    startTime: schedule.startTime ?? Date(),
                    endTime: schedule.endTime ?? Date(),
                    createdAt: schedule.createdAt ?? Date(),
                    updatedAt: schedule.updatedAt ?? Date())
            }
        } catch let error {
            print("Failed to fetch User Schedule: \(error)")
            return []
        }
    }
    
    
    func createUserSchedule(schedule: UserScheduleEntity) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                let newSchedule = UserSchedule(context: viewContext)
                newSchedule.id = UUID()
                newSchedule.timeLabel = schedule.timeLabel
                newSchedule.startTime = schedule.startTime
                newSchedule.endTime = schedule.endTime
                newSchedule.createdAt = Date()
                newSchedule.updatedAt = Date()
                
                user.addToUserSchedule(newSchedule)
                
                try viewContext.save()
                print("New schedule saved")
            }
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    func updateUserSchedule(id: UUID, schedule: UserScheduleEntity) {
        let fetchRequest: NSFetchRequest<UserSchedule> = UserSchedule.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let schedules = try viewContext.fetch(fetchRequest)
            if let scheduleToUpdate = schedules.first {
                scheduleToUpdate.timeLabel = schedule.timeLabel
                scheduleToUpdate.startTime = schedule.startTime
                scheduleToUpdate.endTime = schedule.endTime
                scheduleToUpdate.updatedAt = Date()
                
                try viewContext.save()
                print("Schedule updated")
            } else {
                print("No schedule found with the given ID")
            }
        } catch let error {
            print("Error updating schedule: \(error)")
        }
    }

    func deleteUserSchedule(id: UUID) {
        let fetchRequest: NSFetchRequest<UserSchedule> = UserSchedule.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let schedules = try viewContext.fetch(fetchRequest)
            if let scheduleToDelete = schedules.first {
                viewContext.delete(scheduleToDelete)
                
                try viewContext.save()
                print("Schedule deleted")
            } else {
                print("No schedule found with the given ID")
            }
        } catch let error {
            print("Error deleting schedule: \(error)")
        }
    }
    
    private func convertToUserScheduleEntity(userSchedule: [UserSchedule]?) -> [UserScheduleEntity]? {
        guard let userSchedule = userSchedule else { return nil }
        
        return userSchedule.map { schedule in
            UserScheduleEntity(
                id: schedule.id ?? UUID(),
                timeLabel: schedule.timeLabel ?? "",
                startTime: schedule.startTime ?? Date(),
                endTime: schedule.endTime ?? Date(),
                createdAt: schedule.createdAt ?? Date(),
                updatedAt: schedule.updatedAt ?? Date())
        }
    }
}
