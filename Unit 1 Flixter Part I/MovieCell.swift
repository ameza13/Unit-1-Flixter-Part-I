//
//  MovieCell.swift
//  Unit 1 Flixter Part I
//
//  Created by Adriana Meza on 4/13/20.
//  Copyright © 2020 Adriana Meza. All rights reserved.
//

import UIKit

/*
 We added this class to have all the outlets here. It does not make sense adding the otles for the
 cell's internal components to MoviesViewController because it would know know to which one refer. 
 */
class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
