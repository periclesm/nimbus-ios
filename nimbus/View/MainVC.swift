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

	var vm = CloudVM()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let dvc = segue.destination as! DetailVC
			dvc.vm = self.vm
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func refreshData() {
		vm.refreshData(sender: self)
    }

    // MARK: - UITableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return vm.cloudArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cl = vm.cloudArray[indexPath.row]
		return TableCellConstructor.cloudCell(for: tableView, dataObject: cl, index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
		let cl = vm.cloudArray[indexPath.row]
		vm.selectedCloud = vm.cloudArray[indexPath.row]
        self.performSegue(withIdentifier: "detailSegue", sender: cl.objectId)
    }
}
