//
//  TickClientProtocol.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

protocol TickClientProtocol {
    
    func startTick(with choice: String,
                   completion: @escaping (Result<DLTick?, APIError>) -> Void)
    
    func nextTick(with sessionId: Int,
                  choice: String,
                  completion: @escaping (Result<DLTick?, APIError>) -> Void)
    
}
