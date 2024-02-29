//
//  DataSourceAssembly.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import Foundation
import Swinject

final class DataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(RLRemoteDataSourceProtocol.self) { _ in
            return RemoteDataSource()
        }
        
    }
    
}
