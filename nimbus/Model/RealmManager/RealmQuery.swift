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

final class RealmQuery: NSObject {

	//MARK: - Composite Sort and Filter

	/**
	Given an object, this function filters and sorts data according to input parameters
	*/
	class func filterAndSort(dataObject: Object.Type,
							 predicate: NSPredicate,
							 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> Results<Object>? {

		return RealmOperation.get(dataObject: dataObject).filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending)
	}

	/**
	Given a Realm Results Collection, this function filters and sorts data according to input parameters
	*/
	class func filterAndSort(dataResults: Results<Object>?,
							 predicate: NSPredicate,
							 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> Results<Object>? {

		if let data = dataResults?.filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending) {
			return data
		}

		return nil
	}

	/**
	Given an Realm List Collection, this function filters and sorts data according to input parameters
	*/
	class func filterAndSort(dataList: List<Object>?,
							 predicate: NSPredicate,
							 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> Results<Object>? {

		if let dataList {
			return dataList.filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending)
		}

		return nil
	}

	//List output functions

	class func filterAndSortList(dataObject: Object.Type,
								 predicate: NSPredicate,
								 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> List<Object> {

		let data = RealmOperation.get(dataObject: dataObject).filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending)
		return self.resultsToListConversion(results: data)
	}

	class func filterAndSortList(dataResults: Results<Object>?,
								 predicate: NSPredicate,
								 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> List<Object> {

		if let data = dataResults?.filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending) {
			return self.resultsToListConversion(results: data)
		}

		return List()
	}


	//MARK: - Filter
	
	class func filter(dataObject: Object.Type, predicate: NSPredicate) -> Results<Object>? {
		return RealmOperation.get(dataObject: dataObject).filter(predicate)
	}
	
	class func filter(dataResults: Results<Object>?, predicate: NSPredicate) -> Results<Object>? {
		return dataResults?.filter(predicate)
	}

	class func filter(dataList: List<Object>?, predicate: NSPredicate) -> Results<Object>? {
		return dataList?.filter(predicate)
	}


	//MARK: - Sort

	class func sort(dataObject: Object.Type, sortAttribute: String, ascending: Bool = true) -> Results<Object>? {
		return RealmOperation.get(dataObject: dataObject).sorted(byKeyPath: sortAttribute, ascending: ascending)
	}
	
	class func sort(dataResults: Results<Object>, sortAttribute: String, ascending: Bool = true) -> Results<Object> {
		return dataResults.sorted(byKeyPath: sortAttribute, ascending: ascending)
	}

	class func sort(dataList: List<Object>, sortAttribute: String, ascending: Bool = true) -> Results<Object> {
		return dataList.sorted(byKeyPath: sortAttribute, ascending: ascending)
	}


	//MARK: - Limit
	
	class func limitArray(dataArray: Array<Any>, limit: Int) -> Array<Any> {
		if limit < dataArray.count {
			return (dataArray as NSArray).subarray(with: NSRange(location: 0, length: limit))
		}

		return dataArray
	}


	//MARK: - Utilities

	class func resultsToListConversion(results: Results<Object>?) -> List<Object> {
		if let results {
			if results.count > 0 {
				let newList: List<Object> = List()

				for object in results {
					newList.append(object)
				}
			}
		}

		return List()
	}
}
