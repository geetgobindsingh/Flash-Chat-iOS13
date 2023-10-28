//
//  MessageCellTableViewCell.swift
//  Flash Chat iOS13
//
//  Created by Geet Gobind Singh on 20/04/23.
//  Copyright © 2023 Geet Gobind Singh. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var speechBubbleBackgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var otherPersonAvatarImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        speechBubbleBackgroundView.layer.cornerRadius = speechBubbleBackgroundView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
