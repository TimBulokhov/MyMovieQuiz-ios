//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Timofey Bulokhov on 14.11.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}

