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
    
    let titles = ["タイトル1", "タイトル2", "タイトル3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
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
        print("検索ボタンが選択された")
    }
}

extension ViewController: UITableViewDataSource {
    // セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    // セルを作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.title.text = titles[indexPath.row]
        return cell
    }
}
