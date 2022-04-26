//
//  InitialsLabel.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 27/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import UIKit

class InitialsLabel: UILabel {

	override func awakeFromNib() {
		self.layer.cornerRadius = self.frame.size.height / 2
	}

}
