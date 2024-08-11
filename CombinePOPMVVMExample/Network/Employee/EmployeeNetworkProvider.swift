//
//  EmployeeNetworkProvider.swift
//  CombinePOPMVVMExample
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation
import Combine

protocol EmployeeNetworkProvider {
    func getEmployeeList() -> AnyPublisher<[EmployeeDataModel]?, Error>
}

class EmployeeNetworkClient: EmployeeNetworkProvider {
    var networkClient: NetworkProvider = NetworkClient.instance
    
    func getEmployeeList() -> AnyPublisher<[EmployeeDataModel]?, Error> {
        return networkClient.request(EmployeeRouter.employeeList)
            .decode(type: EmployeeResponseModel.self, decoder: JSONDecoder())
            .tryMap({ responsModel in
                return responsModel.data
            })
            .eraseToAnyPublisher()
    }
}
