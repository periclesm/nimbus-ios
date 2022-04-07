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

final class Database: NSObject {

	static var shared = Database()
	private var mainDB: Realm?

	var db: Realm {
		set(newSchema) {
			self.mainDB = newSchema
		}

		get {
			if self.mainDB != nil {
				return self.mainDB!
			}
			else {
				self.mainDB = self.initMainDB()
				return self.mainDB!
			}
		}
	}

	override init() {
		super.init()
		self.mainDB = self.initMainDB()
	}

	private func initMainDB() -> Realm? {
		let schemaVer: UInt64 = 0

		let config = Realm.Configuration (
			fileURL: self.dbFile(name: "cloudDB.realm"),
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

	private func dbFile(name: String) -> URL {
		let path = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!)
		let dbDir = path.appendingPathComponent("realm")
		let file = dbDir.appendingPathComponent(name)

		if !FileManager.default.fileExists(atPath: dbDir.absoluteString) {
			do {
				try FileManager.default.createDirectory(at: dbDir, withIntermediateDirectories: true, attributes: nil)
			} catch let error as NSError {
				debugPrint("Cannot create directory: \(error.localizedDescription)")
			}
		}

		return file
	}
}
