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

        let request = apiProvider?.sendRequest(
            target: .main,
            for: MainResponse.self,
            completion: { [weak self] response in
                self?.beginStateChanges()
                completion(response.objects.count, response.objects.count)
                if offset == 0 {
                    self?.state.list = response.objects
                } else {
                    self?.state.list.append(contentsOf: response.objects)
                }

                // Индикация

                self?.commitStateChanges()
            },
            failure: { error in
                print("\(error)")
                // Индикация
            }
        )

        return ARCHPagingManagerRequestWrapper(block: {
            request?.cancel()
        })
    }
}
