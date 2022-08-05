//
//  TrainingViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 14.01.2022.
//

import UIKit
import GameKit
import AVFoundation
import SnapKit
import Lottie

class TrainingViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var animationName = UserDefaults.standard.string(forKey: "animationName")
    var animationView = AnimationView()
    
    var questionsModel = QuestionModel()
    var questionsModelTR = QuestionModelTR()
    var questionsModelES = QuestionModelES()
    
    var arrayAnimationWait = ["Wait", "Wait2", "Wait3"]
    var arrayNextSynonyms = ["Ясно", "Понятно", "Хорошо", "Дальше", "Далее", "Бесспорно", "Конечно", "Знаю", "Известно", "Само собой", "Не иначе", "Общепонятно", "Ясное дело", "Безоговорочно", "Доходчиво", "Наверняка", "Без сомнения", "Спору нет", "Схвачено", "Однозначно", "Очевидно", "Разумеется", "Безусловно", "Естественно", "Несомненно", "Без сомнения", "Вне сомнения", "Понятное дело", "Отчетливо", "Факт"]
    var arrayNextSynonymsTR = ["Evet", "Tamam", "Olur", "Elbette", "Tabii ki", "Çok güzel", "Mümkün", "Razıyım", "Şüphesiz", "Doğru", "Belki"]
    
    var arrayNextSynonymsES = ["acaso", "por lo visto", "quizás", "al seguro", "tal vez", "verdaderamente", "a buen seguro", "de cierto", "efectivamente", "ciertamente"]
    
    var randomButtonName: String!
    
    var waitTime: Int = 0
    
    let score = ScoreModel()
    
    let numberOfQuestionPerRound = UserDefaults.standard.integer(forKey: "numberOfQuestionPerRound")
    
    var currentQuestion: Question? = nil
    
    var player: AVAudioPlayer?
    var soundWord: String!
    
    var progressCount: Float!
    var progressCountGame: Float!
    var firstQuestionBool = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitingTimer()
        self.view.backgroundColor = #colorLiteral(red: 0.05953502964, green: 0.3432602451, blue: 0.4998384456, alpha: 1)
        backgroundChalk.isHidden = false
        blackboard.isHidden = false

        displayQuestion()
        progressCountGame = progressCount
        progressBar.isHidden = false
        progressBar.progress = 0.0
        
        playWordSoundButton.addTarget(self, action: #selector(playWordSoundButtonAction(sender:)), for: .touchUpInside)
        
        setupRandomButtonName()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.trueAnswerButtonLabel.isHidden = false
            self.trueAnswerButton.addTarget(self, action: #selector(self.trueAnswerButtonAction(sender:)), for: .touchUpInside)
            self.nextAnswerButton.addTarget(self, action: #selector(self.nextAnswerButtonAction(sender:)), for: .touchUpInside)
            self.nextAnswerButtonLabel.isHidden = false
        }
        
        repeatButtonLabel.isHidden = true
        repeatButton.isHidden = true
        repeatButton.addTarget(self, action: #selector(repeatButtonAction(sender:)), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        dismissButtonLabel.isHidden = true
        dismissButton.isHidden = true
        dismissButtonDuringGame.addTarget(self, action: #selector(dismissButtonActionDuringGame(sender:)), for: .touchUpInside)
        
        
        animationHero()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isGameOver() -> Bool {
        return score.getQuestionsAsked() >= numberOfQuestionPerRound
    }
    
//MARK: DisplayQuestion
    func displayQuestion() {
        
        switch Locale.current.languageCode {
        case "ru":
            currentQuestion = questionsModel.getQuestion()
        case "tr":
            currentQuestion = questionsModelTR.getQuestion()
        case "es":
            currentQuestion = questionsModelES.getQuestion()
        default:
            currentQuestion = questionsModel.getQuestion()
        }
        
//        currentQuestion = questionsModel.getQuestion()
        
        if let question = currentQuestion {
            question.getChoices()
            
            
            if numberOfQuestionPerRound == 54 {
                progressCount = 0.01851852
            } else if numberOfQuestionPerRound == 36 {
                progressCount = 0.02777778
            } else if numberOfQuestionPerRound == 33 {
                progressCount = 0.0303030303
            } else if numberOfQuestionPerRound == 30 {
                progressCount = 0.033333
            } else if numberOfQuestionPerRound == 28 {
                progressCount = 0.03571
            } else if numberOfQuestionPerRound == 27 {
                progressCount = 0.0370370
            } else if numberOfQuestionPerRound == 22 {
                progressCount = 0.0454
            } else if numberOfQuestionPerRound == 21 {
                progressCount = 0.04761
            } else if numberOfQuestionPerRound == 20 {
                progressCount = 0.05
            } else if numberOfQuestionPerRound == 19 {
                progressCount = 0.05263
            } else if numberOfQuestionPerRound == 18 {
                progressCount = 0.05555556
            } else if numberOfQuestionPerRound == 17 {
                progressCount = 0.05882353
            } else if numberOfQuestionPerRound == 16 {
                progressCount = 0.0625
            } else if numberOfQuestionPerRound == 15 {
                progressCount = 0.06666667
            } else if numberOfQuestionPerRound == 14 {
                progressCount = 0.07142857
            } else if numberOfQuestionPerRound == 13 {
                progressCount = 0.0769
            } else if numberOfQuestionPerRound == 12 {
                progressCount = 0.083
            } else if numberOfQuestionPerRound == 11 {
                progressCount = 0.0909
            } else if numberOfQuestionPerRound == 10 {
                progressCount = 0.1
            } else if numberOfQuestionPerRound == 8 {
                progressCount = 0.125
            } else if numberOfQuestionPerRound == 5 {
                progressCount = 0.2
            }
            
            qestionLabel.text = question.getInterrogative()
            transcriptionLabel.text = question.getTranscription()
            soundWord = question.getSound()
            
            if firstQuestionBool == false {
                Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) {_ in
                    self.playWordSound()
                }
                firstQuestionBool = true
            } else {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
                    self.playWordSound()
                }
            }
            
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.trueAnswerButtonLabel.text = question.getAnswer()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.trueAnswerButton.isUserInteractionEnabled = true
            self.nextAnswerButton.isUserInteractionEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.trueAnswerButton.isHidden = false
            self.nextAnswerButton.isHidden = false
        }
    }
    
//MARK: DisplayScore
    func displayScore() {
        
        switch Locale.current.languageCode {
        case "ru":
            questionsModel.resetQuestionNumber()
        case "tr":
            questionsModelTR.resetQuestionNumber()
        case "es":
            questionsModelES.resetQuestionNumber()
        default:
            questionsModel.resetQuestionNumber()
        }
        
//        questionsModel.resetQuestionNumber()
//        score.saveProgress()
        
        playLevelEndSound()
        
        qestionLabel.text = "Конец!".localized()
        transcriptionLabel.text = ""
        
        UIView.animate(withDuration: 0.4, animations: {
            self.dismissButtonDuringGame.alpha = 0
            self.playWordSoundButton.alpha = 0
        })
        
        score.reset()
        dismissButton.isHidden = false
        dismissButton.zoomInInfo()
        dismissButtonLabel.isHidden = false
        dismissButtonLabel.zoomInInfo()
        repeatButtonLabel.isHidden = false
        repeatButtonLabel.zoomInInfo()
        repeatButton.isHidden = false
        repeatButton.zoomInInfo()
        
        
        trueAnswerButton.isHidden = true
        nextAnswerButton.isHidden = true
        
        waitTime = 0
        
        //animation
        startAnimation(viewName: animationView, jsonName: animationName!+"Win")
    }
    
//MARK: Blackboard
    lazy var blackboard: UIImageView = {
        let img = UIImageView(image: UIImage(named: "blackboard"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 9
        img.layer.shadowOffset = CGSize(width: 0, height: -5)
        img.layer.shadowOpacity = 0.3
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var leadTrail: CGFloat!
        if totalSize.height >= 920 {
            positY = -180
            leadTrail = 10
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -170
            leadTrail = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -150
            leadTrail = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -140
            leadTrail = 25
        } else if totalSize.height <= 670 {
            positY = -130
            leadTrail = 15
        } else {
            positY = -150
            leadTrail = 15
        }
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
            make.leading.trailing.equalToSuperview().inset(leadTrail)
        }
        return img
    }()
//MARK:  - BackgroundImage
    lazy var backgroundChalk: UIImageView = {
        
        var imgName = "backgroundBasicGame"
        
        if animationName == "misterWatch" {
            imgName = "backgroundTimeGame"
        } else if animationName == "basicGirl" {
            imgName = "backgroundBasicGame"
        } else if animationName == "person" {
            imgName = "backgroundPersonGame"
        }
        
        let img = UIImageView(image: UIImage(named: imgName))
        img.contentMode = .scaleAspectFit
        img.alpha = 0.7
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(-10)
        }
        return img
    }()
//MARK: AnimationHero
    func animationHero() {
        var xPosit: CGFloat!
        var yPosit: CGFloat!
        var hght: CGFloat!
        if animationName == "misterWatch" {
            if totalSize.height >= 920 {
                xPosit = -60
                yPosit = 280
                hght = 250
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                xPosit = -60
                yPosit = 270
                hght = 240
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                xPosit = -60
                yPosit = 270
                hght = 240
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                xPosit = -60
                yPosit = 230
                hght = 240
            } else if totalSize.height <= 670 {
                xPosit = -60
                yPosit = 200
                hght = 230
            } else {
                xPosit = -60
                yPosit = 250
                hght = 230
            }
        } else if animationName == "basicGirl" {
            if totalSize.height >= 920 {
                xPosit = -60
                yPosit = 260
                hght = 280
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                xPosit = -60
                yPosit = 255
                hght = 270
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                xPosit = -60
                yPosit = 240
                hght = 260
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                xPosit = -60
                yPosit = 200
                hght = 240
            } else if totalSize.height <= 670 {
                xPosit = -60
                yPosit = 180
                hght = 230
            } else {
                xPosit = -60
                yPosit = 230
                hght = 260
            }
        } else if animationName == "person" {
            if totalSize.height >= 920 {
                xPosit = -60
                yPosit = 255
                hght = 320
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                xPosit = -60
                yPosit = 260
                hght = 300
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                xPosit = -60
                yPosit = 250
                hght = 300
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                xPosit = -60
                yPosit = 200
                hght = 290
            } else if totalSize.height <= 670 {
                xPosit = -60
                yPosit = 180
                hght = 270
            } else {
                xPosit = -60
                yPosit = 235
                hght = 300
            }
        } else if animationName == "misterTomato" {
            if totalSize.height >= 920 {
                xPosit = -40
                yPosit = 270
                hght = 230
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                xPosit = -40
                yPosit = 260
                hght = 220
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                xPosit = -40
                yPosit = 260
                hght = 200
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                xPosit = -40
                yPosit = 220
                hght = 220
            } else if totalSize.height <= 670 {
                xPosit = -40
                yPosit = 190
                hght = 200
            } else {
                xPosit = -40
                yPosit = 245
                hght = 200
            }
        }
        animationView = AnimationView(name: animationName!+"Wait")
        animationView.frame = CGRect(x: xPosit, y: yPosit, width: self.view.frame.size.width, height: hght)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationView.layer.shadowRadius = 6
        animationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationView.layer.shadowOpacity = 0.3
        self.view.addSubview(animationView)
        
//        animationView.play { (finished) in
//            animationView.isHidden = true
//        }
    }
    
    func startAnimation(viewName: AnimationView, jsonName: String) {
        viewName.isHidden = false
        viewName.animation = Animation.named(jsonName)
        viewName.play()
    }
        
//MARK: QestionLabel
    lazy var qestionLabel: UILabel = {
        
        var topPosit: CGFloat!
        var size: CGFloat!
        if totalSize.height >= 920 {
            topPosit = 187
            size = 35
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            topPosit = 190
            size = 32
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            topPosit = 190
            size = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 145
            size = 30
        } else if totalSize.height <= 670 {
            topPosit = 125
            size = 27
        } else {
            topPosit = 175
            size = 27
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: size)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOffset = CGSize(width: 0, height: 10)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        return lbl
    }()
//MARK: TranscriptionLabel
    lazy var transcriptionLabel: UILabel = {
        
        var topPosit: CGFloat!
        var size: CGFloat!
        if totalSize.height >= 920 {
            topPosit = 230
            size = 25
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            topPosit = 230
            size = 25
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            topPosit = 225
            size = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 180
            size = 20
        } else if totalSize.height <= 670 {
            topPosit = 155
            size = 17
        } else {
            topPosit = 205
            size = 17
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: "pencilpeteFont", size: size)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(topPosit)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        return lbl
    }()
    
//MARK: ProgressBar
    lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.trackTintColor = #colorLiteral(red: 0.05198650897, green: 0.2997378504, blue: 0.4364633056, alpha: 0)
        progress.progressTintColor = #colorLiteral(red: 0, green: 0.6689776182, blue: 0.811511755, alpha: 1)
        self.view.addSubview(progress)
        
        progress.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(5)
        }
        
        return progress
    }()

