//
//  TaskResult.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 09/10/20.
//

import Foundation
import Alamofire

enum TaskResult {
    case succes(DataResponse<String>)
    case error(Error)
}
