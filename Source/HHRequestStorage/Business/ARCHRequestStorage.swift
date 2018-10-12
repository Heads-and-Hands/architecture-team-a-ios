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

    var requests: [ARCHStorageRequest] { get }

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

    // MARK: - Temporaty container

    private var temporaryStorage: [String: URLRequest] = [:]
}

extension ARCHRequestStorage: ARCHRequestStorageProtocol {

    public var requests: [ARCHStorageRequest] {
        let requst: NSFetchRequest<ARCHStorageRequest> = ARCHStorageRequest.fetchRequest()
        return (try? persistentContainer.viewContext.fetch(requst)) ?? []
    }

    public func log(request: URLRequest) {

        let tempID = UUID().uuidString

        let model = ARCHStorageRequest(context: persistentContainer.viewContext)
        model.path = request.url?.absoluteString
        model.desc = request.description
        model.method = request.httpMethod
        model.headers = request.allHTTPHeaderFields?.description
        model.body = String(data: request.httpBody ?? Data(), encoding: .utf8)
        model.createdAt = Date()
        model.tempID = tempID

        temporaryStorage[tempID] = request

        saveContext()
    }

    public func log(result: Result<Response, MoyaError>) {
        guard let request = result.value?.request,
            let tempID = temporaryStorage.first(where: { row in
                let (_, value) = row
                return value == request })?.key,
            let requestModel = requests.first(where: {
                ($0.tempID ?? "") == tempID }) else {
                    return
        }

        requestModel.tempID = nil

        let responseModel = ARCHStorageResponse(context: persistentContainer.viewContext)

        switch  result {
        case let .success(response):
            responseModel.statusCode = Int16(response.statusCode)
            responseModel.headers = response.response?.allHeaderFields.debugDescription
            responseModel.body = String(data: response.data, encoding: .utf8)
        case let .failure(error):
            responseModel.error = error.errorDescription
        }

        requestModel.response = responseModel

        saveContext()
    }

    public func presentRequests(from viewController: UIViewController) {
        guard let vc = ARCHRequestStorageConfigurator(moduleIO: nil, storage: self).router as? UIViewController else {
            return
        }

        viewController.present(vc, animated: true, completion: nil)
    }
}
