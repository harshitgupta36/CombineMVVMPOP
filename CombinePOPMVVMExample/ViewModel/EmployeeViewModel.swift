//
//  EmployeeViewModel.swift
//  Combine_POP_MVVM
//
//  Created by Harshit Vaish on 11/08/24.
//

import Combine
import Foundation

class EmployeeViewModel: ObservableObject {
    @Published var arrEmployee: [EmployeeDataModel]?
    @Published var errorMessage: String?
    
    
    var networkClient: EmployeeNetworkProvider?
    private var cancellable: AnyCancellable?
    
    init() {
        networkClient  = EmployeeNetworkClient()
    }
    
    func getEmployeeList() {
        cancellable = networkClient?
            .getEmployeeList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    self.errorMessage = "Failed : \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { arrEmployee in
                self.arrEmployee = arrEmployee
            })
    }
    
    func addNewEmployee(objReqAddEmployeeRequestModel:AddEmployeeRequestModel){
        cancellable = networkClient?
            .insertEmployeeRecord(objReqAddEmployeeRequestModel: objReqAddEmployeeRequestModel)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    self.errorMessage = "Failed : \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] employeeData in
                guard let self = self else { return }
                
                if let employee = employeeData {
                    self.errorMessage = "Name : \(employee.name ?? "") \n Name : \(employee.age ?? "") added."
                    debugPrint(employee)
                } else {
                    self.errorMessage = "Failed to add new employee"
                }
            })
        
    }
}
