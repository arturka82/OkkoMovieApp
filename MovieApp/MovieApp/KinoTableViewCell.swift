//
//  KinoTableViewCell.swift
//  KinoPoisk
//
//  Created by Artur Gedakyan on 05.03.2021.
//

import UIKit

final class KinoTableViewCell: UITableViewCell {
    static var id = "KinoTableViewCell"

    @IBOutlet var backgroundUiview: UIView!

    @IBOutlet var kinoImage: UIImageView!
    @IBOutlet var kinoNameLabel: UILabel!
    @IBOutlet var kinoDescriptionLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundUiview.layer.shadowColor = UIColor.gray.cgColor
        backgroundUiview.layer.shadowOpacity = 1
        backgroundUiview.layer.shadowOffset = .zero
        backgroundUiview.layer.shadowRadius = 10
        backgroundUiview.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    static func nib() -> UINib {
        let inibLocal = UINib(nibName: "KinoTableViewCell", bundle: nil)

        return inibLocal
    }

    var bigDickCache: [String: UIImage] = [:]

    public func configure(model: Movie) {
        loadImage(model: model)

        kinoNameLabel.text = model.originalTitle
        kinoDescriptionLabel.text = model.overview
        dataLabel.text = model.releaseDate
    }

    func loadImage(model: Movie) {
        let imageService = ImageServise()
        let proxy = Proxy(service: imageService)
        guard let unrapImagePoster = model.posterPath else { return }
        print(unrapImagePoster, self)
        guard let qunemImage = URL(string: "https://image.tmdb.org/t/p/w500\(unrapImagePoster)") else { return }

        proxy.loadImage(url: qunemImage) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.kinoImage.image = nil
                self.kinoImage.image = UIImage(data: data)
            }
        }
    }
}
