//
//  UserPreferenceViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 18/07/23.
//

import Foundation
import SwiftUI

class UserScheduleViewModel: ObservableObject {
    @Published var userSchedule: [UserScheduleEntity] = []
    @Published var selectedClassTime: String = ""
    @Published var timeLabel: String = ""
    @Published var startTime: Date = Date()
    @Published var endTime: Date = Date()
    
    init() {
        fetchSchedule()
    }
    
    private let userService = UserService(userRepository: UserCoreDataAdapter())
    
    func startEditing(schedule: UserScheduleEntity?) {
        self.timeLabel = schedule?.timeLabel ?? ""
        self.startTime = schedule?.startTime ?? Date()
        self.endTime = schedule?.endTime ?? Date()
    }
    
    func fetchSchedule() {
        self.userSchedule = getUserSchedule()
        self.selectedClassTime = userSchedule.first?.id.uuidString ?? ""
    }
    
    func getUserSchedule() -> [UserScheduleEntity] {
        return userService.getUserSchedule()
    }
    
    func createUserSchedule() {
        var newSchedule = UserScheduleEntity()
        newSchedule.id = UUID()
        newSchedule.timeLabel = self.timeLabel
        newSchedule.startTime = self.startTime
        newSchedule.endTime = self.endTime
        
        userService.createUserSchedule(schedule: newSchedule)
        fetchSchedule()
    }
    
    func updateUserSchedule(id: UUID) {
        var newSchedule = UserScheduleEntity()
        newSchedule.timeLabel = self.timeLabel
        newSchedule.startTime = self.startTime
        newSchedule.endTime = self.endTime
        
        userService.updateUserSchedule(id: id, schedule: newSchedule)
        fetchSchedule()
    }
    
    func deleteUserSchedule(id: UUID) {
        userService.deleteUserSchedule(id: id)
        fetchSchedule()
    }
}
