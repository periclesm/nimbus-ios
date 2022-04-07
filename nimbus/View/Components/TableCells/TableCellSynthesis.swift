//
//  TableCellSynthesis.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 1/2/20.
//  Copyright © 2020 Cloudfields. All rights reserved.
//

import UIKit

class TableCellSynthesis: NSObject {
    
    class func cloudCell(for tableView: UITableView, datasource: Array<Any>, index: IndexPath) -> cloudCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cloudCell", for: index) as! cloudCell
        let cl = datasource[index.row] as! Cloud
        
        cell.cloudInitials?.text = cl.initials
        cell.cloudName?.text = cl.name
		cell.cloudDetail?.text = cl.excerpt
        
        return cell
    }
}
