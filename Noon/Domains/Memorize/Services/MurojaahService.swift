//
//  MurojaahService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 11/08/23.
//

import Foundation

class MurojaahService {
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    private let murojaahRepository: MurojaahRepository
    init(murojaahRepository: MurojaahRepository) {
        self.murojaahRepository = murojaahRepository
    }
    func getMurojaah() -> [MurojaahEntity] {
        return murojaahRepository.getMurojaah()
    }
    func createMurojaah(studentId: UUID, murojaah: MurojaahEntity, completion: @escaping (Bool) -> Void) {
        return murojaahRepository.createMurojaah(studentId: studentId, murojaah: murojaah, completion: completion)
    }
    func deleteMurojaah(id: UUID, completion: CompletionHandler) {
        murojaahRepository.deleteMurojaah(id: id, completion: completion)
    }
}
