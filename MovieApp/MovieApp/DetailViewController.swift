//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 12.03.2021.
//

import UIKit

/// DetailViewController
class DetailViewController: UIViewController {
    var movieRequest: MovieRequest?

    var model: Movie!

    @IBOutlet var backgroundVoteVview: UIView!
    @IBOutlet var dataBackgroundVoteVview: UIView!

    @IBOutlet var voteLabel: UILabel!
    @IBOutlet var kinoImage: UIImageView!
    @IBOutlet var kinoNameLabel: UILabel!
    @IBOutlet var kinoDescriptionLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        backgroundVoteVview.layer.shadowColor = UIColor.white.cgColor
        backgroundVoteVview.layer.shadowOpacity = 1
        backgroundVoteVview.layer.shadowOffset = .zero
        backgroundVoteVview.layer.shadowRadius = 20

        dataBackgroundVoteVview.layer.shadowColor = UIColor.white.cgColor
        dataBackgroundVoteVview.layer.shadowOpacity = 1
        dataBackgroundVoteVview.layer.shadowOffset = .zero
        dataBackgroundVoteVview.layer.shadowRadius = 5

        navigationController?.navigationBar.barTintColor = .systemGray
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

    public func configure() {
        loadImage(model: model)

        kinoNameLabel.text = model?.originalTitle
        kinoDescriptionLabel.text = model?.overview
        dataLabel.text = model.releaseDate
        voteLabel.text = String(model?.voteAverage ?? 0)
    }
}
