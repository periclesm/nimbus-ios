//
//  CloudVM.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 31/12/20.
//  Copyright © 2020 Cloudfields. All rights reserved.
//

import Foundation
import RealmSwift

class CloudVM: NSObject {

	var cloudArray: Array<Cloud> = []
	var selectedCloud: Cloud = Cloud()

	override init() {
		super.init()
		self.updateArray()
	}

	func updateArray() {
		cloudArray = CloudController.getListData(sortBy: "order", ascending: true)
	}

	func refreshData(sender: UITableViewController) {
		DataManager.getCombinedData { (completed) in
			self.updateArray()
			sender.tableView.reloadData()
			sender.refreshControl?.endRefreshing()
		}
	}
}
