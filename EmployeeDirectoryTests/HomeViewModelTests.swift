//
//  HomeViewModelTests.swift
//  HomeViewModelTests
//
//  Created by Logan Blevins on 1/13/23.
//

import XCTest
@testable import EmployeeDirectory

final class HomeViewModelTests: XCTestCase {

    func test_initHasNoStatus() {
        let store = MockStore(employees: anyEmployees())
        let sut = getSUT(store: store)

        XCTAssertNil(sut.status)
    }

    func test_fetchProducesStatus() throws {
        let store = MockStore(employees: anyEmployees())
        let sut = getSUT(store: store)

        sut.fetch()

        let status = try awaitPublisher(sut.$status)

        XCTAssertNotNil(status)
    }

    func test_fetchProducesSuccess() throws {
        let store = MockStore(employees: anyEmployees())
        let sut = getSUT(store: store)

        sut.fetch()

        let status = try awaitPublisher(sut.$status)
        let unwrappedStatus = try XCTUnwrap(status)

        switch unwrappedStatus {
        case .error:
            XCTFail()
        case .success(let employees):
            XCTAssertEqual(employees.count, 3)
        }
    }

    func test_fetchProducesSuccess_changesData() throws {
        let store = MockStore(employees: anyEmployees())
        let sut = getSUT(store: store)

        sut.fetch()

        let status = try awaitPublisher(sut.$status)
        let unwrappedStatus = try XCTUnwrap(status)

        switch unwrappedStatus {
        case .error:
            XCTFail()
        case .success(let employees):
            XCTAssertEqual(employees.count, 3)
        }

        store.employees = anyEmployees(count: 999)
        sut.fetch()

        let status_two = try awaitPublisher(sut.$status)
        let unwrappedStatus_two = try XCTUnwrap(status_two)

        switch unwrappedStatus_two {
        case .error:
            XCTFail()
        case .success(let employees):
            XCTAssertEqual(employees.count, 999)
        }
    }

    func test_fetchProducesError() throws {
        let store = MockStore(error: DataStoreError.transport(-1))
        let sut = getSUT(store: store)

        sut.fetch()

        let status = try awaitPublisher(sut.$status)
        let unwrappedStatus = try XCTUnwrap(status)

        switch unwrappedStatus {
        case .error(let error):
            XCTAssertTrue(error is DataStoreError)
        case .success:
            XCTFail()
        }
    }

    func test_fetchProducesError_fetchProducesSuccess() throws {
        let store = MockStore(error: DataStoreError.transport(-1))
        let sut = getSUT(store: store)

        sut.fetch()

        let status = try awaitPublisher(sut.$status)
        let unwrappedStatus = try XCTUnwrap(status)

        switch unwrappedStatus {
        case .error(let error):
            XCTAssertTrue(error is DataStoreError)
        case .success:
            XCTFail()
        }

        store.error = nil
        store.employees = anyEmployees(count: 999)
        sut.fetch()

        store.employees = anyEmployees(count: 999)
        sut.fetch()

        let status_two = try awaitPublisher(sut.$status)
        let unwrappedStatus_two = try XCTUnwrap(status_two)

        switch unwrappedStatus_two {
        case .error:
            XCTFail()
        case .success(let employees):
            XCTAssertEqual(employees.count, 999)
        }
    }

    func test_emptySortedEmployees() throws {
        let sut = getSUT()

        sut.fetch()

        _ = try awaitPublisher(sut.$status)

        let sorted = sut.sortedEmployees()

        XCTAssertTrue(sorted.isEmpty)
    }

    func test_sortedEmployees() throws {
        let store = MockStore(employees: [anyEmployee(fullName: "c"), anyEmployee(fullName: "a"), anyEmployee(fullName: "b")])
        let sut = getSUT(store: store)

        sut.fetch()

        _ = try awaitPublisher(sut.$status)

        let sorted = sut.sortedEmployees()

        XCTAssertFalse(sorted.isEmpty)
        XCTAssertEqual(sorted[0].fullName, "a")
        XCTAssertEqual(sorted[1].fullName, "b")
        XCTAssertEqual(sorted[2].fullName, "c")
    }

    func getSUT(store: DataStore = MockStore(employees: [])) -> HomeViewModel {
        HomeViewModel(dataStore: store)
    }
}
