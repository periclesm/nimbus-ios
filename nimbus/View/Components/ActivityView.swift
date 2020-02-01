//
//  ActivityView.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  Copyright © 2020 Cloudfields. All rights reserved.
//

import UIKit

class ActivityView: DGActivityIndicatorView {
    
    override func awakeFromNib() {
        self.type = .ballRotate
        self.size = self.frame.size.width - 8.0
        self.tintColor = UIColor.systemBlue
    }

}
