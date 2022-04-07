//
//  NetResponse.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

struct NetResponse {
    var identifier: String = ""
    var completed: Bool = false
    var error: NSError? = nil
    var data: Any? = nil
}
