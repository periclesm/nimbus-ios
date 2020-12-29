//
//  Networker.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class Networker: NSObject {
    
    class func getJSONData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
        NetIndicator.increaseActivity()
        
        let net = NetAgent.sharedInstance
        net.getData(config: config, function: NetConfig.NetworkerFunction.JSON) { (response) in
            NetIndicator.decreaseActivity()
            completion(response)
        }
    }
    
    class func getImage(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
        NetIndicator.increaseActivity()
        
        let net = NetAgent.sharedInstance
        net.getData(config: config, function: NetConfig.NetworkerFunction.Image) { (response) in
            NetIndicator.decreaseActivity()
            completion(response)
        }
    }
    
    class func getData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
        NetIndicator.increaseActivity()
        
        let net = NetAgent.sharedInstance
        net.getData(config: config, function: NetConfig.NetworkerFunction.Data) { (response) in
            NetIndicator.decreaseActivity()
            completion(response)
        }
    }
    
    class func cancelSessionTask(url: String, completion: @escaping (Bool) -> ()) {
        //let net = NetAgent.sharedInstance
        debugPrint("Task enumeration")
    }
}
