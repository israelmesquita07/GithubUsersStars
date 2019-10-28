//
//  StarredUsersInteractor.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol StarredUsersInteractorProtocol {
    func getUsers()
}

class StarredUsersInteractor: StarredUsersInteractorProtocol {
    
    var starredUsersInteractorDelegate: StarredUsersPresenterProtocol?
    private var worker: StarredUsersWorker?
    
    func getUsers() {
     
        starredUsersInteractorDelegate?.toggleLoading(true)
        worker = StarredUsersWorker()
        worker?.getUsers(onComplete: { [weak self] (result) in
            guard let self = self else { return }
            guard let users = result.items else {
                self.starredUsersInteractorDelegate?.showError()
                return
            }
            self.starredUsersInteractorDelegate?.showUsers(users: users)
        }, onError: { (error) in
            self.starredUsersInteractorDelegate?.showError()
        })
        worker = nil
    }
}
