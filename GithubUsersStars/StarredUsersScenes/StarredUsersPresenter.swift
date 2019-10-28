//
//  StarredUsersPresenter.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol StarredUsersPresenterProtocol {
    func showUsers(result: Result)
    func showError()
    func toggleLoading(_ bool:Bool)
}

class StarredUsersPresenter: StarredUsersPresenterProtocol {
    
    var starredUsersPresenterDelegate: StarredUsersViewControllerProtocol?
    
    func showUsers(result: Result) {
        starredUsersPresenterDelegate?.showUsers(result: result)
    }
    
    func showError() {
        toggleLoading(false)
        starredUsersPresenterDelegate?.showError()
    }
    
    func toggleLoading(_ bool: Bool) {
        starredUsersPresenterDelegate?.toggleLoading(bool)
    }
}

