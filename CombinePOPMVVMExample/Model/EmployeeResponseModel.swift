//
//  EmployeeResponseModel.swift
//  CombinePOPMVVMExample
//
//  Created by Harshit Vaish on 11/08/24.
//

// MARK: - EmployeeResponseModel
struct EmployeeResponseModel<T:Codable>: Codable {
    @SafeCodable var status: String?
    @SafeCodable var data: T?
    @SafeCodable var message: String?
}
