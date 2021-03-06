//
//  SceneDelegate.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 08.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
 
    var window: UIWindow?
    private var lastViewController: UIViewController?
    private let userNotificationCenter: UserNotificationService = UserNotificationServiceImpl()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let vc = LoginViewController()
        LoginModuleBuilder.configure(with: vc)
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let lastVC = lastViewController else { return }
        window?.rootViewController = lastVC
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let blockVC = BlockViewController()
        lastViewController = window?.rootViewController
        window?.rootViewController = blockVC
        
        sendTestNotification()
    }
}

// MARK: - Notification exapmple
extension SceneDelegate {
    
    private func sendTestNotification() {
        userNotificationCenter.sendNotificatioRequest(
            content: makeNotificationContent(),
            trigger: makeIntervalNotificatioTrigger())
    }
    
    private func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "?????????????? ?? ????????????????????"
        content.subtitle = "?????? ????????????"
        content.body = "?? ????????????"
        content.badge = 1
        
        return content
    }
    
    private func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        UNTimeIntervalNotificationTrigger(
            timeInterval: 10,
            repeats: false
        )
    }
}

