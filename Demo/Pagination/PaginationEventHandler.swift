//
//  PaginationEventHandler.swift
//  architecture
//
//  Created by basalaev on 20.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHPagingManager
import HHNetwork

final class PaginationEventHandler: ARCHEventHandler<PaginationState>, PaginationModuleInput, ARCHPagingManagerOutput {

    weak var moduleOutput: PaginationModuleOutput?
    var apiProvider: ApiProvider?

    func performRequest(offset: Int, pageSize: Int, completion: @escaping ARCHPagingManagerCompletion) -> ARCHPagingManagerCancellable? {

        // Индикацию

        let request = apiProvider?.requestTarget(.main, for: MainResponse.self, completion: { [weak self] result in
            switch result {
            case let .success(response):
                self?.beginStateChanges()
                completion(response.objects.count, response.objects.count)
                if offset == 0 {
                    self?.state.list = response.objects
                } else {
                    self?.state.list.append(contentsOf: response.objects)
                }

                // Индикация

                self?.commitStateChanges()
            case let .failure(error):
                print("\(error)")

                // Индикация
            }
        })

        return ARCHPagingManagerRequestWrapper(block: {
            request?.cancel()
        })
    }
}
