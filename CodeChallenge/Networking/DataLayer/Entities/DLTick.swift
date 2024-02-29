//
//  DLTick.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

import Foundation

struct DLTick: Decodable {
    
    // This is not the best practice for JSON decimal values
    // needs to be received like a String
    let ticks: [Double]?
    let sessionId: Int
    let stepCount: Int?
    let complete: String?
    let errorMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case ticks
        case sessionId = "session_id"
        case stepCount = "step_count"
        case complete
        case errorMessage = "error"
    }
    
    // MARK: - Initializers
    
    public init(ticks: [Double],
                sessionId: Int,
                stepCount: Int,
                complete: String,
                errorMessage: String) {
        self.ticks = ticks
        self.sessionId = sessionId
        self.stepCount = stepCount
        self.complete = complete
        self.errorMessage = errorMessage
    }
    
}

extension DLTick: ModelConvertible {
    
    func asModel() -> MLTicks {
        return MLTicks(ticks: ticks ?? [Double](),
                       sessionId: sessionId,
                       stepCount: stepCount ?? 0,
                       complete: complete ?? "",
                       errorMessage: errorMessage ?? "")
    }
    
}
