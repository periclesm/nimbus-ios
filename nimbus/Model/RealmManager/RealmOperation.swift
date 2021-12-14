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

/// Contains a set of functions acting as CRUD database operations
class RealmOperation: NSObject {

	//MARK: - Get Data Master Function

	/// Returns the data requsted from the database
	/// - Important:
	/// It is not recommended to use the function directly.
	/// Instead either use the functions in `RealmQuery` to retrieve data or create a rule function in one of the app's controllers
	/// to process the data further and transform (if needed) to what will be displayed in the UI.
	/// - Parameter rObject: The Realm object.
	/// - Returns: A Realm Results collection of the requested Object.
	class func get(rObject: Object.Type) -> Results<Object> {
		let data = RealmDatabase.shared.db.objects(rObject)
		return data
	}

	//MARK: - Additions & Updates

	/// Adds a single object in the database
	/// - Parameters:
	///   - rObject: The Realm object.
	///   - updatePolicy: Follows the `Realm.UpdatePolicy` on what to do with an existing object, if it's going to overwrite `all` data or those `modified`. Defaults (for the app) in `.modified`
	class func add(rObject: Object, updatePolicy: Realm.UpdatePolicy = .modified) {
		let db = RealmDatabase.shared.db

		do {
			try db.write {
				db.add(rObject, update: updatePolicy)
			}
		} catch let error as NSError {
			debugPrint("Error in adding object: \(error.localizedDescription)")
		}

	}

	/// Same as `add()`, only it adds Realm objects in an array instead of one-by-one.
	/// - Parameters:
	///   - objectArray: An array of Realm objects
	///   - updatePolicy: Follows the `Realm.UpdatePolicy` on what to do with an existing object, if it's going to overwrite `all` data or those `modified`. Defaults (for the app) in `.modified`
	class func add(objectArray: Array<Object>?, updatePolicy: Realm.UpdatePolicy = .modified) {
		guard let data = objectArray else {
			return
		}

		if !data.isEmpty {
			let db = RealmDatabase.shared.db

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

	/// Deletes a single object from the database
	/// - Parameter rObject: The Realm object to be deleted.
	class func delete(rObject: Object) {
		let db = RealmDatabase.shared.db

		do {
			try db.write {
				db.delete(rObject)
			}
		} catch let error as NSError {
			debugPrint("Error in deleting object: \(error.localizedDescription)")
		}
	}

	/// Delete a collection (Realm `List`) of objects from the database
	/// - Parameter objectList: The collection of Realm objects.
	class func delete(objectList: List<Object>) {
		let db = RealmDatabase.shared.db

		do {
			try db.write {
				db.delete(objectList)
			}
		} catch let error as NSError {
			debugPrint("Error in deleting data list: \(error.localizedDescription)")
		}
	}

	/// Delete all entries of an Realm object, emptying the database table.
	/// - Parameter rObject: The Realm object.
	class func deleteAll(rObject: Object.Type) {
		let db = RealmDatabase.shared.db

		do {
			try db.write {
				let entries = db.objects(rObject)
				db.delete(entries)
			}
		} catch let error as NSError {
			debugPrint("Error in deleting all object data: \(error.localizedDescription)")
		}
	}

	/// Deletes everything from the database
	class func deleteAllData() {
		let db = RealmDatabase.shared.db
		
		do {
			try db.write {
				db.deleteAll()
			}
		} catch let error as NSError {
			debugPrint("Error in deleting all data: \(error.localizedDescription)")
		}
	}
}
