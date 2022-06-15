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
        
    // MARK: - Main Methods
    
    func getData(config: NetConfig, function: NetworkerFunction, completion: @escaping (NetResponse) -> ()) {
		guard let requestURL = config.url else {
			let errorDescription = "Error in request URL"
			let error = NSError(domain: "nimbus", code: 500, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
																		 "NSLocalizedFailureReasonErrorKey": errorDescription])
			
			let response = NetResponse(identifier: config.identifier, completed: false, error: error, data: nil)
			
			completion(response)
			return
		}
		
		let request = NetSession.request(requestURL: requestURL, config: config)
        //let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
		let session = NetSession.session(config: config, delegate: self)
        
        DataTask(request: request, session: session, config: config, function: function) { (response) in
            completion(response)
        }
    }
    
    private func DataTask(request: URLRequest,
                          session: URLSession,
                          config: NetConfig,
                          function: NetworkerFunction,
                          completion: @escaping (NetResponse) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, err) in
            if (err != nil) {
				let response = NetResponse(identifier: config.identifier, completed: false, error: err as NSError?, data: nil)
                completion(response)
            }
            else if NetUtilities.HTTPStatusValidation(status: (response as! HTTPURLResponse).statusCode) == false {
                let errorDescription = "HTTP Status code:\((response as! HTTPURLResponse).statusCode)"
                let error = NSError(domain: "nimbus", code: 1000, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
                                                                                        "NSLocalizedFailureReasonErrorKey": errorDescription])
                
				let response = NetResponse(identifier: config.identifier, completed: false, error: error, data: nil)
                debugPrint("\(error.localizedDescription)")
                completion(response)
            }
            else if (data?.isEmpty)! || data == nil {
                let errorDescription = "Data length is zero"
                
                let error = NSError(domain: "nimbus", code: 2000, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
                                                                                        "NSLocalizedFailureReasonErrorKey": errorDescription])
                
				let response = NetResponse(identifier: config.identifier, completed: false, error: error, data: nil)
                completion(response)
            }
            else {
                var content: Any?
                
                switch function {
                case .json:
					content = NetData.dataToJSON(data: data!)
                    
                case .image:
					content = UIImage(data: data!)!
                    
                case .data:
					content = data!
                }
                
				let response = NetResponse(identifier: config.identifier, completed: true, error: nil, data: content)
                completion(response)
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
