//
//  DataOperation.swift
//  UGC
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class RealmOperation: NSObject {

	//MARK: - Get Data Master Function --

	class func get(dataObject: Object.Type) -> Results<Object>? {
		if let data = Database.shared.mainDB?.objects(dataObject) {
			return data
		}

		return nil
	}

	//MARK: - Additions & Updates --

	/// Adds a single object in the database
	class func add(dataObject: Object, updatePolicy: Realm.UpdatePolicy = .modified) {
		if let db = Database.shared.mainDB {
			do {
				try db.write {
					db.add(dataObject, update: updatePolicy)
				}
			} catch let error as NSError {
				debugPrint("Error in adding object: \(error.localizedDescription)")
			}
		}
	}

	/// Adds an array of objects in the database
	class func add(dataList: Array<Object>?, updatePolicy: Realm.UpdatePolicy = .modified) {
		guard let data = dataList else {
			return
		}

		if !data.isEmpty {
			if let db = Database.shared.mainDB {
				do {
					try db.write {
						db.add(dataList!, update: updatePolicy)
					}
				} catch let error as NSError {
					debugPrint("Error in adding object array: \(error.localizedDescription)")
				}
			}
		}
	}

	//MARK: - Deletions --

	/// Delete an object from the database
	class func delete(dataObject: Object) {
		if let db = Database.shared.mainDB {
			do {
				try db.write {
					db.delete(dataObject)
				}
			} catch let error as NSError {
				debugPrint("Error in deleting object: \(error.localizedDescription)")
			}
		}
	}

	/// Delete an array of objects from the database
	class func delete(dataList: List<Object>) {
		if let db = Database.shared.mainDB {
			do {
				try db.write {
					db.delete(dataList)
				}
			} catch let error as NSError {
				debugPrint("Error in deleting data list: \(error.localizedDescription)")
			}
		}
	}

	/// Delete all entries of an entity/object/table
	class func deleteAll(dataObject: Object.Type) {
		if let db = Database.shared.mainDB {
			do {
				try db.write {
					db.delete(db.objects(dataObject))
				}
			} catch let error as NSError {
				debugPrint("Error in deleting all object data: \(error.localizedDescription)")
			}
		}
	}

	/// Delete everything from the database - Use it only when the user logs out
	class func deleteAllData() {
		if let db = Database.shared.mainDB {
			do {
				try db.write {
					db.deleteAll()
				}
			} catch let error as NSError {
				debugPrint("Error in deleting all data: \(error.localizedDescription)")
			}
		}
	}
}
