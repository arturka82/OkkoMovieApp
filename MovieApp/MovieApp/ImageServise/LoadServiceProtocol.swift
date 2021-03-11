//
//  LoadServiceProtocol.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 11.03.2021.
//

import Foundation

protocol LoadServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
