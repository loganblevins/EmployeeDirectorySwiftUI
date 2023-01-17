//
//  MockStore.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import Foundation
import Combine

final class MockStore: DataStore {
    init(employees: [Employee]? = nil, error: Error? = nil) {
        self.employees = employees
        self.error = error
    }

    var employees: [Employee]?
    var error: Error?

    func fetchEmployees() -> AnyPublisher<[Employee], Error> {
        if let employees = employees {
            return Just<[Employee]>(employees)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } else {
            return Empty()
                .eraseToAnyPublisher()
        }
    }
}
