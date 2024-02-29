//
//  RLUseCaseProvider.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

public class RLUseCaseProvider: UseCaseProviderProtocol {
    
    // MARK: - Properties
    
    private let remoteDataSource: RLRemoteDataSourceProtocol
    
    // MARK: - Initializers
    
    public init(remoteDataSource: RLRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Use Cases
    
    public func tickUseCase() -> MLTickUseCaseProtocol {
        let remoteDataSource = self.remoteDataSource.tickDataSource()
        return RLTickRepository(remoteDataSource: remoteDataSource)
    }
    
}
