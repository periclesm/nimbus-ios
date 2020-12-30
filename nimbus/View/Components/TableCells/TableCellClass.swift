//
//  TableCellClass.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  Copyright © 2020 Cloudfields. All rights reserved.
//

import UIKit

class cloudCell: UITableViewCell {
	
    @IBOutlet weak var cloudInitials: UILabel!
    @IBOutlet weak var cloudName: UILabel!
    @IBOutlet weak var cloudDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
}
