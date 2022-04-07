//
//  DetailVM.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 28/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import Foundation
import UIKit

class DetailVM: NSObject {
	
	var cloud: Cloud? = nil
	
	var cloudId: String = "" {
		didSet {
			self.cloud = self.getCloudData(self.cloudId)
		}
	}
	
	//MARK: - Cloud Data --
	
	func getCloudData(_ objectId: String) -> Cloud? {
		return CloudController.getCloud(objectId: objectId)
	}
	
	// MARK: - Image functions --
	
	func getCloudImage(completion: @escaping ((UIImage?) -> Void)) {
		let imageURL = self.getImageURL(self.cloud?.objectId)
		let config = NetConfig(HTTPMethod: .GET, timeout: 10, url: imageURL)
		
		Networker.getImage(config: config) { (response) in
			if response.completed {
				completion(response.data as? UIImage)
			}
			else {
				assert(true, "Return a default image")
				completion(nil)
			}
		}
	}
	
	//MARK: - Wiki functions --
	
	private func getImageURL(_ objectId: String?) -> URL? {
		guard let id = objectId else {
			return nil
		}
		
		return CloudController.getImageURL(for: id)
	}
	
	func getWikiURL(_ objectId: String) -> URL? {
		return CloudController.getWikiURL(for: objectId)
	}
}
