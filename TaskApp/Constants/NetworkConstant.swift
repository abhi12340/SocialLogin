//
//  NetworkConstant.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 10/10/20.
//

import Foundation

struct NetworkConstant {
    static let baseURL = "https://fake-rest-api3.herokuapp.com"
    static let employeeEndPoint = "/flights"
    static var exceptionDomains : [String] = {
        return Bundle.main.object(forInfoDictionaryKey: BundleConstant.exceptionDomains) as? [String] ?? []
    }()
}


struct BundleConstant {
    static let exceptionDomains = "TaskExceptionDomains"
}
