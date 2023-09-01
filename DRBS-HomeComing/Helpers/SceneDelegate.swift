import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            FirebaseApp.configure()  ///Firebase 구동

            let window = UIWindow(windowScene: windowScene)
            let vc1 = HomeVC()
            let vc2 = MapVC()
            vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
            vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
            let nav1 = UINavigationController(rootViewController: vc1)
            let nav2 = UINavigationController(rootViewController: vc2)
            vc1.tabBarItem.title = "홈"
            vc2.tabBarItem.title = "지도"
            nav1.setupHomeBarAppearance()
            nav2.setupMapBarAppearance()
            let tabbar = Tabbar()
            DispatchQueue.global().async {
                NetworkingManager.shared.fetchHouses { houses in
                    vc1.homeVChouses = houses
                    vc2.locationViewModel.houses = houses
                    DispatchQueue.main.async {
                        tabbar.viewControllers = [nav1, nav2]
                        window.rootViewController = tabbar // 자신의 시작 ViewController
                        window.makeKeyAndVisible()
                        self.window = window
                    }
                }
            }
   
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
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

