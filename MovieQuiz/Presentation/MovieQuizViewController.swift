import UIKit
//Порядок - переменные, overrides+inits, методы, outlets+actions
final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    // MARK: - Private Properties
    private var indexOfCurrentQuestion = 0
    private var countOfCorrectAnswers = 0
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol? = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenter?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        questionFactory = QuestionFactory()
        questionFactory?.delegate = self
        questionFactory?.requestNextQuestion()
        alertPresenter = AlertPresenter(mainView: self)
        imageView.layer.cornerRadius = 20
    }
    // MARK: - Delegate Function.
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
    // MARK: - PrivateFunctions
    private func showQuestion(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        buttonNo.isEnabled = true
        buttonYes.isEnabled = true
    }
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(indexOfCurrentQuestion+1) / \(questionsAmount)")
    }
    private func showAlert(quizEnd quiz: QuizResultsViewModel) {
        let alertModel = AlertModel(title: quiz.alertName,
                                    message: quiz.resultText,
                                    buttonText: quiz.repeatButtonText,
                                    completion: {[weak self] in
            self?.indexOfCurrentQuestion = 0
            self?.countOfCorrectAnswers = 0
            self?.questionFactory?.requestNextQuestion()
        })
        alertPresenter?.newAlert(data: alertModel)
    }
    private func showNextQuestionOrResults() {
        if  indexOfCurrentQuestion == questionsAmount - 1 {
            let userResultText = countOfCorrectAnswers == questionsAmount ?
            "Nice, your score is 10/10!" :
            "Your score is \(countOfCorrectAnswers)/10"
            showAlert (quizEnd: QuizResultsViewModel(
                alertName: "End of round!",
                resultText: userResultText,
                repeatButtonText: "Play again?"))
            imageView.layer.borderWidth = 0
            imageView.layer.borderColor = UIColor.clear.cgColor
        } else {
            indexOfCurrentQuestion+=1
            questionFactory?.requestNextQuestion()
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


