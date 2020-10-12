//
//  EmployeeViewModel.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 10/10/20.
//

import Foundation


class EmployeeViewModel {
    private var dataSource : DataSource
    private var employeeDetails : (Employee? , TRError?)
    
    init() {
        dataSource = DataRepository()
    }
    
    func getEmployeeDetails() {
        dataSource.getEmployeeInfo {[weak self] (employee, error) in
            guard let employeeList = employee  else {
                self?.employeeDetails = (nil , error)
                return
            }
            self?.employeeDetails = (employeeList , nil)
        }
    }
    
    func fetchDetails() -> [Datum]? {
        return employeeDetails.0?.data
    }
}
