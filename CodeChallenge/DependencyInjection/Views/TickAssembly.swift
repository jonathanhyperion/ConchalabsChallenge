//
//  TickAssembly.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import Foundation
import Swinject

final class TickAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(TickInteractorProtocol.self) { resolver in
            let useCaseProvider = container.resolve(UseCaseProviderProtocol.self)
            return TickInteractor(useCaseProvider: useCaseProvider!)
        }
        
        container.register(TickViewModelProtocol.self) { resolver in
            let interactor = resolver.resolve(TickInteractorProtocol.self)
            return TickViewModel(interactor: interactor!)
        }
        
    }
    
}
