//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Timofey Bulokhov on 14.11.2023.
//

import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoading
    weak var delegate: QuestionFactoryDelegate?
    
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    private var movies: [MostPopularMovie] = []

    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    } 
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            
            var imageData = Data()
           
           do {
                imageData = try Data(contentsOf: movie.imageURL)
            } catch {
                print("Failed to load image")
            }
            let lessOrMore = Int.random(in: 1...2)
            if lessOrMore == 1 {
                let rating = Float(movie.rating) ?? 0
                let ratingInQuestion = Float.random(in: 5.5..<10)
                let text = String(format: "Рейтинг этого фильма меньше чем %.1f?", ratingInQuestion)
                let correctAnswer = rating < ratingInQuestion
                
                let question = QuizQuestion(image: imageData,
                                            text: text,
                                            isAnswerCorrect: correctAnswer)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didReceiveNextQuestion(question: question)
                }
            }
            else {
                let rating = Float(movie.rating) ?? 0
                let ratingInQuestion = Float.random(in: 5.5..<10)
                let text = String(format: "Рейтинг этого фильма больше чем %.1f?", ratingInQuestion)
                let correctAnswer = rating > ratingInQuestion
                
                let question = QuizQuestion(image: imageData,
                                            text: text,
                                            isAnswerCorrect: correctAnswer)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.didReceiveNextQuestion(question: question)
                }
            }
        }
    }
}
