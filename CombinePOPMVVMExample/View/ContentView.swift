


import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = EmployeeViewModel()
    @State private var showingAlert = false
//    @State private var newEmployee: Employee?
    @State private var focusedEmployeeId: UUID?
    @State private var showingSheet = false

    @State private var newEmployeeName: String = ""
       @State private var newEmployeeSalary: String = ""
       @State private var newEmployeeAge: String = ""

    var body: some View {
        VStack {
            Button(action: addNewEmployee) {
                Text("Add New Employee")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let employees = viewModel.arrEmployee, !employees.isEmpty {
                List(employees, id: \.id) { employee in
                    HStack {
                        if let profileImage = employee.profileImage, let url = URL(string: profileImage) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }

                        VStack(alignment: .leading) {
                            Text(employee.employeeName ?? "No Name")
                                .font(.headline)
                            Text("Salary: \(employee.employeeSalary ?? 0)")
                            Text("Age: \(employee.employeeAge ?? 0)")
                        }
                    }
//                    .id(employee.id == focusedEmployeeId ? UUID() : nil) // Manage focus on new employee
                }
            } else {
                Text("No employees found")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .onAppear {
            viewModel.getEmployeeList()
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $showingSheet) {
                    Form {
                        Section(header: Text("Enter Employee Details")) {
                            TextField("Name", text: $newEmployeeName)
                            TextField("Salary", text: $newEmployeeSalary)
                                .keyboardType(.decimalPad)
                            TextField("Age", text: $newEmployeeAge)
                                .keyboardType(.numberPad)
                        }

                        Button("Save") {
                            showingSheet = false
                            viewModel.addNewEmployee(objReqAddEmployeeRequestModel: AddEmployeeRequestModel(name: newEmployeeName, salary: newEmployeeSalary, age: newEmployeeAge))
                        }
                        .disabled(newEmployeeName.isEmpty || newEmployeeSalary.isEmpty || newEmployeeAge.isEmpty)
                    }
                    .padding()
                }
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if errorMessage != nil {
                showingAlert = true
            }
        }
    }

    private func addNewEmployee() {
        showingSheet = true
    }
}

#Preview {
    ContentView()
}
