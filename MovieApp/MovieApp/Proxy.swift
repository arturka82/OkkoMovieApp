//
//  Proxy.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 11.03.2021.
//

import Foundation

var cacheDate: Data?

/// Proxy Class
class Proxy: LoadServiceProtocol {
    private var service: LoadServiceProtocol

    init(service: LoadServiceProtocol) {
        self.service = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if cacheDate == nil {
            service.loadImage(url: url) { data, respinse, error in
                cacheDate = data
                completion(data, respinse, error)
            }
        } else {
            completion(cacheDate, nil, nil)
        }
    }
}
