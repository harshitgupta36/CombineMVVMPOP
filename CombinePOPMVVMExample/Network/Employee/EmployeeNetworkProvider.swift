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
    func insertEmployeeRecord(objReqAddEmployeeRequestModel:AddEmployeeRequestModel) -> AnyPublisher<AddEmployeeDataModel?, Error>
}

class EmployeeNetworkClient: EmployeeNetworkProvider {
   
    var networkClient: NetworkProvider = NetworkClient.instance
    
    func getEmployeeList() -> AnyPublisher<[EmployeeDataModel]?, Error> {
        return networkClient.request(EmployeeRouter.employeeList)
            .decode(type: EmployeeResponseModel.self, decoder: JSONDecoder())
            .tryMap({ responsModel in
                return responsModel.data
            })
            .mapError({ error in
                return error
            })
            .eraseToAnyPublisher()
    }
    
    func insertEmployeeRecord(objReqAddEmployeeRequestModel: AddEmployeeRequestModel) -> AnyPublisher<AddEmployeeDataModel?, any Error> {
        return networkClient.request(EmployeeRouter.insertEmployeeRecord(objReqAddEmployeeRequestModel: objReqAddEmployeeRequestModel))
            .decode(type: EmployeeResponseModel<AddEmployeeDataModel>.self, decoder: JSONDecoder())
            .tryMap({ responsModel in
                return responsModel.data
            })
            .mapError({ error in
                return error
            })
            .eraseToAnyPublisher()
    }
    
}
