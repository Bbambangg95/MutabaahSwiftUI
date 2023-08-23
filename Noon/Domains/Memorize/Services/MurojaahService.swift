//
//  MurojaahService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 11/08/23.
//

import Foundation

class MurojaahService {
    private let murojaahRepository: MurojaahRepository
    init(murojaahRepository: MurojaahRepository) {
        self.murojaahRepository = murojaahRepository
    }
    func getMurojaah() -> [MurojaahEntity] {
        return murojaahRepository.getMurojaah()
    }
    func createMurojaah(studentId: UUID, murojaah: MurojaahEntity) {
        return murojaahRepository.createMurojaah(studentId: studentId, murojaah: murojaah)
    }
    func deleteMurojaah(id: UUID) {
        murojaahRepository.deleteMurojaah(id: id)
    }
}
