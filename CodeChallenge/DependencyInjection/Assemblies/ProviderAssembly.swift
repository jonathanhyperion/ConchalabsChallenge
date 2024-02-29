//
//  ProviderAssembly.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import Foundation
import Swinject

final class ProviderAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(UseCaseProviderProtocol.self) { resolver in
            RLUseCaseProvider(remoteDataSource: resolver.resolve(RLRemoteDataSourceProtocol.self)!)
        }
        
    }
    
}
