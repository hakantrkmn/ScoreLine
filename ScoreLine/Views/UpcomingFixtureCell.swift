//
//  UpcomingFixtureCell.swift
//  ScoreLine
//
//  Created by Om Gandhi on 24/02/24.
//

import UIKit

class UpcomingFixtureCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var imgAway: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
