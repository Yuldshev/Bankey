import UIKit

class LoginView: UIView {
  let username = UITextField()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 200)
  }
}

extension LoginView {
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .orange
    
    username.translatesAutoresizingMaskIntoConstraints = false
    username.placeholder = "Username"
    username.delegate = self
  }
  
  func layout() {
    addSubview(username)
    
    NSLayoutConstraint.activate([
      username.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
      username.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
      trailingAnchor.constraint(equalToSystemSpacingAfter: username.trailingAnchor, multiplier: 1)
    ])
  }
}

//MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return !(textField.text?.isEmpty ?? true)
  }
}
