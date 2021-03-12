//
//  SegmenTTableViewCell.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 12.03.2021.
//

import UIKit

/// SegmenTTableViewCell
final class SegmenTTableViewCell: UITableViewCell {
    static var id = "SegmenTTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        let inibLocal = UINib(nibName: "SegmenTTableViewCell", bundle: nil)

        return inibLocal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
