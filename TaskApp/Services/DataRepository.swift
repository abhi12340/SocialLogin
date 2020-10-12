//
//  DataRepository.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 10/10/20.
//

import Foundation

class DataRepository : DataSource {
    
    
    private var networkprotocol : NetworkProtocol
    
    init() {
       networkprotocol = NetworkClient()
    }
    
    func getEmployeeInfo(completionHandler: @escaping (Employee?, TRError?) -> Void) {
        networkprotocol.request(request: TRRouter.getEmployee) { (result) in
            switch result {
            case .succes(let stringResponse):
                
                guard let responseData = stringResponse.result.value?.data(using: String.Encoding.utf8), let employeeData = try? JSONDecoder().decode(Employee.self, from: responseData) else {
                    completionHandler(nil , .parsingError)
                    return
                }
                completionHandler(employeeData , nil)
            case .error(let error):
                print(error)
                completionHandler(nil , .networkError)
            }
        }
    }
}
