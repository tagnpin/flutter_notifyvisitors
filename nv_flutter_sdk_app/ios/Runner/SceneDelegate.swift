import Flutter
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//class SceneDelegate: FlutterSceneDelegate {
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        NotifyvisitorsPlugin.scene(
            scene,
            willConnectTo: session,
            options: connectionOptions
        )
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        NotifyvisitorsPlugin.sceneDidBecomeActive(scene)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        NotifyvisitorsPlugin.sceneWillEnterForeground(scene)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NotifyvisitorsPlugin.sceneDidEnterBackground(scene)
    }
    
    func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    ) {
        NotifyvisitorsPlugin.scene(
            scene,
            openURLContexts: URLContexts
        )
    }
    
}
