//
//  ImageServise.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 11.03.2021.
//

import Foundation

/// ImageSevise
class ImageServise: LoadServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let confing = URLSessionConfiguration.default
        confing.requestCachePolicy = .reloadRevalidatingCacheData
        confing.urlCache = nil

        let session = URLSession(configuration: confing)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
