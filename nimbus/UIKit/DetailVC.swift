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
    
    let vm = DetailVM()
    
    @IBOutlet weak var clImage: UIImageView!
    @IBOutlet weak var clInitials: UILabel!
    @IBOutlet weak var clName: UILabel!
    @IBOutlet weak var clAltitude: UILabel!
    @IBOutlet weak var clDetails: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.getCloudData()
	}
    
    // MARK: - Data
    
    func getCloudData() {
		self.title = vm.cloud?.name
        clInitials.text = vm.cloud?.initials
        clName.text = vm.cloud?.name
		clAltitude.text = (vm.cloud?.type!.name)! + " altitude"
		clDetails.text = vm.cloud?.detail?.detail
		self.getCloudImage()
        
    }
	
	private func getCloudImage() {
		clImage.alpha = 0
		activity.startAnimating()
		
		Task(priority: .medium) {
			let imageURL = vm.getImageURL(vm.cloud?.objectId)
			self.clImage.image = await vm.asyncCloudImage(imageURL: imageURL)
			self.activity.stopAnimating()
			UIView.animate(withDuration: 0.25) {
				self.clImage.alpha = 1
			}
		}
	}

    // MARK: - Actions
    
    @IBAction func WikiButton(_ sender: UIBarButtonItem) {
		if let url = vm.getWikiURL(vm.cloudId) {
			let config = SFSafariViewController.Configuration()
			config.barCollapsingEnabled = true
			config.entersReaderIfAvailable = true
			
			let safari = SFSafariViewController(url: url, configuration: config)
			safari.modalPresentationStyle = .formSheet
			safari.modalTransitionStyle = .coverVertical
            safari.preferredControlTintColor = UIColor.systemIndigo
            
			self.present(safari, animated: true, completion: nil)
		}
	}
}