//MARK: - TrueAnswerButton
    lazy var trueAnswerButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 31
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 31
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 28
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 28
        } else if totalSize.height <= 670 {
            size = 26
        } else {
            size = 26
        }
        
        var positY: CGFloat!
        var fontName = "appleberry"
        switch Locale.current.languageCode {
        case "ru":
            positY = 5
            fontName = "appleberry"
        case "tr":
            positY = 2
            fontName = "KGRedHands"
            
            if totalSize.height >= 920 {
                size = 23
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 22
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 20
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 21
            } else if totalSize.height <= 670 {
                size = 19
            } else {
                size = 19
            }
        case "es":
            positY = 2
            fontName = "KGRedHands"
            
            if totalSize.height >= 920 {
                size = 23
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 23
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 20
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 21
            } else if totalSize.height <= 670 {
                size = 19
            } else {
                size = 19
            }
        default:
            positY = 5
            fontName = "appleberry"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: size)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        trueAnswerButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    lazy var trueAnswerButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletGameBlue"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            hght = 57
            positY = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 57
            positY = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 52
            positY = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 54
            positY = 130
        } else if totalSize.height <= 670 {
            hght = 49
            positY = 130
        } else {
            hght = 52
            positY = 130
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(hght)
        }
       return btn
    }()
    @objc func trueAnswerButtonAction(sender: UIButton) {
    }
    
