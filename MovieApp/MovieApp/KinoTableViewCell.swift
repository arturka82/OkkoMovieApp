//
//  KinoTableViewCell.swift
//  KinoPoisk
//
//  Created by Artur Gedakyan on 05.03.2021.
//

import UIKit

final class KinoTableViewCell: UITableViewCell {
    static var id = "KinoTableViewCell"

    @IBOutlet var kinoImage: UIImageView!
    @IBOutlet var kinoNameLabel: UILabel!
    @IBOutlet var kinoDescriptionLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        kinoNameLabel.text = model.originalTitle
        kinoDescriptionLabel.text = model.overview
        dataLabel.text = model.releaseDate

//        guard let unrapPosterImage = model.posterPath else { return }

        kinoImage.image = nil
    }

    func loadImage(model: Movie) {
        let imageService = ImageServise()
        let proxy = Proxy(service: imageService)
        guard let unrapImagePoster = model.posterPath else { return }
        guard let qunemImage = URL(string: "https://image.tmdb.org/t/p/w500\(unrapImagePoster)") else { return }

        proxy.loadImage(url: qunemImage) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.kinoImage.image = UIImage(data: data)
            }
        }
    }
}

extension KinoTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KinoTableViewCell", for: indexPath)
        return cell
    }
}
