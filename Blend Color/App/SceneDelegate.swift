//
//  SceneDelegate.swift
//  Blend Color
//
//  Created by Надежда Капацина on 20.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootController = ColorMixingViewController()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}

