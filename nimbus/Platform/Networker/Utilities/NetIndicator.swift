//
//  NetIndicator.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetIndicator: NSObject {
    
    static var counter: Int = 0
    
    class func StartActivity() {
        self.increaseActivity()
    }
    
    class func StopActivity() {
        self.counter = 0
        self.displayIndicator()
    }
    
    class func increaseActivity() {
        counter += 1
        self.displayIndicator()
    }
    
    class func decreaseActivity() {
        counter -= 1
        self.displayIndicator()
    }
    
    private class func displayIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = counter > 0
    }
}
