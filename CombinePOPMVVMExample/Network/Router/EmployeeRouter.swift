//
//  EmployeeRouter.swift
//  SwiftUI-MVVM-C
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation

enum EmployeeRouter: RequestInfoConvertible {
    case employeeList
    
    var endpoint: String {
        "https://dummy.restapiexample.com/api/v1/"
    }
//    https://dummy.restapiexample.com/api/v1/employees
    var urlString: String {
        "\(endpoint)\(path)"
    }
    
    var path: String {
        switch self {
        case .employeeList:
            return "employees"
        }
    }
    
    func asRequestInfo() -> URLRequest? {
        guard let url = URL(string: urlString) else{
            return nil
        }
        let requestInfo: URLRequest = URLRequest(url: url)
                
        // Set other property, like headers, parameters for requestInfo here
        
        return requestInfo
    }
}
