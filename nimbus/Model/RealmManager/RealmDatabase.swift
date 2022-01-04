//
//  Database.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

/**
 This class manages the Realm DB instance.
 Initializes the `Realm` instance at allocation with the predefined options set in `initDB` function at the location set in `dbPath` function.
 Also, it makes sure the db instance always run in the shared instance allocation space and re-initializes it if it's deallocated.
 */
class RealmDatabase: NSObject {
	
	static var shared = RealmDatabase()
	private let schemaVer: UInt64 = 0
	private let dbFileName: String = "cloudDB.realm"
	private var mainDB: Realm?
	
	var db: Realm {
		set(newSchema) {
			self.mainDB = newSchema
		}
		
		get {
			if self.mainDB == nil {
				self.mainDB = self.initDB()
			}
			
			return self.mainDB!
		}
	}
	
	override init() {
		super.init()
		self.mainDB = self.initDB()
	}
	
	///Initializes the database instance to be used in the app
	private func initDB() -> Realm? {
		let config = Realm.Configuration (
			fileURL: self.dbPath(),
			readOnly: false,
			schemaVersion: schemaVer,
			deleteRealmIfMigrationNeeded: true)
		
		var db: Realm? = nil
		
		do {
			db = try Realm(configuration: config)
		} catch let error as NSError {
			debugPrint("Error initializing Database: \(error.localizedDescription)")
		}
		
		return db
	}
	
	///Created the default local path to store the database files.
	private func dbPath() -> URL {
		let localPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!)
		let localDir = localPath.appendingPathComponent("realm")
		let file = localDir.appendingPathComponent(self.dbFileName)
		
		if !FileManager.default.fileExists(atPath: localDir.absoluteString) {
			do {
				try FileManager.default.createDirectory(at: localDir, withIntermediateDirectories: true, attributes: nil)
			} catch let error as NSError {
				debugPrint("Cannot create directory: \(error.localizedDescription)")
			}
		}
		
		return file
	}
}
