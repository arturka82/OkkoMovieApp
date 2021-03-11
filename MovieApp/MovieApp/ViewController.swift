//
//  ViewController.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 08.03.2021.
//

import UIKit

/// ViewController
class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    let qunemTigran = KinoTableViewCell()

    private var movieRequest: MovieRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        createMovie()
        fetchData()
        tableView.register(KinoTableViewCell.nib(), forCellReuseIdentifier: KinoTableViewCell.id)
    }

    func fetchData() {
        
        
        let jsonUrlString =
            "https://api.themoviedb.org/3/movie/popular?api_key=9edf21c98a9d71103c308248693cb1eb&language=en-US&page=1"

        guard let url = URL(string: jsonUrlString) else { return }

        URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data else { return }
            do {
                self.movieRequest = try JSONDecoder().decode(MovieRequest.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("ERROR PZDS", error)
            }

        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieRequest?.movieArray.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: KinoTableViewCell.id, for: indexPath) as? KinoTableViewCell
        else { return UITableViewCell() }
        guard let movie = movieRequest?.movieArray else { return UITableViewCell() }
        cell.configure(model: movie[indexPath.row])
//        cell.loadImage(model: movie[indexPath.row])

        print(cell.kinoImage.image)

        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
