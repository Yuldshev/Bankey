import UIKit

final class OnboardingViewController: UIViewController {
  let stackView = UIStackView()
  let label = UILabel()
  let image = UIImageView()
  var imageName: String
  var titleText: String
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    style()
    layout()
  }
  
  init(imageName: String, titleText: String) {
    self.imageName = imageName
    self.titleText = titleText
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension OnboardingViewController {
  private func style() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.text = titleText
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontSizeToFitWidth = true
    label.numberOfLines = 0
    
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFit
    image.image = UIImage(named: imageName)
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
