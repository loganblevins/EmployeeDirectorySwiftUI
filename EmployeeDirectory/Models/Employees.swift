// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let employees = try Employees(json)

import Foundation

// MARK: - Employees
struct Employees: Codable {
    let employees: [Employee]
}

// MARK: Employees convenience initializers and mutators

extension Employees {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Employees.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        employees: [Employee]? = nil
    ) -> Employees {
        return Employees(
            employees: employees ?? self.employees
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Employee
struct Employee: Codable {
    let uuid, fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoURLSmall, photoURLLarge: String?
    let team: String
    let employeeType: EmployeeType

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

// MARK: Employee convenience initializers and mutators

extension Employee {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Employee.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        uuid: String? = nil,
        fullName: String? = nil,
        phoneNumber: String?? = nil,
        emailAddress: String? = nil,
        biography: String?? = nil,
        photoURLSmall: String?? = nil,
        photoURLLarge: String?? = nil,
        team: String? = nil,
        employeeType: EmployeeType? = nil
    ) -> Employee {
        return Employee(
            uuid: uuid ?? self.uuid,
            fullName: fullName ?? self.fullName,
            phoneNumber: phoneNumber ?? self.phoneNumber,
            emailAddress: emailAddress ?? self.emailAddress,
            biography: biography ?? self.biography,
            photoURLSmall: photoURLSmall ?? self.photoURLSmall,
            photoURLLarge: photoURLLarge ?? self.photoURLLarge,
            team: team ?? self.team,
            employeeType: employeeType ?? self.employeeType
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