//MARK: - RandomButtonName
    func setupRandomButtonName() {
        switch Locale.current.languageCode {
        case "ru":
            nextAnswerButtonLabel.text = arrayNextSynonyms.randomElement()
        case "tr":
            nextAnswerButtonLabel.text = arrayNextSynonymsTR.randomElement()
        case "es":
            nextAnswerButtonLabel.text = arrayNextSynonymsES.randomElement()
        default:
            nextAnswerButtonLabel.text = arrayNextSynonyms.randomElement()
        }
    }
//MARK: - NextAnswerButton
    lazy var nextAnswerButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 25
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 25
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 26
        } else if totalSize.height <= 670 {
            size = 22
        } else {
            size = 22
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: size)
        lbl.text = randomButtonName
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        nextAnswerButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(3)
        }
        
        return lbl
    }()
    
    lazy var nextAnswerButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletGameBlueShort"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            hght = 48
            positY = 320
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 48
            positY = 310
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 44
            positY = 300
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 46
            positY = 270
        } else if totalSize.height <= 670 {
            hght = 42
            positY = 240
        } else {
            hght = 44
            positY = 285
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(hght)
        }
       return btn
    }()
    @objc func nextAnswerButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        UIView.animate(withDuration: 2.0) {
            self.progressBar.setProgress(self.progressCountGame, animated: true)
        }
        
        
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            sender.zoomOutClose()
            self.setupRandomButtonName()
            
            self.score.incrementCorrectAnswers()
            
            self.progressCountGame += self.progressCount
            
            self.trueAnswerButton.isUserInteractionEnabled = false
            self.nextAnswerButton.isUserInteractionEnabled = false
            
            self.nextQuestion()
        }
    }

