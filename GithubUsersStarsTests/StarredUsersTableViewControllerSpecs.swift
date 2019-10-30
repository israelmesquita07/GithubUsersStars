//
//  StarredUsersTableViewControllerSpecs.swift
//  GithubUsersStarsTests
//
//  Created by Israel on 28/10/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import GithubUsersStars

class StarredUsersTableViewControllerSpecs: QuickSpec {
    
    var sut: StarredUsersTableViewController!
    var result:Result!
    
    override func spec() {
        describe("A StarredUsersTableViewController") {
            //Given
            beforeEach {
                self.sut = StarredUsersTableViewController()
            }
            
            afterEach {
                self.sut = nil
            }
            
            //When
            context("default tests") {
                it("a kind of StarredUsersTableViewController") {
                    //Then
                    expect(self.sut).to(beAKindOf(StarredUsersTableViewController.self))
                }
                
                it("to not be nil") {
                    expect(self.sut).toNot(beNil())
                }
            }
            
            context("methods tests") {
                it("showError") {
                    self.sut.showError()
                }
                
                it("stopLoading") {
                    self.sut.toggleLoading(false)
                }
                
                it("load image") {
                    UIImageView().imageFromServerURL(urlString: "https://avatars3.githubusercontent.com/u/7774181?v=4", defaultImage: "iTunesArtwork")
                }
            }
            
            context("test result") {
                beforeEach {
                    self.result = self.getAPIUserData()
                }
                
                it("compare labels") {
                    if let users = self.result.items {
                        let user = users[0]
                        expect(user.name) == "awesome-ios"
                        expect(user.owner?.login) == "vsouza"
                    }
                }
                
                afterEach {
                    self.result = nil
                }
            }
            
            context("snapshots") {
                it("should match StarredUsersTableViewController snapshot") {
                    //usado para gerar o reference images - iPhone 11 Pro
//                    expect(self.sut) == recordSnapshot("StarredUsersTableViewController")
                    expect(self.sut) == snapshot("StarredUsersTableViewController")
                }
            }
            
        }
    }
    
    private func getAPIUserData() -> Result? {
        
        if let path = Bundle.main.path(forResource: "Users", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let result = try? decoder.decode(Result.self, from: data) {
                    return result
                }
            } catch let error {
                print("Error: \(error)")
            }
        }
        return nil
    }
}
