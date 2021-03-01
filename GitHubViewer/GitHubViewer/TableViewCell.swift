//
//  TableViewCell.swift
//  GitHubViewer
//
//  Created by home on 2021/02/18.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    private var task: URLSessionTask?
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    func configure(user: User) {
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

        // Configure the view for the selected state
        title.text = user.login
    }
}
