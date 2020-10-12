//
//  NetworkClient.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 09/10/20.
//

import Alamofire

class NetworkClient: NetworkProtocol {
    
    private static var serverTrustPolicies = {
        return NetworkConstant.exceptionDomains.reduce([String: ServerTrustPolicy]()) { (dictionary, domain) -> [String: ServerTrustPolicy] in
            var dictionary = dictionary
            dictionary[domain] = .disableEvaluation
            return dictionary
        }
    }()

    static let manager: SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = NetworkClient.serverTrustPolicies

        let configuration = URLSessionConfiguration.default


        return Alamofire.SessionManager(configuration: configuration,
                                        serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    
    func request(request: URLRequestConvertible, completionHandler: @escaping (TaskResult) -> ()) {
    
        NetworkClient.manager.request(request).validate().responseString { (response) in
            switch response.result {
            case .success:
                let result = TaskResult.succes(response)
                completionHandler(result)
            case .failure(let error):
                let error = TaskResult.error(error)
                completionHandler(error)
            }
        }
    }
}
