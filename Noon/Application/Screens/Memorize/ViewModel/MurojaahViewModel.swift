//
//  MurojaahViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 11/08/23.
//

import Foundation

class MurojaahViewModel: ObservableObject {
    @Published var murojaah: [MurojaahEntity] = []
    @Published var category: String = MurojaahAmountOptions.perPage.rawValue
    @Published var key: String = ""
    @Published var value: String = ""
    private let murojaahService = MurojaahService(murojaahRepository: MurojaahCDA())
    init() {
        fetchMurojaah()
    }
    func fetchMurojaah() {
        self.murojaah = getMurojaah()
    }
    func getMurojaah() -> [MurojaahEntity] {
        return murojaahService.getMurojaah()
    }
    func createMurojaah(studentId: UUID) {
        let newMurojaah = MurojaahEntity(
            category: self.category,
            key: self.key,
            value: self.value
        )
        murojaahService.createMurojaah(studentId: studentId, murojaah: newMurojaah)
    }
    static func deleteZiyadah(id: UUID) {
        let murojaahDeleteService = MurojaahService(murojaahRepository: MurojaahCDA())
        murojaahDeleteService.deleteMurojaah(id: id)
    }
}
