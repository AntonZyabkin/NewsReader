//
//  MainCoordinator.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 25.04.2023.
//

import Foundation
import UIKit
import XCoordinator

enum MainRoute: Route {
    case auth
    case ads
    case error(Error)
}


final class MainCoordinator: NavigationCoordinator<MainRoute> {
    private let dependencyContainer: DependencyContainer
    
    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
        super.init(initialRoute: .ads)
    }
    
    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .auth:
            let alert = UIAlertController(title: "Need authorization", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
            
            return .present(alert)
            
        case .ads:
            do {
                let coordinator = AdsCoordinator(rootViewController: rootViewController, service: try dependencyContainer.getAdsService())
                
                addChild(coordinator)
                return .trigger(.list, on: coordinator)
            } catch  {
                return .trigger(.error(error), on: self)
            }
            
        case .error(let error):
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            
            alert.addAction(.init(title: "Ok", style: .default, handler: { _ in }))
            return .present(alert)
        }
    }
}
