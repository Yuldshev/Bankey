import UIKit

final class HomeViewController: UIViewController {
  let stackView = UIStackView()
  let label = UILabel()
  let logoutButton = UIButton(type: .system)
  
  weak var delegate: LogoutDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    style()
    layout()
  }
}

extension HomeViewController {
  private func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Hello World"
    label.numberOfLines = 1
    
    logoutButton.translatesAutoresizingMaskIntoConstraints = false
    logoutButton.setTitle("Logout", for: [])
    logoutButton.configuration = .filled()
    logoutButton.addTarget(self, action: #selector(tapPressed), for: .primaryActionTriggered)
  }
  
  private func layout() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(logoutButton)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}

extension HomeViewController {
  @objc func tapPressed(sender: UIButton) {
    delegate?.didLogout()
  }
}
