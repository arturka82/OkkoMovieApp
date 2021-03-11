//
//  Proxy.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 11.03.2021.
//

import Foundation

/// Proxy Class
class Proxy: LoadServiceProtocol {
    private var service: LoadServiceProtocol
    private var cacheDateDict: [String: Data] = [:]

    init(service: LoadServiceProtocol) {
        self.service = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if cacheDateDict[url.absoluteString] == nil {
            service.loadImage(url: url) { data, respinse, error in
                self.cacheDateDict[url.absoluteString] = data
                completion(data, respinse, error)
            }
        } else {
            completion(cacheDateDict[url.absoluteString], nil, nil)
        }
    }
}
