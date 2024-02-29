//
//  RLTickRepository.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

public class RLTickRepository: MLTickUseCaseProtocol {
    
    // MARK: - Properties
    
    private var remoteDataSource: RLTickRemoteDataSourceProtocol
    
    // MARK: - Initializers
    
    init(remoteDataSource: RLTickRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Remote
    
    public func startTick(with choice: String,
                          completion: @escaping (Result<MLTicks, Error>) -> Void) {
        
        remoteDataSource.startTick(with: choice,
                                   completion: completion)
        
    }
    
    public func nextTick(with sessionId: Int,
                         choice: String,
                         completion: @escaping (Result<MLTicks, Error>) -> Void) {
        
        remoteDataSource.nextTick(with: sessionId,
                                  choice: choice,
                                  completion: completion)
        
    }
    
}
