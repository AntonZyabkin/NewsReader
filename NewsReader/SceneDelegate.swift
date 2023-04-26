//
//  SceneDelegate.swift
//  NewsReader
//
//  Created by Anton Zyabkin on 21.04.2023.
//

import UIKit
import XCoordinator



class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let dependencyContainer = DependencyContainer()
    private var rootCoordinator: Presentable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let coordinator = MainCoordinator(
            dependencyContainer: dependencyContainer
        )
        self.rootCoordinator = coordinator
        coordinator.setRoot(for: window)
        self.window = window
        window.makeKeyAndVisible()
    }
}

