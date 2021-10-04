//
//  SearchUserPresenter.swift
//  GitHubViewer
//
//  Created by home on 2021/10/02.
//

import Foundation

protocol SearchUserPresenterInput {
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> User?
    func didSelectRow(at indexPath: IndexPath)
    func didTapSearchButton(text: String?)
}

protocol SearchUserPresenterOutput: AnyObject {
    func updateUsers(_ users: [User])
    func transitionToUserDetail(userName: String)
}

final class SearchUserPresenter: SearchUserPresenterInput {
    
}
