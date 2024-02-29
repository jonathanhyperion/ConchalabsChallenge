//
//  ViewAssembly.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import Foundation
import Swinject

final class ViewAssembly: Assembly {
    
    func assemble(container: Container) {
        let assemblies: [Assembly] = [
            TickAssembly()
        ]
        
        assemblies.forEach { $0.assemble(container: container) }
    }
    
}
