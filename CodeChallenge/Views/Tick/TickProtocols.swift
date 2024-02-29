//
//  TickProtocols.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

protocol TickViewModelProtocol {
    
    var didTickOnSuccess: ((MLTicks, Bool) -> Void)? { get set }
    var didTickOnError: ((String) -> Void)? { get set }
    var didTickOnComplete: (() -> Void)? { get set }
    
    func startTick(with choice: String)
    func nextTick(with sessionId: Int, choice: String)
    
}

protocol TickInteractorProtocol {
    
    func startTick(with choice: String,
                   completion: @escaping (Result<MLTicks, Error>) -> Void)
    
    func nextTick(with sessionId: Int,
                  choice: String,
                  completion: @escaping (Result<MLTicks, Error>) -> Void)
    
}
