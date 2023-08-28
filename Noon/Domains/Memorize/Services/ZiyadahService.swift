//
//  ZiyadahService.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 10/08/23.
//

import Foundation

class ZiyadahService {
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    private let ziyadahRepository: ZiyadahRepository
    init(ziyadahRepository: ZiyadahRepository) {
        self.ziyadahRepository = ziyadahRepository
    }
    func getZiyadah() -> [ZiyadahEntity] {
        return ziyadahRepository.getZiyadah()
    }
    func createZiyadah(studentId: UUID, ziyadah: ZiyadahEntity, completion: @escaping (Bool) -> Void) {
        return ziyadahRepository.createZiyadah(studentId: studentId, ziyadah: ziyadah, completion: completion)
    }
    func deleteZiyadah(
        id: UUID,
        completion: @escaping CompletionHandler
    ) {
        ziyadahRepository.deleteZiyadah(id: id, completion: completion)
    }
}
