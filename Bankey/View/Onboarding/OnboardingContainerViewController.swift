import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
  func onboardingDidFinish()
}

class OnboardingContainerViewController: UIViewController {
  
  let pageViewController: UIPageViewController
  var pages = [UIViewController]()
  weak var delegate: OnboardingContainerViewControllerDelegate?
  
  var currentVC: UIViewController {
    didSet {
      guard let index = pages.firstIndex(of: currentVC) else { return }
      nextButton.isHidden = index == pages.count - 1
      backButton.isHidden = index == 0
      doneButton.isHidden = !(index == pages.count - 1)
    }
  }
  
  let closeButton = UIButton(type: .system)
  let nextButton = UIButton(type: .system)
  let backButton = UIButton(type: .system)
  let doneButton = UIButton(type: .system)
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let page1 = OnboardingViewController(imageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s.")
    let page2 = OnboardingViewController(imageName: "world", titleText: "Move your money around the world quickly and securely.")
    let page3 = OnboardingViewController(imageName: "thumbs", titleText: "Learn more at www.bankey.com")
    
    pages.append(page1)
    pages.append(page2)
    pages.append(page3)
    
    currentVC = pages.first!
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    style()
    layout()
  }
  
  private func setup() {
    view.backgroundColor = .systemPurple
    
    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.didMove(toParent: self)
    
    pageViewController.dataSource = self
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
      view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
      view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
    ])
    
    pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
    currentVC = pages.first!
  }
  
  private func style() {
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.setTitle("Close", for: [])
    closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
    
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.setTitle("Next", for: [])
    nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
    
    backButton.translatesAutoresizingMaskIntoConstraints = false
    backButton.setTitle("Back", for: [])
    backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
    
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    doneButton.setTitle("Done", for: [])
    doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
    view.addSubview(closeButton)
    view.addSubview(nextButton)
    view.addSubview(backButton)
    view.addSubview(doneButton)
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
      
      view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 40),
      nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
      
      view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
      backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
      
      view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 40),
      doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
    ])
  }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    return getPreviousViewController(from: viewController)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    return getNextViewController(from: viewController)
  }
  
  private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
    currentVC = pages[index - 1]
    return pages[index - 1]
  }
  
  private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
    currentVC = pages[index + 1]
    return pages[index + 1]
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return pages.firstIndex(of: self.currentVC) ?? 0
  }
}

//MARK: - Action
extension OnboardingContainerViewController {
  @objc func closeTapped(_ sender: UIButton) {
    delegate?.onboardingDidFinish()
  }
  
  @objc func nextTapped(_ sender: UIButton) {
    guard let nextVC = getNextViewController(from: currentVC) else { return }
    pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
  }
  
  @objc func backTapped(_ sender: UIButton) {
    guard let backVC = getPreviousViewController(from: currentVC) else { return }
    pageViewController.setViewControllers([backVC], direction: .reverse, animated: true)
  }
  
  @objc func doneTapped(_ sender: UIButton) {
    delegate?.onboardingDidFinish()
  }
}
