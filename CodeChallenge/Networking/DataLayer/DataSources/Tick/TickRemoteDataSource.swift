//
//  TickRemoteDataSource.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

final class TickRemoteDataSource: RLTickRemoteDataSourceProtocol {
    
    // MARK: - Properties
    
    private let client: TickClientProtocol
    
    // MARK: - Initializers
    
    init(client: TickClientProtocol) {
        self.client = client
    }
    
    // MARK: - Client Start Tick
    
    func startTick(with choice: String,
                   completion: @escaping (Result<MLTicks, Error>) -> Void) {
        client.startTick(with: choice,
                         completion: { result in
            switch result {
            case .success(let tickResult):
                guard let tick_result = tickResult else { return }
                
                let result = tick_result.asModel()
                completion(.success(result))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Client Next Tick
    
    func nextTick(with sessionId: Int,
                  choice: String,
                  completion: @escaping (Result<MLTicks, Error>) -> Void) {
        client.nextTick(with: sessionId,
                        choice: choice,
                        completion: { result in
            switch result {
            case .success(let tickResult):
                guard let tick_result = tickResult else { return }
                
                let result = tick_result.asModel()
                completion(.success(result))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
