import UIKit

final class OnboardingViewController: UIViewController {
  let stackView = UIStackView()
  let label = UILabel()
  let image = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    style()
    layout()
  }
}

extension OnboardingViewController {
  private func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.text = "Bankey is faster, easier to use, and has a brand new look and feel that will make you feal like you are back in 1989."
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 0
    
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    image.image = UIImage(resource: .delorean)
  }
  
  private func layout() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(image)
    stackView.addArrangedSubview(label)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
      stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
    ])
  }
}
