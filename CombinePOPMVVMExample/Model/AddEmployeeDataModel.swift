//
//  AddEmployeeRequestModel.swift
//  CombinePOPMVVMExample
//
//  Created by Harshit Vaish on 11/08/24.
//

struct AddEmployeeRequestModel {
     var name : String
     var salary: String
     var age: String
}


// MARK: - DataClass
struct AddEmployeeDataModel: Codable {
    @SafeCodable var name : String?
    @SafeCodable var salary: String?
    @SafeCodable var age: String?
    @SafeCodable var id: Int?
}
