//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Timofey Bulokhov on 18.11.2023.
//

import Foundation

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isScoreBetter(_ another: GameRecord) -> Bool {
        correct < another.correct
    }
    func convertToString() -> String {
        return "\(correct)/\(total) (\(date.dateTimeString)"
    }
}
