//
//  UserExtension.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 07/08/23.
//

import Foundation

extension User {
    public var userScheduleDataArray: [UserSchedule] {
        let set = userSchedule as? Set<UserSchedule> ?? []
        return set.sorted {
            $0.createdAt! > $1.createdAt!
        }
    }
}
