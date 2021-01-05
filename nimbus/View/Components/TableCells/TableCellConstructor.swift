//
//  TableCellSynthesis.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  Copyright © 2020 Cloudfields. All rights reserved.
//

import UIKit

class TableCellConstructor: NSObject {
    
    class func cloudCell(for tableView: UITableView, dataObject: Cloud, index: IndexPath) -> cloudCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cloudCell", for: index) as! cloudCell
        
        cell.cloudInitials?.text = dataObject.initials
        cell.cloudName?.text = dataObject.name
		cell.cloudDetail?.text = dataObject.detail?.detail
        
        return cell
    }
}
