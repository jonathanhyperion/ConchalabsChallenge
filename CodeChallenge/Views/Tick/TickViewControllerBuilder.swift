//
//  TickViewControllerBuilder.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import UIKit

final class TickViewControllerBuilder {
    
    class func buildViewController() -> UIViewController {
        let vc = TickViewController(viewModel: DIContainer.shared.resolve())
        
        return vc
    }
    
}
