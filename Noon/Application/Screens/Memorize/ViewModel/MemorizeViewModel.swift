//
//  MemorizeViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 18/07/23.
//

import Foundation

class MemorizeViewModel: ObservableObject {
    @Published var memorize: [MemorizeEntity] = []
    private let ziyadahService = ZiyadahService(ziyadahRepository: ZiyadahCDA())
    private let murojaahService = MurojaahService(murojaahRepository: MurojaahCDA())
    init() {
        fetchMemorize()
    }
    func fetchMemorize() {
        let ziyadahData = getZiyadah()
        let murojaahData = getMurojaah()
        self.memorize = convertToMemorizeEntity(ziyadahData: ziyadahData, murojaahData: murojaahData)
    }
    private func convertToMemorizeEntity(
        ziyadahData: [ZiyadahEntity],
        murojaahData: [MurojaahEntity]
    ) -> [MemorizeEntity] {
        var memorizeEntities: [MemorizeEntity] = []
        for ziyadahEntity in ziyadahData {
            let memorizeEntity = MemorizeEntity(
                id: ziyadahEntity.id,
                studentName: ziyadahEntity.studentName,
                memorizeCategory: MemorizeCategory.ziyadah.rawValue,
                key: String(ziyadahEntity.juz),
                value: String(ziyadahEntity.page),
                createdAt: ziyadahEntity.createdAt)
            memorizeEntities.append(memorizeEntity)
        }
        for murojaahEntity in murojaahData {
            let memorizeEntity = MemorizeEntity(
                id: murojaahEntity.id,
                studentName: murojaahEntity.studentName,
                memorizeCategory: MemorizeCategory.murojaah.rawValue,
                murojaahCategory: murojaahEntity.category,
                key: murojaahEntity.key,
                value: murojaahEntity.value,
                createdAt: murojaahEntity.createdAt)
            memorizeEntities.append(memorizeEntity)
        }
        return memorizeEntities.sorted(by: { (memorize1, memorize2) -> Bool in
                return memorize1.createdAt > memorize2.createdAt
            })
    }
    func getZiyadah() -> [ZiyadahEntity] {
        return ziyadahService.getZiyadah()
    }
    func getMurojaah() -> [MurojaahEntity] {
        return murojaahService.getMurojaah()
    }
}
