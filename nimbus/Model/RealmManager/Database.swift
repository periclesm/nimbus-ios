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

class Database: NSObject {

	static var shared = Database()

	var mainDB: Realm? 

	override init() {
		super.init()
		self.mainDB = self.initMainDB()
	}

	func initMainDB() -> Realm? {
		let schemaVer: UInt64 = 0

		let config = Realm.Configuration (
			fileURL: self.dbFile(name: "cloudDB.realm"),
			readOnly: false,
			schemaVersion: schemaVer,
			migrationBlock: { (migration, oldSchema) in
				self.migrateDB(oldSchema: oldSchema, newSchema: schemaVer, migrationProcess: migration)
			},
			deleteRealmIfMigrationNeeded: false,
			shouldCompactOnLaunch: { (totalBytes, usedBytes) -> Bool in
				return (Double(usedBytes) / Double(totalBytes)) < 0.75 },
			objectTypes: [CloudType.self, CloudLists.self, CloudDetail.self])

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
		let dbDir = path.appendingPathComponent("db")
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

	//MARK: - Migration

	private func migrateDB(oldSchema: UInt64, newSchema: UInt64, migrationProcess: Migration) {
		if (oldSchema < newSchema) {
			//perform migration
			//migrationProcess.create(<#T##typeName: String##String#>)
			//migrationProcess.delete(<#T##object: MigrationObject##MigrationObject#>)
			//migrationProcess.deleteData(forType: <#T##String#>)
			//migrationProcess.renameProperty(onType: <#T##String#>, from: <#T##String#>, to: <#T##String#>)
		}
	}

}
