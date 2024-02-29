//
//  TickClient.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import Foundation

class TickClient: APIClient, TickClientProtocol {
    
    let session: URLSession

    // MARK: - Initializers

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        self.init(configuration: configuration)
    }
    
    // MARK: - Start Tick
    
    func startTick(with choice: String,
                   completion: @escaping (Result<DLTick?, APIError>) -> Void) {
        let request = TickProvider.startTick(choice: choice).request
        
        fetch(with: request,
              decode: { json -> DLTick? in
            
            guard let tickResult = json as? DLTick else { return nil }
            return tickResult
            
        }, completion: completion)
    }
    
    // MARK: - Next Tick
    
    func nextTick(with sessionId: Int,
                  choice: String,
                  completion: @escaping (Result<DLTick?, APIError>) -> Void) {
        let request = TickProvider.nextTick(sessionId: sessionId,
                                            choice: choice).request
        
        fetch(with: request,
              decode: { json -> DLTick? in
            
            guard let tickResult = json as? DLTick else { return nil }
            return tickResult
            
        }, completion: completion)
    }
    
}
