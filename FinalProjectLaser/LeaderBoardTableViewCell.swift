//
//  LeaderBoardTableViewCell.swift
//  FinalProjectLaser
//
//  Created by Livleen Rai on 2017-09-13.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var scoreCell: UILabel!
    
    var name = ""
    var score = 0
    
    func setLabels() {
        nameCell.text = name
        scoreCell.text = String(self.score)
    }
    
}
