//
//  MockEmployee.swift
//  EmployeeDirectory
//
//  Created by Logan Blevins on 1/13/23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static func anyEmployee() -> Employee {
        Employee(uuid: UUID().uuidString, fullName: "fullName", phoneNumber: "phoneNumber", emailAddress: "emailAddress", biography: "biography", photoURLSmall: "photoUrlSmall", photoURLLarge: "photoUrlLarge", team: "team", employeeType: .fullTime)
    }
}
