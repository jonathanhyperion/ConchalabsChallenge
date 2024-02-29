//
//  RemoteDataSource.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

final public class RemoteDataSource: RLRemoteDataSourceProtocol {
    
    public init() { }
    
    public func tickDataSource() -> RLTickRemoteDataSourceProtocol {
        let client = TickClient()
        return TickRemoteDataSource(client: client)
    }
    
}
