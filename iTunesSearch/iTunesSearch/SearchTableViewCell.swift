//
//  SearchTableViewCell.swift
//  iTunesSearch
//
//  Created by Jorge Luna on 8/28/17.
//  Copyright © 2017 Jorge. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTrackKind: UILabel!
    @IBOutlet weak var lblTrackPrice: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
