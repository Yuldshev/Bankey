import UIKit

import UIKit

final class AccountSummaryViewController: UIViewController {
  let games = [ "Pacman", "Space Invaders", "Asteroids"]
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

extension AccountSummaryViewController {
  func setup() {
    setupTableView()
    setupTableHeaderView()
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      
    ])
  }
  
  private func setupTableHeaderView() {
    let header = AccountSummaryHeaderView(frame: .zero)
    
    var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    size.width = UIScreen.main.bounds.width
    header.frame.size = size
    
    tableView.tableHeaderView = header
  }
}

extension AccountSummaryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = games[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
}

extension AccountSummaryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
