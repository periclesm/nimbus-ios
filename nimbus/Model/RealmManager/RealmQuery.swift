//
//  DataAccess.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation
import RealmSwift

final class RealmQuery: NSObject, Sendable {

	//MARK: - Composite Sort and Filter
	
	func filterAndSort<T: Object>(dataObject: T.Type,
											 predicate: NSPredicate,
											 keypath: String, ascending: Bool = true) -> Results<T> {
		
		let data = Database.shared.db.objects(dataObject)
			.filter(predicate)
			.sorted(byKeyPath: keypath, ascending: ascending)
		
		return data
	}
	
	func filterAndSort<T: Object>(dataList: Results<T>,
								  predicate: NSPredicate,
								  keypath: String, ascending: Bool = true) -> Results<T> {
		
		let data = dataList
			.filter(predicate)
			.sorted(byKeyPath: keypath, ascending: ascending)
		
		return data
	}
	
	//MARK: - Filter
	
	func filter<T: Object>(dataObject: T.Type, predicate: NSPredicate) -> Results<T> {
		let data = Database.shared.db.objects(dataObject)
			.filter(predicate)
		
		return data
	}
	
	func filter<T: Object>(dataList: Results<T>, predicate: NSPredicate) -> Results<T> {
		let result = dataList.filter(predicate)
		return result
	}
	
	//MARK: - Sort
	
	func sort<T: Object>(dataObject: T.Type, keypath: String, ascending: Bool = true) -> Results<T> {
		
		let data = Database.shared.db.objects(dataObject)
			.sorted(byKeyPath: keypath, ascending: ascending)
		
		return data
	}
	
	func sort<T: Object>(dataList: Results<T>, keypath: String, ascending: Bool = true) -> Results<T> {
		
		let sorted = dataList
			.sorted(byKeyPath: keypath, ascending: ascending)
		
		return sorted
	}
}

extension Results {
	
	///Converts a Realm Results collection into an Array
	func toArray() -> Array<Element> {
		return compactMap { $0 }
	}
	
	///Converts a Realm Results collection into a Realm List
	func toList() -> List<Element> {
		let list = List<Element>()
		list.append(objectsIn: self)
		
		return list
	}
}
