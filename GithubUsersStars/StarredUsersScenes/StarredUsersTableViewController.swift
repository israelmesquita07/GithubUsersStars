//
//  StarredUsersTableViewController.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

protocol StarredUsersViewControllerProtocol {
    func getUsers()
    func showUsers(users: [User]?)
    func showError()
    func toggleLoading(_ bool:Bool)
}

class StarredUsersTableViewController: UITableViewController, StarredUsersViewControllerProtocol {
    
    private let cellId = "cellId"
    private var presenter:StarredUsersPresenter = StarredUsersPresenter()
    private var interactor:StarredUsersInteractor = StarredUsersInteractor()
    private var usersArray:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    func getUsers() {
        presenter.starredUsersPresenterDelegate = self
        interactor.starredUsersInteractorDelegate = presenter
        interactor.getUsers()
    }
    
    func showUsers(users: [User]?) {
        guard let users = users else { return }
        usersArray = users
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.toggleLoading(false)
        }
    }
    
    func showError() {
        showAlert(title: "Ops!", message: "Ocorreu um erro!")
    }
    
    func toggleLoading(_ bool: Bool) {
        if bool {
//            loadingView.isHidden = false
//            activityIndicator.startAnimating()
            return
        }
    }
    
    private func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - Table view data source - delegate
extension StarredUsersTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: cellId)
        
        let user = usersArray[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "\(user.owner?.login ?? "Username")(\(user.stargazers_count ?? 0) estrelas)"
        cell.imageView?.imageFromServerURL(urlString: user.owner?.avatarUrl ?? "", defaultImage: "githubImage")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
