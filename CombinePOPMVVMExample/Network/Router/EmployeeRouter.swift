//
//  EmployeeRouter.swift
//  SwiftUI-MVVM-C
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation

enum HTTPMethod : String{
    case get = "Get"
    case post = "Post"
}

enum EmployeeRouter: RequestInfoConvertible {
    case employeeList
    case insertEmployeeRecord(objReqAddEmployeeRequestModel: AddEmployeeRequestModel)
    
    var baseUrl: String {
        "https://dummy.restapiexample.com/api/v1/"
    }
    
    var urlString: String {
        "\(baseUrl)\(path)"
    }
    
    var path: String {
        switch self {
        case .employeeList:
            return "employees"
        case .insertEmployeeRecord(objReqAddEmployeeRequestModel: _):
            return "create"
        }
    }
    
    var method:HTTPMethod{
        switch self{
            
        case .employeeList:
            return .get
        case .insertEmployeeRecord(objReqAddEmployeeRequestModel: _):
            return .post
        }
    }
    
    var parameter: Data? {
        switch self {
        case .employeeList:
            return nil
        case .insertEmployeeRecord(let employee):
            let param  = ["name":employee.name,"salary":employee.salary,"age":employee.age]
            do {
                return try JSONSerialization.data(withJSONObject: param)
            } catch {
                print("Error encoding JSON: \(error)")
                return nil
            }
        }
    }
    
    func asRequestInfo() -> URLRequest? {
        guard let url = URL(string: urlString) else{
            return nil
        }
        var requestInfo: URLRequest = URLRequest(url: url)
        requestInfo.httpMethod = method.rawValue
        if let parameters = parameter {
            requestInfo.httpBody = parameters
            requestInfo.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        // Set other property, like headers, parameters for requestInfo here
        
        return requestInfo
    }
}
