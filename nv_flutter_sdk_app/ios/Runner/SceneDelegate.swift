import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {

    override func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        NotifyvisitorsPlugin.scene(scene, willConnectTo: session, options: connectionOptions)
    }
    
    override func sceneDidBecomeActive(_ scene: UIScene) {
        NotifyvisitorsPlugin.sceneDidBecomeActive(scene)
    }
    
    override func sceneWillEnterForeground(_ scene: UIScene) {
        NotifyvisitorsPlugin.sceneWillEnterForeground(scene)
    }
    
    override func sceneDidEnterBackground(_ scene: UIScene) {
        NotifyvisitorsPlugin.sceneDidEnterBackground(scene)
    }
    
    override func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        NotifyvisitorsPlugin.scene(scene, openURLContexts: URLContexts)
    }
}
