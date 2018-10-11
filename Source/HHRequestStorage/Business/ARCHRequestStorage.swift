//
//  ARCHRequestStorage.swift
//  HHNetwork
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import CoreData
import HHModule
import Moya
import enum Result.Result

public protocol ARCHRequestStorageProtocol {

    func log(request: URLRequest)

    func log(result: Result<Response, MoyaError>)

    func presentRequests(from viewController: UIViewController)
}

private final class PersistentContainer: NSPersistentContainer { }

public class ARCHRequestStorage {

    // MARK: - Singleton

    static public let shared = ARCHRequestStorage()

    private init() {}

    // MARK: - Core Data

    static public var persistentContainer: NSPersistentContainer {
        return ARCHRequestStorage.shared.persistentContainer
    }

    static public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = PersistentContainer(name: "ARCHRequestStorage")
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

extension ARCHRequestStorage: ARCHRequestStorageProtocol {

    public func log(request: URLRequest) {
        let model = ARCHStorageRequest(context: persistentContainer.viewContext)
        model.path = request.url?.absoluteString
        model.desc = request.description
        model.method = request.httpMethod
        model.headers = request.allHTTPHeaderFields?.description
        model.body = String(data: request.httpBody ?? Data(), encoding: .utf8)
        model.createdAt = Date()

        saveContext()
    }

    public func log(result: Result<Response, MoyaError>) {
    }

    public func presentRequests(from viewController: UIViewController) {
        guard let vc = ARCHRequestStorageConfigurator(moduleIO: nil).router as? UIViewController else {
            return
        }

        viewController.present(vc, animated: true, completion: nil)
    }
}
