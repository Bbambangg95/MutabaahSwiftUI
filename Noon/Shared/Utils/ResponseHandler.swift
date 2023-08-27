//
//  ResponseHandler.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 26/08/23.
//

import Foundation

class ResponseHandler {
    typealias CompletionHandler = (Result<Bool, Error>) -> Void
    public func responseHandler(_ result: Result<Bool, Error>, completion: @escaping CompletionHandler) {
        switch result {
        case .success:
            completion(.success(true))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
