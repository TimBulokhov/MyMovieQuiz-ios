import UIKit
//Порядок - переменные, overrides+inits, методы, outlets+actions
final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.showQuestion(quiz: viewModel)
        }
    }
    private var indexOfCurrentQuestion = 0
    private var countOfCorrectAnswers = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactory = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory = QuestionFactory()
        questionFactory.delegate = self
        questionFactory.requestNextQuestion()
        imageView.layer.cornerRadius = 20
    }
    private func showQuestion(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        buttonNo.isEnabled = true
        buttonYes.isEnabled = true
    }
    private func showAlert(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.alertName,
            message: result.resultText,
            preferredStyle: .alert)
        let action = UIAlertAction(title: result.repeatButtonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.countOfCorrectAnswers = 0
            self.indexOfCurrentQuestion = 0
            questionFactory.requestNextQuestion()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let quizStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(indexOfCurrentQuestion+1) / \(questionsAmount)")
        return quizStep
    }
    private func showNextQuestionOrResults() {
        if  indexOfCurrentQuestion == questionsAmount - 1 {
            let userResultText = countOfCorrectAnswers == questionsAmount ?
            "Nice, your score is 10/10!" :
            "Your score is \(countOfCorrectAnswers)/10"
            let answerViewModel = QuizResultsViewModel(
                alertName: "End of round!",
                resultText: userResultText,
                repeatButtonText: "Play again?")
            showAlert(quiz: answerViewModel)
            imageView.layer.borderWidth = 0
            imageView.layer.borderColor = UIColor.clear.cgColor
        } else {
            indexOfCurrentQuestion+=1
            self.questionFactory.requestNextQuestion()
            imageView.layer.borderWidth = 0
            imageView.layer.borderColor = UIColor.clear.cgColor
        }
    }
    private func showAnswerResult(isCorrect: Bool) {
        buttonNo.isEnabled = false
        buttonYes.isEnabled = false
        if isCorrect {
            countOfCorrectAnswers+=1
        }
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 8
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
        }
    }
    @IBOutlet private weak var buttonNo: UIButton!
    @IBOutlet private weak var buttonYes: UIButton!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let userAnswer = false
        showAnswerResult(isCorrect: userAnswer == currentQuestion.isAnswerCorrect)
    }
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let userAnswer = true
        showAnswerResult(isCorrect: userAnswer == currentQuestion.isAnswerCorrect)
    }
}


