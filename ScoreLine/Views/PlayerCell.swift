//
//  PlayerCell.swift
//  ScoreLine
//
//  Created by Om Gandhi on 26/02/24.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
