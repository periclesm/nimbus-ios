//
//  DataOperation.swift
//  UGC
//
//  Created by Pericles Maravelakis on 9/11/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class RealmOperation: NSObject {

	//MARK: - Get Data Master Function --

	class func get(dataObject: Object.Type) -> Results<Object> {
		let data = Database.shared.db.objects(dataObject)
		return data
	}

	//MARK: - Additions & Updates --

	/// Adds a single object in the database
	class func add(dataObject: Object, updatePolicy: Realm.UpdatePolicy = .modified) {
		let db = Database.shared.db

		do {
			try db.write {
				db.add(dataObject, update: updatePolicy)
			}
		} catch let error as NSError {
			debugPrint("Error in adding object: \(error.localizedDescription)")
		}

	}

	/// Adds an array of objects in the database
	class func add(dataArray: Array<Object>?, updatePolicy: Realm.UpdatePolicy = .modified) {
		guard let data = dataArray else {
			return
		}

		if !data.isEmpty {
			let db = Database.shared.db

			do {
				try db.write {
					db.add(data, update: updatePolicy)
				}
			} catch let error as NSError {
				debugPrint("Error in adding object array: \(error.localizedDescription)")
			}
		}
	}

	//MARK: - Deletions --

	/// Delete an object from the database
	class func delete(dataObject: Object) {
		let db = Database.shared.db

		do {
			try db.write {
				db.delete(dataObject)
			}
		} catch let error as NSError {
			debugPrint("Error in deleting object: \(error.localizedDescription)")
		}
	}

	/// Delete an array of objects from the database
	class func delete(dataList: List<Object>) {
		let db = Database.shared.db

		do {
			try db.write {
				db.delete(dataList)
			}
		} catch let error as NSError {
			debugPrint("Error in deleting data list: \(error.localizedDescription)")
		}
	}

	/// Delete all entries of an entity/object/table
	class func deleteAll(dataObject: Object.Type) {
		let db = Database.shared.db

		do {
			try db.write {
				db.delete(db.objects(dataObject))
			}
		} catch let error as NSError {
			debugPrint("Error in deleting all object data: \(error.localizedDescription)")
		}
	}

	/// Delete everything from the database - Use it only when the user logs out
	class func deleteAllData() {
		let db = Database.shared.db
		
		do {
			try db.write {
				db.deleteAll()
			}
		} catch let error as NSError {
			debugPrint("Error in deleting all data: \(error.localizedDescription)")
		}
	}
}
