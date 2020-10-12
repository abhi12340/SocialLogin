//
//  NetworkProtocol.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 09/10/20.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func request(request: URLRequestConvertible, completionHandler: @escaping(TaskResult) -> ())
}
