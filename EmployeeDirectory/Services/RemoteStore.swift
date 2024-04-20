//
//  RemoteStore.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import Foundation
import Combine

// Test URL malformed data: https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json
// Test URL empty data: https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json

final class RemoteStore: DataStore {
    enum Endpoints: String {
        case employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"

        var url: URL? {
            URL(string: rawValue)
        }
    }

    func fetchEmployees() -> AnyPublisher<[Employee], Error> {
        guard let url = Endpoints.employees.url else {
            return Fail(error: DataStoreError.badUrl(Endpoints.employees.rawValue))
                .eraseToAnyPublisher()
        }

        return URLSession(configuration: .ephemeral)
            .dataTaskPublisher(for: url)
            .retry(3)
            .mapError { error in DataStoreError.transport(error.code.rawValue) }
            .map(\.data)
            .decode(type: Employees.self, decoder: JSONDecoder())
            .map(\.employees)
            .mapError { error in error is DataStoreError ? error : DataStoreError.unknown }
            .eraseToAnyPublisher()
    }
}
