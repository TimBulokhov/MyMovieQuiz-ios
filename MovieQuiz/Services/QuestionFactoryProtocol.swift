//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Timofey Bulokhov on 14.11.2023.
//

import Foundation

protocol QuestionFactoryProtocol {
    var delegate: QuestionFactoryDelegate? { get set }
    func requestNextQuestion()
    func loadData()
}
