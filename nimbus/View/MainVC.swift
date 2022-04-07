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
    
	let vm = MainVM()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let dvc = segue.destination as! DetailVC
			if let object = sender as? String {
				dvc.vm.cloudId = object
			}
        }
    }
    
    // MARK: - Actions
    
    @IBAction func refreshData() {
		vm.refreshData { completed in
			if completed {
				self.tableView.reloadData()
				self.refreshControl?.endRefreshing()
			}
		}
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return vm.clouds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return TableCellSynthesis.cloudCell(for: tableView, datasource: vm.clouds, index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
		let cl = vm.clouds[indexPath.row]
		self.performSegue(withIdentifier: "detailSegue", sender: cl.objectId)
    }
}
