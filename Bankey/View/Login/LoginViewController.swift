import UIKit

protocol LoginViewControllerDelegate: AnyObject {
  func didLogin()
}

protocol LogoutDelegate: AnyObject {
  func didLogout()
}

class LoginViewController: UIViewController {
  let login = LoginView()
  private let button = UIButton(type: .system)
  private let errorMessage = UILabel()
  private let header = UILabel()
  private let subheader = UILabel()
  
  weak var delegate: LoginViewControllerDelegate?
  
  var username: String? {
    return login.usernameTextField.text
  }
  var password: String? {
    return login.passwordTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    style()
    layout()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    button.configuration?.showsActivityIndicator = false
    login.usernameTextField.text = ""
    login.passwordTextField.text = ""
  }
}

extension LoginViewController {
  private func style() {
    header.translatesAutoresizingMaskIntoConstraints = false
    header.text = "Bankey"
    header.textAlignment = .center
    header.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize, weight: .bold)
    header.adjustsFontForContentSizeCategory = true
    
    subheader.translatesAutoresizingMaskIntoConstraints = false
    subheader.text = "Your premium source for all things banking!"
    subheader.textAlignment = .center
    subheader.numberOfLines = 0
    subheader.font = UIFont.preferredFont(forTextStyle: .title3)
    subheader.adjustsFontForContentSizeCategory = true
    
    login.translatesAutoresizingMaskIntoConstraints = false
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.configuration = .filled()
    button.configuration?.imagePadding = 8
    button.setTitle("Sign in", for: [])
    button.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
    
    errorMessage.translatesAutoresizingMaskIntoConstraints = false
    errorMessage.numberOfLines = 0
    errorMessage.textAlignment = .center
    errorMessage.textColor = .systemRed
  }
  
  private func layout() {
    view.addSubview(header)
    view.addSubview(subheader)
    view.addSubview(login)
    view.addSubview(button)
    view.addSubview(errorMessage)
    
    NSLayoutConstraint.activate([
      login.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      login.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
      login.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
      
      subheader.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
      header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      login.topAnchor.constraint(equalTo: subheader.bottomAnchor, constant: 20),
      subheader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
      subheader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
      
      login.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
      button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
      button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
      
      button.bottomAnchor.constraint(equalTo: errorMessage.topAnchor, constant: -20),
      errorMessage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
      errorMessage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
    ])
  }
}

extension LoginViewController {
  @objc func signInTapped() {
    errorMessage.isHidden = true
    signError()
  }
  
  private func signError() {
    guard let username = username, let password = password else { return }
    
    if username.isEmpty || password.isEmpty {
      configureView(withMessage: "Username / password cannot be blank")
      return
    }
    
    if username.lowercased() == "admin" && password.lowercased() == "admin" {
      button.configuration?.showsActivityIndicator = true
      delegate?.didLogin()
    } else {
      configureView(withMessage: "Invalid username / password")
    }
  }
  
  private func configureView(withMessage message: String) {
    errorMessage.isHidden = false
    errorMessage.text = message
  }
}
