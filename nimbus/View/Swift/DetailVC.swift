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

class DetailVC: UITableViewController {
    
    var objectId: String = ""
    
    @IBOutlet weak var clImage: UIImageView!
    @IBOutlet weak var clInitials: UILabel!
    @IBOutlet weak var clName: UILabel!
    @IBOutlet weak var clAltitude: UILabel!
    @IBOutlet weak var clDetails: UILabel!
    @IBOutlet weak var activity: ActivityView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCloudData()
    }
    
    // MARK: - Data
    
    func getCloudData() {
        let cl = DataLogic.getCloudInfo(self.objectId)
        
        self.title = cl?.name
        clInitials.text = cl?.initials
        clName.text = cl?.name
        clAltitude.text = DataLogic.getCloudType(cl?.type) + " altitude"
        clDetails.text = DataLogic.getCloudDetails(cl?.detail, shortText: false)
        
        clImage.alpha = 0
        activity.startAnimating()

		let config = NetConfig.initWithConfig(requestURL: URL(string: DataLogic.getCloudImageURL(cl?.detail)), requestTimeout: 10, requestMethod: .GET)
		Networker.getImage(config: config) { (response) in
			if response.completed {
				self.clImage.image = response.data as? UIImage
				UIView.animate(withDuration: 0.25) {
					self.clImage.alpha = 1
				}
			}

			self.activity.stopAnimating()
		}
        
//        Networker.getRemoteImage(DataLogic.getCloudImageURL(cl?.detail)) { (image) in
//            self.clImage.image = image
//            UIView.animate(withDuration: 0.25) {
//                self.clImage.alpha = 1
//            }
//            self.activity.stopAnimating()
//        }
    }

    // MARK: - Actions
    
    @IBAction func WikiButton(_ sender: UIBarButtonItem) {
		if let cl = DataLogic.getCloudInfo(self.objectId) {
			if let url = URL(string: DataLogic.getCloudWikiURL(cl.detail)) {
				let safari = SFSafariViewController(url: url)
				safari.modalPresentationStyle = .formSheet
				safari.modalTransitionStyle = .coverVertical
				self.present(safari, animated: true, completion: nil)
			}
		}
	}
}
