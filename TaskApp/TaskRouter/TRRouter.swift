//
//  TRRouter.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 10/10/20.
//

import Foundation
import Alamofire


public enum TRRouter : URLRequestConvertible {
    case getEmployee
    
    public func asURLRequest() throws -> URLRequest {
        var method : HTTPMethod {
            switch self {
            case .getEmployee:
                return .get
            }
        }
        
        var url : URL {
            let baseURL = NetworkConstant.baseURL
            var relativePath :String?
            switch self {
            case .getEmployee:
                relativePath = NetworkConstant.employeeEndPoint
            }
            let tempURL = URL(string: baseURL)!
            
            var url = tempURL
            if let path = relativePath {
                url.appendPathComponent(path)
            }
            return url
        }
        
        let encoding  = URLEncoding(destination: .queryString)
        let urlRequest =  URLRequest(url: url)
        return try encoding.encode(urlRequest, with: nil)
    }
}
