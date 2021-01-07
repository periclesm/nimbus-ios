//
//  CloudVM.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 31/12/20.
//  Copyright © 2020 Cloudfields. All rights reserved.
//

import Foundation
import RealmSwift

class CloudVM: NSObject {

	var cloudArray: Array<Cloud> = []
	var selectedCloud: Cloud = Cloud()

	override init() {
		super.init()
		self.getData()
	}

	func getData() {
		cloudArray = CloudController.getCloudData(sortBy: "order", ascending: true)
	}

	func refreshData(sender: UITableViewController) {
		DataManager.getCombinedData(cachePolicy: .reloadIgnoringLocalAndRemoteCacheData) { (completed) in
			self.getData()
			sender.tableView.reloadData()
			sender.refreshControl?.endRefreshing()
		}
	}
}
