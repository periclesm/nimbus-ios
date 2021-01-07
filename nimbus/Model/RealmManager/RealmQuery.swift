//
//  DataAccess.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

/// Contains a set of functions for data filtering and sorting.
class RealmQuery: NSObject {

	//MARK: - Composite Sort and Filter --

	/// Given an Realm object, this function filters and sorts data according to input parameters.
	/// - Parameters:
	///   - rObject: The Realm object.
	///   - predicate: A `NSPredicate` filter with the query parameters.
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	///   - limit: `Int` Limits the number of items returned. Only the top `limit` numbers are included.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func filterAndSort(rObject: Object.Type, predicate: NSPredicate,
							 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> Results<Object>? {

		return RealmOperation.get(rObject: rObject).filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending)
	}

	/// Given a Realm `Results` Collection, this function filters and sorts its data according to input parameters
	/// - Note:
	/// This function does not query the database. It uses the `objectResults` as input.
	/// - Parameters:
	///   - objectResults: The Realm `Results` (used as input)
	///   - predicate: A `NSPredicate` filter with the query parameters.
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	///   - limit: `Int` Limits the number of items returned. Only the top `limit` numbers are included.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func filterAndSort(objectResults: Results<Object>?, predicate: NSPredicate,
							 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> Results<Object>? {

		if let data = objectResults?.filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending) {
			return data
		}

		return nil
	}


	/// Given an Realm `List` Collection, this function filters and sorts data according to input parameters.
	/// - Note:
	/// This function does not query the database. It uses the `objectList` as input.
	/// - Parameters:
	///   - objectList: The Realm `List` (used as input)
	///   - predicate: A `NSPredicate` filter with the query parameters.
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	///   - limit: `Int` Limits the number of items returned. Only the top `limit` numbers are included.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func filterAndSort(objectList: List<Object>?, predicate: NSPredicate,
							 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> Results<Object>? {

		if let data = objectList {
			return data.filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending)
		}

		return nil
	}


	/// Given an Realm object, this function filters and sorts data according to input parameters.
	/// - Note:
	///  Same as
	///  ```
	///  filterAndSort(rObject:, predicate:, sortAttribute:, ascending:, limit:)
	///  ```
	///  but returning a Realm `List` instead.
	/// - Parameters:
	///   - rObject: The Realm object.
	///   - predicate: A `NSPredicate` filter with the query parameters.
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	///   - limit: `Int` Limits the number of items returned. Only the top `limit` numbers are included.
	/// - Returns: A Realm `List` collection with data of the requested query.
	class func filterAndSortList(rObject: Object.Type,
								 predicate: NSPredicate,
								 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> List<Object> {

		let data = RealmOperation.get(rObject: rObject).filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending)
		return self.resultsToListConversion(results: data)
	}


	/// Given a Realm `Results` Collection, this function filters and sorts its data according to input parameters
	/// - Note:
	/// Same as
	/// ```
	/// filterAndSort(objectResults:, predicate:, sortAttribute:, ascending:, limit:)
	/// ```
	/// This function does not query the database. It uses the `objectResults` as input and returns a Realm `List` instead.
	/// - Parameters:
	///   - objectResults: The Realm `Results` (used as input)
	///   - predicate: A `NSPredicate` filter with the query parameters.
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	///   - limit: `Int` Limits the number of items returned. Only the top `limit` numbers are included.
	/// - Returns: A Realm `List` collection with data of the requested query.
	class func filterAndSortList(objectResults: Results<Object>?,
								 predicate: NSPredicate,
								 sortAttribute: String, ascending: Bool = true, limit: Int = 0) -> List<Object> {

		if let data = objectResults?.filter(predicate).sorted(byKeyPath: sortAttribute, ascending: ascending) {
			return self.resultsToListConversion(results: data)
		}

		return List()
	}


	//MARK: - Filter --

	/// Retrieves the requested Realm objects and filters them with the input `NSPredicate`.
	/// - Parameters:
	///   - rObject: The Realm object.
	///   - predicate: A `NSPredicate` filter with the query parameters.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func filter(rObject: Object.Type, predicate: NSPredicate) -> Results<Object>? {
		return RealmOperation.get(rObject: rObject).filter(predicate)
	}

	/// Filters the input Realm `Results` with a given `NSPredicate`.
	/// - Note:
	/// Does not query the database. Uses `objectResults` instead.
	/// - Parameters:
	///   - objectResults: The Realm `Results` (used as input)
	///   - predicate: A `NSPredicate` filter with the query parameters.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func filter(objectResults: Results<Object>?, predicate: NSPredicate) -> Results<Object>? {
		return objectResults?.filter(predicate)
	}

	/// Filters the input Realm `List` with a given `NSPredicate`.
	/// - Note:
	/// Does not query the database. Uses `objectList` instead.
	/// - Parameters:
	///   - objectList: The Realm `List` (used as input)
	///   - predicate: A `NSPredicate` filter with the query parameters.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func filter(objectList: List<Object>?, predicate: NSPredicate) -> Results<Object>? {
		return objectList?.filter(predicate)
	}


	//MARK: - Sort --

	/// Retrieves the requested Realm objects and sorts them by the input attributes.
	/// - Parameters:
	///   - rObject: The Realm object.
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func sort(rObject: Object.Type, sortAttribute: String, ascending: Bool = true) -> Results<Object>? {
		return RealmOperation.get(rObject: rObject).sorted(byKeyPath: sortAttribute, ascending: ascending)
	}

	/// Sorts the input Realm `Results` by the input attributes.
	/// - Note:
	/// Does not query the database. Uses `objectResults` instead.
	/// - Parameters:
	///   - objectResults: The Realm `Results` (used as input)
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func sort(objectResults: Results<Object>, sortAttribute: String, ascending: Bool = true) -> Results<Object> {
		return objectResults.sorted(byKeyPath: sortAttribute, ascending: ascending)
	}

	/// Sorts the input Realm `List` by the input attributes.
	/// - Note:
	/// Does not query the database. Uses `objectList` instead.
	/// - Parameters:
	///   - objectList: The Realm `List` (used as input)
	///   - sortAttribute: `String` The attribute name to be used for sorting the data.
	///   - ascending: `Boolean` The sort type: `true` for Ascending, `false` for Descending. Default is true.
	/// - Returns: A Realm `Results` collection with data of the requested query.
	class func sort(objectList: List<Object>, sortAttribute: String, ascending: Bool = true) -> Results<Object> {
		return objectList.sorted(byKeyPath: sortAttribute, ascending: ascending)
	}


	//MARK: - Limit --

	/// Limits a given Array to the (input) number of desired objects.
	/// - Parameters:
	///   - objectArray: An `Array`of objects (used as input).
	///   - limit: `Int` Limits the number of items returned. Only the top `limit` numbers are included.
	/// - Returns: A subarray with the top objects.
	class func limitTopObjects(objectArray: Array<Any>, limit: Int) -> Array<Any> {
		if limit < objectArray.count {
			return (objectArray as NSArray).subarray(with: NSRange(location: 0, length: limit))
		}

		return objectArray
	}


	//MARK: - Utilities --

	/// Converts an input Realm `Results` collection to a Realm `List`.
	class func resultsToListConversion(results: Results<Object>?) -> List<Object> {
		if let data = results {
			if data.count > 0 {
				let newList: List<Object> = List()

				for object in data {
					newList.append(object)
				}
			}
		}

		return List()
	}
}
