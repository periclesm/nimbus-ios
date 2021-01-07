//
//  NetworkAgent.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

/**
	This class is part of the Networker wrapper.

	- Important:
		Do not directly use functions in this class unless you can't do otherwise. The only usable function is
		```
		func getData(config: NetConfig, function: NetConfig.NetworkerFunction, completion: @escaping (NetResponse) -> ())
		```
		but you have to handle the response and parse data yourself.
*/
class NetAgent: NSObject {

    static let shared = NetAgent()

	/// Creates the `URLRequest` and its parameters to be used in `URLSession`. The `URLRequest` parameters are based on `NetConfig` plus some standard properties.
	/// - Parameters:
	///   - config: A `NetConfig` parameter object to be used in the call. See `NetConfig` documentation for details.
	/// - Returns: A `URLRequest` for the `URLSession` in `getData()` function.
    private func createRequest(config: NetConfig) throws -> URLRequest {

		guard let url = config.url else {
			throw NSError(domain: "Nimbus", code: 3000, userInfo: [
							"NSLocalizedDescriptionKey": "Please provide a URL... or make absolutely sure it's not null!",
							"NSLocalizedFailureReasonErrorKey": "Make sure your URL is not null"])
		}

		var request = URLRequest(url: url)
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


	/// The main function to trigger the network call.
	/// - Important:
	/// 	Use it only if necessary (and handle response yourself). Otherwise use the `Networker` functions.
	/// - Parameters:
	///   - config: A `NetConfig` parameter object to be used in the call. See `NetConfig` documentation for details.
	///   - completion: Returns a `NetResponse` object containing the response of the call, data (if successful) and error messages (if not). See `NetResponse` documentation for details.
    func getData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		do {
			let request = try self.createRequest(config: config)
			let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)

			self.DataTask(request: request, session: session, config: config) { (response) in
				completion(response)
			}}
		catch let error as NSError {
			debugPrint(error.localizedDescription)
		}
    }
    
    private func DataTask(request: URLRequest, session: URLSession, config: NetConfig, completion: @escaping (NetResponse) -> Void) {

		let task = session.dataTask(with: request) { (data, response, err) in
			// First Check: If URLSession returned an error, handle it here
            if (err != nil) {
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: false, error: err as NSError?, data: nil)
                completion (netResponse)
            }
			// Second check: If HTTP Status code was not nominal, handle it here
            else if NetUtilities.HTTPStatusValidation(status: (response as! HTTPURLResponse).statusCode) == false {
                let errorDescription = "HTTP Status code:\((response as! HTTPURLResponse).statusCode)"
                let error = NSError(domain: "Nimbus", code: 1000, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
                                                                                        "NSLocalizedFailureReasonErrorKey": errorDescription])
                
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: false, error: error, data: nil)
                debugPrint("\(error.localizedDescription)")
                completion (netResponse)
            }
			// Third check: If response data is empty (rare case), handle it here
            else if (data?.isEmpty)! || data == nil {
                let errorDescription = "Data length is zero"
                let error = NSError(domain: "Nimbus", code: 2000, userInfo: ["NSLocalizedDescriptionKey": errorDescription,
                                                                                        "NSLocalizedFailureReasonErrorKey": errorDescription])
                
                let netResponse = NetResponse.constructResponse(identifier: config.identifier, completed: false, error: error, data: nil)
                completion (netResponse)
            }
			// If none of the above, all is well and proceed
            else {
                var returningData: Any?

				//Format the response data according to the Networker function and return
				switch config.function {
					case .JSON:
						returningData = NetUtilities.DataToJSON(data: data!)

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

	/// `URLSession` function (to be implemented)
    func UploadTask(request: URLRequest, session: URLSession, completion: @escaping (NetResponse) -> Void) {
        assert(true, "Not yet complete")
    }

	/// (to be implemented)
    func DownloadTask(request: URLRequest, session: URLSession, completion: @escaping (NetResponse) -> Void) {
        assert(true, "Not yet complete")
    }
}

extension NetAgent: URLSessionDelegate {

	// `URLSession` delegate function (to be implemented)
	func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
		//debugPrint("finished task \(session)")
	}

	// `URLSession` delegate function (to be implemented)
	func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
		//debugPrint("invalidated with reason: \(String(describing: error?.localizedDescription))")
	}
}