//MARK: RepeatButton
    lazy var repeatButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 27
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 26
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 26
        } else if totalSize.height <= 670 {
            size = 22
        } else {
            size = 24
        }
        
        var positY: CGFloat!
        var fontName = "appleberry"
        switch Locale.current.languageCode {
        case "ru":
            positY = 3
            fontName = "appleberry"
        case "tr":
            positY = 2
            fontName = "KGRedHands"
            if totalSize.height >= 920 {
                size = 18
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 18
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 17
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 18
            } else if totalSize.height <= 670 {
                size = 16
            } else {
                size = 17
            }
        case "es":
            positY = 2
            fontName = "KGRedHands"
            if totalSize.height >= 920 {
                size = 21
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 17
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 18
            } else if totalSize.height <= 670 {
                size = 16
            } else {
                size = 17
            }
        default:
            positY = 3
            fontName = "appleberry"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: size)
        lbl.text = "Повторить".localized()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        repeatButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    lazy var repeatButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletGameBlue"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)

        var hght: CGFloat!
        var bttmPosit: CGFloat!
        if totalSize.height >= 920 {
            hght = 47
            bttmPosit = 270
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 47
            bttmPosit = 260
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 47
            bttmPosit = 240
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 44
            bttmPosit = 210
        } else if totalSize.height <= 670 {
            hght = 43
            bttmPosit = 177
        } else {
            hght = 44
            bttmPosit = 210
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(bttmPosit)
            make.height.equalTo(hght)
        }
        
       return btn
    }()
    @objc func repeatButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.displayQuestion()
            
            UIView.animate(withDuration: 0.4, animations: {
                self.dismissButtonDuringGame.alpha = 1
                self.playWordSoundButton.alpha = 1
            })
            
            self.repeatButtonLabel.zoomOutInfo()
            self.repeatButton.zoomOutInfo()
            self.dismissButtonLabel.zoomOutInfo()
            self.dismissButton.zoomOutInfo()
            
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                self.repeatButtonLabel.isHidden = true
                self.repeatButton.isHidden = true
                self.dismissButtonLabel.isHidden = true
                self.dismissButton.isHidden = true
            }
            
            self.progressCountGame = self.progressCount
            self.progressBar.progress = 0.0
        }
    }
    func nextQuestion() {
        if (isGameOver()) {
            displayScore()
        } else {
            displayQuestion()
        }
    }
