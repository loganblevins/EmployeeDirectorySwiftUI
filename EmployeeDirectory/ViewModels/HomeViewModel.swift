//
//  HomeViewModel.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import Foundation
import Combine

enum DataStatus {
    case error(Error)
    case success([Employee])
}

final class HomeViewModel: ObservableObject {

    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

    @Published var status: DataStatus?

    func sortedEmployees() -> [Employee] {
        guard case let .success(employees) = status else { return [] }
        return employees.sorted { $0.fullName < $1.fullName }
    }

    func fetch() {
        task = dataStore.fetchEmployees()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                if case .failure(let error) = result {
                    self?.status = .error(error)
                }
            }, receiveValue: { [weak self] in
                self?.status = .success($0)
            })
    }

    private var task: AnyCancellable?

    private let dataStore: DataStore
}
