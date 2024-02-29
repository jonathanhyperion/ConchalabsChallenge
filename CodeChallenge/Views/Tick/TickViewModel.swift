//
//  TickViewModel.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

final class TickViewModel: TickViewModelProtocol {
    
    // MARK: - Properties
    
    private let interactor: TickInteractorProtocol
    
    var didTickOnSuccess: ((MLTicks, Bool) -> Void)?
    var didTickOnError: ((String) -> Void)?
    var didTickOnComplete: (() -> Void)?
    
    // MARK: - Initializers
    
    init(interactor: TickInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: - TickViewModelProtocol
    
    func startTick(with choice: String) {
        interactor.startTick(with: choice,
                             completion: { result in
            switch result {
            case .success(let ticks):
                self.didTickOnSuccess?(ticks, true)
                
            case .failure(let error):
                self.didTickOnError?(error.localizedDescription)
            }
        })
    }
    
    func nextTick(with sessionId: Int, choice: String) {
        interactor.nextTick(with: sessionId,
                            choice: choice,
                            completion: { result in
            switch result {
            case .success(let ticks):
                if ticks.errorMessage.isEmpty {
                    if !ticks.complete.isEmpty {
                        self.didTickOnComplete?()
                    } else {
                        self.didTickOnSuccess?(ticks, false)
                    }
                } else {
                    self.didTickOnError?(ticks.errorMessage)
                }
                
            case .failure(let error):
                self.didTickOnError?(error.localizedDescription)
            }
        })
    }
    
}
