//
//  ARCHRequestStorage.swift
//  HHNetwork
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import CoreData

public protocol ARCHRequestStorageProtocol {

    func getRequests() -> [Any]

    func addRequest()

    func setResponse()

    func presentRequests(from viewController: UIViewController)
}

public class ARCHRequestStorage {

    // MARK: - Singleton

    static public let shared = ARCHRequestStorage()

    private init() {}

    // MARK: - Public

    public func presentRequests(from viewController: UIViewController) {
        guard let vc = ARCHRequestStorageConfigurator(moduleIO: nil).router as? UIViewController else {
            return
        }

        viewController.present(vc, animated: true, completion: nil)
    }

    // MARK: - Core Data

    static public var persistentContainer: NSPersistentContainer {
        return ARCHRequestStorage.shared.persistentContainer
    }

    static public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ARCHRequestStorage")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
