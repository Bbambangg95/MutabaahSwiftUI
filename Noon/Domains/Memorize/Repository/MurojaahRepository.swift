//
//  MurojaahRepository.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 11/08/23.
//

import Foundation

protocol MurojaahRepository {
    func createMurojaah(studentId: UUID, murojaah: MurojaahEntity, completion: @escaping (Bool) -> Void)
    func getMurojaah() -> [MurojaahEntity]
    func deleteMurojaah(id: UUID)
}
