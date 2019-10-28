//
//  StarredUsersInteractor.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol StarredUsersInteractorProtocol {
    func getUsers(page:Int)
}

class StarredUsersInteractor: StarredUsersInteractorProtocol {
    
    var starredUsersInteractorDelegate: StarredUsersPresenterProtocol?
    private var worker: StarredUsersWorker?
    
    func getUsers(page:Int) {
     
        starredUsersInteractorDelegate?.toggleLoading(true)
        worker = StarredUsersWorker()
        worker?.getUsers(page: page, onComplete: { [weak self] (result) in
            guard let self = self else { return }
            self.starredUsersInteractorDelegate?.showUsers(result: result)
        }, onError: { (error) in
            self.starredUsersInteractorDelegate?.showError()
        })
        worker = nil
    }
}
