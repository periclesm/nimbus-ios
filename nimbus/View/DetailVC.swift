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
    
    let vm = DetailVM()
    
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
		self.title = vm.cloud?.name
        clInitials.text = vm.cloud?.initials
        clName.text = vm.cloud?.name
		clAltitude.text = (vm.cloud?.type!.name)! + " altitude"
		clDetails.text = vm.cloud?.detail?.detail
        
        clImage.alpha = 0
        activity.startAnimating()
		
		let requestURL = URL(string: (vm.cloud?.detail!.image)!)
		
		let config = NetConfig(HTTPMethod: .GET, timeout: 10, url: requestURL)
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

    // MARK: - Actions
    
    @IBAction func WikiButton(_ sender: UIBarButtonItem) {
		if let clDetail = vm.cloud?.detail {
			if let url = URL(string: clDetail.wiki) {
				let safari = SFSafariViewController(url: url)
				safari.modalPresentationStyle = .formSheet
				safari.modalTransitionStyle = .coverVertical
				self.present(safari, animated: true, completion: nil)
			}
		}
	}
}
