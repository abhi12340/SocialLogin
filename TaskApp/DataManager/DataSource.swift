//
//  DataSource.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 10/10/20.
//

import Foundation

protocol DataSource {
    func getEmployeeInfo(completionHandler : @escaping(Employee? , TRError?) -> Void)
}
