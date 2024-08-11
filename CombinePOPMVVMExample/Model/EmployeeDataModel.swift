//
//  EmployeeModel.swift
//  Combine_POP_MVVM
//
//  Created by Harshit Vaish on 11/08/24.
//



// MARK: - EmployeeDataModel
struct EmployeeDataModel: Codable {
    @SafeCodable var id: Int?
    @SafeCodable var employeeName: String?
    @SafeCodable var employeeSalary: Int?
    @SafeCodable var employeeAge: Int?
    @SafeCodable var profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
