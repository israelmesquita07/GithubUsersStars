//
//  StarredUsersTableViewController.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

protocol StarredUsersViewControllerProtocol {
    func getUsers(page:Int)
    func showUsers(result: Result?)
    func showError()
    func toggleLoading(_ bool:Bool)
}

class StarredUsersTableViewController: UITableViewController, StarredUsersViewControllerProtocol {
    
    private let cellId = "cellId"
    private var presenter:StarredUsersPresenter = StarredUsersPresenter()
    private var interactor:StarredUsersInteractor = StarredUsersInteractor()
    private var usersArray:[User] = []
    private var activityIndicator = UIActivityIndicatorView()
    private var page = 1, totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers(page: page)
    }
    
    func getUsers(page:Int) {
        toggleLoading(true)
        presenter.starredUsersPresenterDelegate = self
        interactor.starredUsersInteractorDelegate = presenter
        interactor.getUsers(page: page)
    }
    
    func showUsers(result: Result?) {
        guard let users = result?.items else { return }
        guard let totalPagesInResult = result?.totalCount else { return }
        usersArray.append(contentsOf: users)
        totalPages = totalPagesInResult
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
            startLoading()
            return
        }
        stopLoading()
    }
    
    private func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func startLoading() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        view.isUserInteractionEnabled = false
    }
    
    private func stopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
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
        cell.imageView?.imageFromServerURL(urlString: user.owner?.avatarUrl ?? "", defaultImage: "githubImage")
        if let username = user.owner?.login, let countStars = user.stargazers_count {
            cell.detailTextLabel?.text = "\(username) (\(countStars) estrelas)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItem = usersArray.count - 1
        if indexPath.row == lastItem {
            page+=1
            if !(page > totalPages){
                getUsers(page: page)
            }
        }
    }
}
