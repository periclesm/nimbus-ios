//
//  DataOperation.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 9/11/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

final class RealmOperation: NSObject {

	//MARK: - Get Data Master Function --

	class func get(dataObject: Object.Type) -> Results<Object> {
		let data = Database.shared.db.objects(dataObject)
		return data
	}

	//MARK: - Additions & Updates --

	/// Adds a single object in the database
	class func add(_ object: Object, updatePolicy: Realm.UpdatePolicy = .modified) -> Bool {
		let db = Database.shared.db

		do {
			try db.write {
				db.add(object, update: updatePolicy)
			}
		} catch {
			debugPrint("Error in adding object: \(error.localizedDescription)")
			return false
		}
		
		return true
	}

	/// Adds an array of objects in the database
	class func add(dataArray: Array<Object>?, updatePolicy: Realm.UpdatePolicy = .modified) -> Bool {
		guard let data = dataArray else {
			return false
		}

		if !data.isEmpty {
			let db = Database.shared.db

			do {
				try db.write {
					db.add(data, update: updatePolicy)
				}
			} catch {
				debugPrint("Error in adding object array: \(error.localizedDescription)")
				return false
			}
		}
		
		return true
	}

	//MARK: - Deletions --

	/// Delete an object from the database
	class func delete(dataObject: Object) -> Bool {
		let db = Database.shared.db

		do {
			try db.write {
				db.delete(dataObject)
			}
		} catch {
			debugPrint("Error in deleting object: \(error.localizedDescription)")
			return false
		}
		
		return true
	}

	/// Delete an array of objects from the database
	class func delete(dataList: List<Object>) -> Bool {
		let db = Database.shared.db

		do {
			try db.write {
				db.delete(dataList)
			}
		} catch {
			debugPrint("Error in deleting data list: \(error.localizedDescription)")
			return false
		}
		
		return true
	}

	/// Delete all entries of an entity/object/table
	class func deleteAll(dataObject: Object.Type) -> Bool {
		let db = Database.shared.db

		do {
			try db.write {
				db.delete(db.objects(dataObject))
			}
		} catch {
			debugPrint("Error in deleting all object data: \(error.localizedDescription)")
			return false
		}
		
		return true
	}

	/// Delete everything from the database - Use it only when the user logs out
	class func deleteAllData() -> Bool {
		let db = Database.shared.db
		
		do {
			try db.write {
				db.deleteAll()
			}
		} catch {
			debugPrint("Error in deleting all data: \(error.localizedDescription)")
			return false
		}
		
		return true
	}
}
