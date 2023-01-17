//
//  DataStore.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import Foundation
import Combine

protocol DataStore {
    func fetchEmployees() -> AnyPublisher<[Employee], Error>
}

enum DataStoreError: LocalizedError {
    case badUrl(String)
    case transport(Int)
    case unknown

    var errorDescription: String? {
        switch self {
        case .badUrl(let url):
            return L10n.DataStoreError.badUrl(url)
        case .transport(let reason):
            return L10n.DataStoreError.transport(reason)
        case .unknown:
            return L10n.DataStoreError.unknown
        }
    }
}