//MARK: WaitingTimer
    func waitingTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.waitTime += 1
            
            if self.waitTime >= 8 {
                
                var animationWaitingName: String!
                animationWaitingName = self.arrayAnimationWait.randomElement()!
                self.startAnimation(viewName: self.animationView, jsonName: self.animationName!+animationWaitingName)
                
                self.waitTime = 0
            }
        }
    }

//MARK: Sounds
    lazy var playWordSoundButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "audioButton"), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        var topPosit: CGFloat!
        var trail: CGFloat!
        var size: CGFloat!
        if totalSize.height >= 920 {
            topPosit = 115
            trail = 55
            size = 50
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            topPosit = 120
            trail = 60
            size = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            topPosit = 125
            trail = 55
            size = 45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = 77
            trail = 120
            size = 47
        } else if totalSize.height <= 670 {
            topPosit = 60
            trail = 100
            size = 40
        } else {
            topPosit = 110
            trail = 50
            size = 40
        }
        
        btn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(topPosit)
            make.trailing.equalToSuperview().inset(trail)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        return btn
    }()
    
    @objc func playWordSoundButtonAction(sender: UIButton) {
        playWordSound()
    }
    
    
    func playPressSound() {
        guard let path = Bundle.main.path(forResource: "press", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func playLevelEndSound() {
        guard let path = Bundle.main.path(forResource: "confirmationFour", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func playWordSound() {
        guard let path = Bundle.main.path(forResource: soundWord, ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
//MARK: DismissButton
    lazy var dismissButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 27
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 26
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 26
        } else if totalSize.height <= 670 {
            size = 24
        } else {
            size = 24
        }
        
        var positY: CGFloat!
        var fontName = "appleberry"
        switch Locale.current.languageCode {
        case "ru":
            positY = 3
            fontName = "appleberry"
        case "tr":
            fontName = "KGRedHands"
            positY = 0
            if totalSize.height >= 920 {
                size = 18
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 18
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 17
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 18
            } else if totalSize.height <= 670 {
                size = 16
            } else {
                size = 17
            }
        case "es":
            fontName = "KGRedHands"
            positY = 0
            if totalSize.height >= 920 {
                size = 21
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 17
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 18
            } else if totalSize.height <= 670 {
                size = 16
            } else {
                size = 17
            }
        default:
            positY = 3
            fontName = "appleberry"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: size)
        lbl.text = "Закончить".localized()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        dismissButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletGameBlue"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)

        var hght: CGFloat!
        var bttm: CGFloat!
        if totalSize.height >= 920 {
            hght = 47
            bttm = 150
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 47
            bttm = 150
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 47
            bttm = 130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 44
            bttm = 120
        } else if totalSize.height <= 670 {
            hght = 43
            bttm = 90
        } else {
            hght = 44
            bttm = 120
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(bttm)
            make.height.equalTo(hght)
        }
        return btn
    }()
    
    @objc func dismissButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.dismiss(animated: true, completion: nil)
        }
    }
//MARK: - DismissButtonDuringGame
    lazy var dismissButtonDuringGame: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeButtonChalk"), for: .normal)
        btn.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        
        var positY: CGFloat!
        var positX: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 920 {
            positY = -417
            positX = 167
            wdth = 31
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -400
            positX = 160
            wdth = 32
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -375
            positX = 155
            wdth = 32
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -268
            positX = 127
            wdth = 32
        } else if totalSize.height <= 670 {
            positY = -253
            positX = 120
            wdth = 27
        } else {
            positY = -360
            positX = 152
            wdth = 30
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.height.equalTo(wdth)
        }
        
        return btn
    }()
    @objc func dismissButtonActionDuringGame(sender: UIButton) {
        playPressSound()
        
        switch Locale.current.languageCode {
        case "ru":
            questionsModel.resetQuestionNumber()
        case "tr":
            questionsModelTR.resetQuestionNumber()
        case "es":
            questionsModelES.resetQuestionNumber()
        default:
            questionsModel.resetQuestionNumber()
        }
        
//        questionsModel.resetQuestionNumber()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
