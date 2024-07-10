//
//  DataOperation.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 9/11/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation
import RealmSwift

final class RealmOperation: NSObject, Sendable {

	func autoincrement(_ dataObject: Object.Type) -> Int {
		let total = Database.shared.db.objects(dataObject).count
		return total + 1
	}
	
	func count(dataObject: Object.Type) -> Int {
		return Database.shared.db.objects(dataObject).count
	}
	
	//MARK: - Get Data Master Function
	
	func get<T: Object>(dataObject: T.Type) -> Results<T> {
		let data = Database.shared.db.objects(dataObject)
		return data
	}
	
	//MARK: - Additions & Updates
	
	/// Adds a single object in the database
	func insert(dataObject: Object) throws {
		do {
			try Database.shared.db.write {
				Database.shared.db.add(dataObject, update: .modified)
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in adding object: \(error.localizedDescription)")
			throw error
		}
	}
	
	/// Adds an array of objects in the database
	func insertCollection(dataList: Array<Object>) throws {
		do {
			try Database.shared.db.write {
				Database.shared.db.add(dataList, update: .modified)
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in adding object array: \(error.localizedDescription)")
			throw error
		}
	}
	
	/// Adds a new object that needs to be manually initialized or updates an existing object that was retrieved earlier.
	func update(dataObject: (() -> Object)?) throws {
		do {
			try Database.shared.db.write {
				if let object = dataObject?() {
					Database.shared.db.add(object, update: .modified)
				}
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in adding object: \(error.localizedDescription)")
			throw error
		}
	}
	
	//MARK: - Deletions
	
	/// Delete an object from the database
	func delete(dataObject: Object) throws {
		do {
			try Database.shared.db.write {
				Database.shared.db.delete(dataObject)
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in deleting object: \(error.localizedDescription)")
			throw error
		}
	}
	
	/// Delete an array of objects from the database
	func delete(dataList: List<Object>) throws {
		do {
			try Database.shared.db.write {
				Database.shared.db.delete(dataList)
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in deleting data list: \(error.localizedDescription)")
			throw error
		}
	}
	
	/// Delete everything from a table
	@MainActor
	func deleteAll(dataObject: Object.Type) throws {
		let data = Database.shared.db.objects(dataObject)
		
		do {
			try Database.shared.db.write {
				Database.shared.db.delete(data)
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in deleting data: \(error.localizedDescription)")
			throw error
		}
	}
	
	/// Delete everything from the database
	@MainActor
	func deleteEverything() throws {
		do {
			try Database.shared.db.write {
				Database.shared.db.deleteAll()
			}
		} catch let error as NSError {
			debugPrint("[REALM] Error in deleting all data: \(error.localizedDescription)")
			throw error
		}
	}
	
	//MARK: - Comparisons
	
	/**
	 Compares two Realm objects. Returns `true` if objects are the same.
	 */
	func compare<T: Object>(_ firstObject: T, _ secondObject: T) -> Bool {
		// Get the list of all properties of the objects
		let objectSchema = firstObject.objectSchema
		
		for property in objectSchema.properties {
			let propertyName = property.name
			
			if propertyName != "objectId" {
				// Using KVC (Key-Value Coding) to get the value of the property
				if let value1 = firstObject.value(forKey: propertyName), let value2 = secondObject.value(forKey: propertyName) {
					if !compareValues(value1, value2) {
						return false
					}
				} else if (firstObject.value(forKey: propertyName) == nil) != (secondObject.value(forKey: propertyName) == nil) {
					return false
				}
			}
		}
		
		return true
	}
	
	///Compares two values. Returns `true` is equal
	func compareValues(_ value1: Any, _ value2: Any) -> Bool {
		if let value1 = value1 as? NSObject, let value2 = value2 as? NSObject {
			return value1.isEqual(value2)
		}
		return false
	}
}
