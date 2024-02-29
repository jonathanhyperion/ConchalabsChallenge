//
//  RLTickRemoteDataSourceProtocol.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

public protocol RLTickRemoteDataSourceProtocol {
    
    func startTick(with choice: String,
                   completion: @escaping (Result<MLTicks, Error>) -> Void)
    
    func nextTick(with sessionId: Int,
                  choice: String,
                  completion: @escaping (Result<MLTicks, Error>) -> Void)
    
}
