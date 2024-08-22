//
//  PostDetailsTableViewCell.swift
//  CombineApiCallSwift
//
//  Created by Kishore B on 8/22/24.
//

import UIKit

class PostDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(with data: Post) {
        userIdLabel.text = "User id: \(data.userId)"
        idLabel.text = "id: \(data.id)"
        titleLabel.text = "Title: \(data.title)"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
