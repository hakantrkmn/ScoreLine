//
//  CoachCell.swift
//  ScoreLine
//
//  Created by Om Gandhi on 26/02/24.
//

import UIKit

class CoachCell: UITableViewCell {

    @IBOutlet weak var imgCoach: UIImageView!
    @IBOutlet weak var lblCoachName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
