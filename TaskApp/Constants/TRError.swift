//
//  TRError.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 10/10/20.
//

import Foundation

enum TRError {
    case parsingError
    case networkError
    
    var error : String {
        switch self {
        case .parsingError:
            return "Parsing Error"
        case .networkError:
            return "Network Error"
        }
    }
}
