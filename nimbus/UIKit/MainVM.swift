//
//  MainVM.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 28/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import Foundation

class MainVM: NSObject {
	
	var clouds: CloudData = []
	
	override init() {
		super.init()
		self.getLocalData()
	}
	
	func getLocalData(sortBy: String = "order", ascending: Bool = true) {
		self.clouds = CloudController.getListData(sortBy: sortBy, ascending: ascending)
	}
	
	@MainActor func refreshDataAsync() async {
		await DataManager.asyncData()
		getLocalData()
	}
}
