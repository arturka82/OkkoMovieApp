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

//    private func createMovie() {
//        moviesModel
//            .append(Movie(
//                image: "movie1",
//                name: "Непосредсвенно каха",
//                description: "Эксклюзивная премьера! Фильм «Непосредственно Каха», собравший в кинотеатрах более 500 миллионов рублей.",
//                date: "12 ноября 2020"
//            ))
//        moviesModel
//            .append(Movie(
//                image: "movie2",
//                name: "Механик.Воскрешение",
//                description: "Артур думал, что он оставил свое убийственное прошлое позади, когда его грозный противник похищает его.",
//                date: "25 августа 2016"
//            ))
//        moviesModel
//            .append(Movie(
//                image: "movie3",
//                name: "Фокус",
//                description: "Уилл Смит и звезда «Волка с Уолл-стрит» красавица Марго Робби в авантюрной комедии о паре обаятельных мошенников.",
//                date: "13 april 2015"
//            ))
//        moviesModel
//            .append(Movie(
//                image: "movie4",
//                name: "Основатель",
//                description: "История основателя сети McDonald's Рэя Крока, прошедшего путь от коммивояжера, торгующего миксерами.",
//                date: "13 april 2015"
//            ))
//        moviesModel
//            .append(Movie(
//                image: "movie5",
//                name: "Джентельмены",
//                description: "Влиятельный гангстер из Лондона решает продать свой бизнес по справедливой цене.",
//                date: "13 april 2015"
//            ))
//        moviesModel
//            .append(Movie(
//                image: "movie6",
//                name: "Джокер",
//                description: "История становления знаменитого злодея из Готэма. Неудачливый клоун Артур Флек.",
//                date: "13 april 2019"
//            ))
//    }
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
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
