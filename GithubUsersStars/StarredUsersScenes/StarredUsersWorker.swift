//
//  StarredUsersWorker.swift
//  GithubUsersStars
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

class StarredUsersWorker {
    
    func getUsers(page:Int, onComplete:@escaping(Result) -> Void, onError:@escaping(Error) -> Void) {
        
        API.getUsers(page: page, onComplete: { (result) in
            onComplete(result)
        }) { (error) in
            onError(error)
        }
    }
}
