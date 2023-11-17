//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Timofey Bulokhov on 17.11.2023.
//

import Foundation
import UIKit
class AlertPresenter {
    weak var mainView: UIViewController?
    
    init(mainView: UIViewController? = nil) {
        self.mainView = mainView
    }
    
    func newAlert(data: AlertModel) {
        let alert = UIAlertController(
            title: data.title,
            message: data.message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: data.buttonText, style: .default) { _ in
            data.completion()
        }
        alert.addAction(action)
        mainView?.present(alert, animated: true, completion: nil)
    }
}
