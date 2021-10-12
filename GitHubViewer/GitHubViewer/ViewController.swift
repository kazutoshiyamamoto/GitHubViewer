//
//  ViewController.swift
//  GitHubViewer
//
//  Created by home on 2021/02/18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var users: [User] = []
    private var presenter: SearchUserPresenterInput!
    
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    // ユーザー情報を取得
    func fetchUser(query: String, completion: @escaping (Result<[User]>) -> ()) {
        let request = SearchUsersRequest(query: query)
        
        Session().send(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    // 編集開始時の処理
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // キャンセルボタンを表示
        searchBar.showsCancelButton = true
        
        return true
    }
    
    // キャンセルボタン選択時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // キャンセルボタンを非表示に変更
        searchBar.showsCancelButton = false
        // キーボードを下げる
        searchBar.resignFirstResponder()
    }
    
    // 検索実行時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension ViewController: UITableViewDataSource {
    // セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(user: users[indexPath.row])
        
        return cell
    }
}
