//
//  NetworkAgent.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetAgent: NSObject, URLSessionDelegate {
    
    static let sharedInstance = NetAgent()
    
    // MARK: - Synthesis
    
    private func createRequest(requestURL: URL, config: NetConfig) -> URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpBody = config.body
        request.timeoutInterval = config.timeout
        request.httpMethod = config.HTTPMethod.rawValue
        request.cachePolicy = URLRequest.CachePolicy.init(rawValue: UInt(config.caching.rawValue))!
        request.httpShouldUsePipelining = true
        request.allowsCellularAccess = true
        
        if #available(iOS 13.0, *) {
            request.allowsConstrainedNetworkAccess = true
            request.allowsExpensiveNetworkAccess = true
        }
        
        // Headers
        if let headerData = config.headers {
            for headerName in headerData.keys {
                let headerValue: String = (config.headers?[headerName]!)!
                request.addValue(headerValue, forHTTPHeaderField: headerName)
            }
        }
        
        return request
    }
    
    // MARK: - Main Methods
    
    func getData(config: NetConfig, function: NetConfig.NetworkerFunction, completion: @escaping (NetResponse) -> ()) {
        let request = createRequest(requestURL: config.url, config: config)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        DataTask(request: request, session: session, config: config, function: function) { (response) in
            completion(response)
        }
    }
    
    private func DataTask(request: URLRequest,
                          session: URLSession,
                          config: NetConfig,
                          function: NetConfig.NetworkerFunction,
                          completion: @escaping (NetResponse) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, err) in
            if (err != nil) {
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: false, error: err as NSError?, data: nil)
                completion (netResponse)
            }
            else if NetUtilities.HTTPStatusValidation(status: (response as! HTTPURLResponse).statusCode) == false {
                let errorDescription = "HTTP Status code:\((response as! HTTPURLResponse).statusCode)"
                let error = NSError(domain: "gg.ugcesports.ugc", code: 1000, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
                                                                                        "NSLocalizedFailureReasonErrorKey": errorDescription])
                
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: false, error: error, data: nil)
                debugPrint("\(error.localizedDescription)")
                completion (netResponse)
            }
            else if (data?.isEmpty)! || data == nil {
                let errorDescription = "Data length is zero"
                
                let error = NSError(domain: "gg.ugcesports.ugc", code: 2000, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
                                                                                        "NSLocalizedFailureReasonErrorKey": errorDescription])
                
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: false, error: error, data: nil)
                completion (netResponse)
            }
            else {
                var returningData: Any?
                
                switch function {
                case .JSON:
                    returningData = NetData.DataToJSON(data: data!)
                    
                case .Image:
                    returningData = UIImage(data: data!)!
                    
                case .Data:
                    returningData = data!
                }
                
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: true, error: nil, data: returningData)
                completion(netResponse)
            }
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func UploadTask(request: URLRequest, session: URLSession, completion: @escaping (NetResponse) -> Void) {
        assert(true, "Not yet complete")
    }
    
    func DownloadTask(request: URLRequest, session: URLSession, completion: @escaping (NetResponse) -> Void) {
        assert(true, "Not yet complete")
    }
    
    // MARK: Delegates
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        //debugPrint("finished task \(session)")
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        //debugPrint("invalidated with reason: \(String(describing: error?.localizedDescription))")
    }
}
