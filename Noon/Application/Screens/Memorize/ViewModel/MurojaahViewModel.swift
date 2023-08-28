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
    @Published var isLoading: Bool = false
    @Published var alertContent: AlertContent?
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
    func createMurojaah(studentId: UUID, completion: @escaping (Bool) -> Void) {
        let newMurojaah = MurojaahEntity(
            category: self.category,
            key: self.key,
            value: self.value
        )
        murojaahService.createMurojaah(studentId: studentId, murojaah: newMurojaah) { success in
            switch self.category {
            case MurojaahAmountOptions.perPage.rawValue:
                    self.alertContent = AlertContent(
                        title: success ? "Success" : "Failed",
                        message: "The attempt to save Murojaah Juz \(self.key) Page \(self.value) was \(success ? "successful." : "failed")"
                    )
            case MurojaahAmountOptions.perJuz.rawValue:
                    self.alertContent = AlertContent(
                        title: success ? "Success" : "Failed",
                        message: "The attempt to save Murojaah \(self.key) Juz \(self.value) was \(success ? "successful." : "failed")"
                    )
            default:
                self.alertContent = nil
            }
            completion(success ? true : false)
        }
    }
    static func deleteMurojaah(id: UUID) {
        let murojaahDeleteService = MurojaahService(murojaahRepository: MurojaahCDA())
        murojaahDeleteService.deleteMurojaah(id: id) { result in
            print(result)
        }
    }
}
