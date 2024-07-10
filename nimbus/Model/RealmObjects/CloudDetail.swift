//
//  Detail.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation
import RealmSwift

class CloudDetail: Object, Codable {

	@Persisted(primaryKey: true) var objectId: String = ""
	@Persisted var detail: String = ""
	@Persisted(indexed: true) var image: String = ""
	@Persisted(indexed: true) var wiki: String = ""

}
