//
//  ZiyadahRepository.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 10/08/23.
//

import Foundation

protocol ZiyadahRepository {
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    func createZiyadah(
        studentId: UUID,
        ziyadah: ZiyadahEntity,
        completion: @escaping (Bool) -> Void
    )
    func getZiyadah() -> [ZiyadahEntity]
    func deleteZiyadah(
        id: UUID,
        completion: CompletionHandler
    )
}
