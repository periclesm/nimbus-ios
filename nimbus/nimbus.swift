//
//  nimbus.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

/*
 To enable UIKit:
 - Remove nimbus.swift to target
 - Add AppDelegate.swift from target
 - build and run
 */

import SwiftUI

@main
struct nimbus: App {
	var body: some Scene {
		WindowGroup {
			Intro()
		}
	}
}
