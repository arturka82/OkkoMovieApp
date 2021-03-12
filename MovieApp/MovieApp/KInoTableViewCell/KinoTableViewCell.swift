//
//  KinoTableViewCell.swift
//  KinoPoisk
//
//  Created by Artur Gedakyan on 05.03.2021.
//

import UIKit

/// KinoTableViewCell
final class KinoTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet var backgroundUiview: UIView!
    @IBOutlet var backgroundVoteVview: UIView!

    @IBOutlet var voteLabel: UILabel!
    @IBOutlet var kinoImage: UIImageView!
    @IBOutlet var kinoNameLabel: UILabel!
    @IBOutlet var kinoDescriptionLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!

    // MARK: - Public Properties
    static var id = "KinoTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundUiview.layer.shadowColor = UIColor.gray.cgColor
        backgroundUiview.layer.shadowOpacity = 1
        backgroundUiview.layer.shadowOffset = .zero
        backgroundUiview.layer.shadowRadius = 10
        backgroundUiview.layer.cornerRadius = 10

        backgroundVoteVview.layer.shadowColor = UIColor.red.cgColor
        backgroundVoteVview.layer.shadowOpacity = 1
        backgroundVoteVview.layer.shadowOffset = .zero
        backgroundVoteVview.layer.shadowRadius = 5
    }
    
    // MARK: - Public methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    static func nib() -> UINib {
        let inibLocal = UINib(nibName: "KinoTableViewCell", bundle: nil)

        return inibLocal
    }


    public func configure(model: Movie) {
        loadImage(model: model)

        kinoNameLabel.text = model.originalTitle
        kinoDescriptionLabel.text = model.overview
        dataLabel.text = model.releaseDate
        voteLabel.text = String(model.voteAverage ?? 0)
    }

    // MARK: - Private Methods
    private func loadImage(model: Movie) {
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
