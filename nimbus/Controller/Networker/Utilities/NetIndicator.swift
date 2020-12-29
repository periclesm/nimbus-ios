//
//  NetIndicator.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 02/08/2017.
//  Copyright © 2017 Pericles Maravelakis. All rights reserved.
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
