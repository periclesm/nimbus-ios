//
//  MainVC.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  periclesm@cloudfields.net
//  Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//  https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class MainVC: UITableViewController {
    
    var cloudArray: Array<Any> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        cloudArray = self.getCloudData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let dtc = segue.destination as! DetailVC
            dtc.objectId = sender as? String ?? ""
        }
    }
    
    // MARK: - Data
    
    func getCloudData() -> Array<Any> {
        if !cloudArray.isEmpty {
            cloudArray.removeAll()
        }

		return CloudController.getListData(sortBy: "order", ascending: true)
    }
    
    // MARK: - Actions
    
    @IBAction func refreshData() {
		DataManager.prefetchData { (completed) in
			self.tableView.reloadData()
			self.refreshControl?.endRefreshing()
		}
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cloudArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TableCellSynthesis.cloudCell(for: tableView, datasource: cloudArray, index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cl = cloudArray[indexPath.row] as! Cloud
        self.performSegue(withIdentifier: "detailSegue", sender: cl.objectId)
    }
}
