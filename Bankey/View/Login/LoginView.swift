import UIKit

class LoginView: UIView {
  let usernameTextField = UITextField()
  let passwordTextField = UITextField()
  private let stackView = UIStackView()
  private let divider = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoginView {
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .secondarySystemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 8
    
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.placeholder = "Username"
    usernameTextField.delegate = self
    
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    passwordTextField.delegate = self
    
    divider.translatesAutoresizingMaskIntoConstraints = false
    divider.backgroundColor = .secondarySystemFill
    
    layer.cornerRadius = 8
    clipsToBounds = true
  }
  
  func layout() {
    addSubview(stackView)
    stackView.addArrangedSubview(usernameTextField)
    stackView.addArrangedSubview(divider)
    stackView.addArrangedSubview(passwordTextField)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
      
      divider.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
}

//MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    usernameTextField.endEditing(true)
    passwordTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true
  }
}
