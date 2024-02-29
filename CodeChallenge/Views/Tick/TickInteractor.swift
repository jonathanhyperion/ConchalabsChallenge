//
//  TickInteractor.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import Foundation

class TickInteractor: TickInteractorProtocol {
    
    private let tickUseCase: MLTickUseCaseProtocol
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol) {
        self.tickUseCase = useCaseProvider.tickUseCase()
    }
    
    // MARK: - TickInteractorProtocol
    
    func startTick(with choice: String,
                   completion: @escaping (Result<MLTicks, Error>) -> Void) {
        
        tickUseCase.startTick(with: choice,
                              completion: completion)
    }
    
    func nextTick(with sessionId: Int,
                  choice: String,
                  completion: @escaping (Result<MLTicks, Error>) -> Void) {
        
        tickUseCase.nextTick(with: sessionId,
                             choice: choice,
                             completion: completion)
    }
    
}
