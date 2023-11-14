//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Timofey Bulokhov on 14.11.2023.
//

import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    weak var delegate: QuestionFactoryDelegate?
    private var questionFactory: QuestionFactoryProtocol?
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 7.5?",
            isAnswerCorrect: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма меньше чем 7.5?",
            isAnswerCorrect: false),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 8?",
            isAnswerCorrect: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма меньше чем 7.8?",
            isAnswerCorrect: false),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма меньше чем 7.3?",
            isAnswerCorrect: false),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6.7?",
            isAnswerCorrect: false),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма меньше чем 5.9?",
            isAnswerCorrect: true),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма меньше чем 5.5?",
            isAnswerCorrect: true),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма меньше чем 5.5?",
            isAnswerCorrect: true),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            isAnswerCorrect: false)
    ]
    
    func requestNextQuestion() {
        guard let index = (0..<questions.count).randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            return
        }
        let question = questions[safe: index]
        delegate?.didReceiveNextQuestion(question: question)
    }
}



/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 7.5??
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма меньше чем 7.5?
 Ответ: НЕТ
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 8?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма меньше чем 7.8?
 Ответ: НЕТ
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма меньше чем 7.3?
 Ответ: НЕТ
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6.7?
 Ответ: НЕТ
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма меньше чем 5.9?
 Ответ: ДА
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма меньше чем 5.5?
 Ответ: ДА
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма меньше чем 5.5?
 Ответ: ДА
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
