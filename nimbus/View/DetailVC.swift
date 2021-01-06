//
//  DetailVC.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  periclesm@cloudfields.net
//  Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//  https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit
import SafariServices
import NVActivityIndicatorView

class DetailVC: UITableViewController {
    
	var vm: CloudVM!
    
    @IBOutlet weak var clImage: UIImageView!
    @IBOutlet weak var clInitials: UILabel!
    @IBOutlet weak var clName: UILabel!
    @IBOutlet weak var clAltitude: UILabel!
    @IBOutlet weak var clDetails: UILabel!
    @IBOutlet weak var activity: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCloudData()
		activity.type = .ballRotate
    }
    
    // MARK: - Data
    
    func getCloudData() {
		let cl = CloudController.getCloud(objectId: vm.selectedCloud.objectId)

		self.title = cl?.name
		clInitials.text = cl?.initials
		clName.text = cl?.name
		clAltitude.text = (cl?.type!.name)! + " altitude"
		clDetails.text = cl?.detail?.detail

		clImage.alpha = 0
		activity.startAnimating()

		let config = NetConfig.initWithConfig(requestURL: URL(string: (cl?.detail!.image)!)!, requestTimeout: 10, requestMethod: .GET)
		Networker.getImage(config: config) { (response) in
			if response.completed {
				self.clImage.image = response.data as? UIImage
				UIView.animate(withDuration: 0.25) {
					self.clImage.alpha = 1
				}
			}

			self.activity.stopAnimating()
		}
	}

    // MARK: - IB Actions
    
    @IBAction func WikiButton(_ sender: UIBarButtonItem) {
		if let cl = CloudController.getCloud(objectId: vm.selectedCloud.objectId) { //DataLogic.getCloudInfo(self.objectId) {
			if let url = URL(string: cl.detail!.wiki) {
				let safari = SFSafariViewController(url: url)
				safari.modalPresentationStyle = .formSheet
				safari.modalTransitionStyle = .coverVertical
				self.present(safari, animated: true, completion: nil)
			}
		}
	}
}
