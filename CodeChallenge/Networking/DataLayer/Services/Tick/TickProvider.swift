//
//  TickProvider.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

enum TickProvider {
    
    case startTick(choice: String)
    case nextTick(sessionId: Int, choice: String)
    
}

// MARK: - Endpoint

extension TickProvider: Endpoint {
    
    var base: String {
        return NetworkConfiguration.shared.baseAPIURLString
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .startTick:
            return "/test_start"
        case .nextTick:
            return "/test_next"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .startTick(let choice):
            return [
                "choice": choice
            ]
        case .nextTick(let sessionId, let choice):
            return [
                "session_id": sessionId,
                "choice": choice
            ]
        }
    }
    
    var parameterEncoding: ParameterEnconding {
        switch self {
        case .startTick, .nextTick:
            return .jsonEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .startTick, .nextTick:
            return .post
        }
    }
    
}
