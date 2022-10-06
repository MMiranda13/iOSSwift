//
//  WetsuitCell.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 21/09/2022.
//

import UIKit

class WetsuitCell: UITableViewCell {

    
    @IBOutlet weak var wetsCell: UIView!
    @IBOutlet weak var thicknessLabel: UILabel!
    @IBOutlet weak var brandModelLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thicknessLabel.layer.cornerRadius = 2
        brandModelLabel.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
