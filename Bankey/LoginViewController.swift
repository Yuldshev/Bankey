import UIKit

class LoginViewController: UIViewController {
  let login = LoginView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    style()
    layout()
  }
}

extension LoginViewController {
  private func style() {
    login.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    view.addSubview(login)
    
    NSLayoutConstraint.activate([
      login.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      login.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: login.trailingAnchor, multiplier: 1)
    ])
  }
}
