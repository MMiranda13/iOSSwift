//
//  QuiverCell.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 12/09/2022.
//

import UIKit

class QuiverCell: UITableViewCell {

    @IBOutlet weak var boardCell: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeLabel.layer.cornerRadius = 2
        brandLabel.layer.cornerRadius = 2
        modelLabel.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
