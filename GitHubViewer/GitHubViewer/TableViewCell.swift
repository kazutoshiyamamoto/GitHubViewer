//
//  TableViewCell.swift
//  GitHubViewer
//
//  Created by home on 2021/02/18.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    private var task: URLSessionTask?
    
    // セルの初期化処理
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        task = nil
        imageView?.image = nil
    }
    
    func configure(user: User) {
        // 画像URLからユーザー画像を取得して表示
        task = {
            let url = user.avatarURL
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {
                    return
                }
                
                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.icon?.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()
        
        name.text = user.login
    }
}
