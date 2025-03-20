import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  let loginViewController = LoginViewController()
  let onboardingContainerViewController = OnboardingContainerViewController()
  let homeViewController = HomeViewController()
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: scene)
    
    loginViewController.delegate = self
    onboardingContainerViewController.delegate = self
    homeViewController.delegate = self
    
    self.window?.rootViewController = loginViewController
    self.window?.makeKeyAndVisible()
  }
}

extension SceneDelegate: LoginViewControllerDelegate {
  func didLogin() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
      setRootViewController(onboardingContainerViewController)
    }
  }
}

extension SceneDelegate: OnboardingContainerViewControllerDelegate {
  func onboardingDidFinish() {
    setRootViewController(homeViewController)
  }
}

extension SceneDelegate: LogoutDelegate {
  func didLogout() {
    setRootViewController(loginViewController)
  }
}

extension SceneDelegate {
  func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = vc
      self.window?.makeKeyAndVisible()
      return
    }
    
    window.rootViewController = vc
    window.makeKeyAndVisible()
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
  }
}
