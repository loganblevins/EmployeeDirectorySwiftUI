//
//  XCTestCase+.swift
//  EmployeeDirectoryTests
//
//  Created by Logan Blevins on 1/15/23.
//

import Foundation
import Combine
import XCTest
@testable import EmployeeDirectory

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 1.0,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> T.Output where T.Failure == Error {

        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }

    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        dropFirst count: Int = 1,
        timeout: TimeInterval = 1.0,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> T.Output where T.Failure == Never {

        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher
            .dropFirst(count)
            .sink { value in
                result = .success(value)
                expectation.fulfill()
            }

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }

    func anyEmployee(fullName: String = "fullName") -> Employee {
        Employee(uuid: UUID().uuidString, fullName: fullName, phoneNumber: "phoneNumber", emailAddress: "emailAddress", biography: "biography", photoURLSmall: "photoUrlSmalls", photoURLLarge: "photoUrlLarge", team: "team", employeeType: .fullTime)
    }

    func anyEmployees(count: Int = 3) -> [Employee] {
        Array(repeating: anyEmployee(), count: count)
    }
}
