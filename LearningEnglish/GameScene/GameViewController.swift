//
//  GameViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 28.12.2021.
//

import UIKit
import GameKit
import AVFoundation
import SnapKit
import Lottie

class GameViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var animationName = UserDefaults.standard.string(forKey: "animationName")
    var animationView = AnimationView()
    
    var localArray: [String] = []
    var saveArrayWord = UserDefaults.standard.array(forKey: "saveArrayWord")
    
    var questionsModel = QuestionModel()
    var questionsModelTR = QuestionModelTR()
    var questionsModelES = QuestionModelES()
    
    let score = ScoreModel()
    
    var arrayPositionButton: [Int] = []
    
    var arrayAnimationWait = ["Wait", "Wait2", "Wait3"]
    
    var waitTime: Int = 0
    var trueAnswer: Int = 0
    
    var randomPositionFirstButton: Int = 0
    var randomPositionSecondButton: Int = 0
    var randomPositionThirdButton: Int = 0
    var randomPositionFourthButton: Int = 0
    
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
        
//        dump(saveArrayWord)
        
        uploadArrayPositionButton()
        waitingTimer()
        
        self.view.backgroundColor = #colorLiteral(red: 0.05953502964, green: 0.3432602451, blue: 0.4998384456, alpha: 1)
        backgroundChalk.isHidden = false
        blackboard.isHidden = false
        
        displayQuestion()
        progressCountGame = progressCount
        progressBar.isHidden = false
        progressBar.progress = 0.0
        
        playWordSoundButton.addTarget(self, action: #selector(playWordSoundButtonAction(sender:)), for: .touchUpInside)
        
        randomButtonPosition()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.firstButton.addTarget(self, action: #selector(self.firstButtonAction(sender:)), for: .touchUpInside)
            self.secondButton.addTarget(self, action: #selector(self.secondButtonAction(sender:)), for: .touchUpInside)
            self.thirdButton.addTarget(self, action: #selector(self.thirdButtonAction(sender:)), for: .touchUpInside)
            self.fourthButton.addTarget(self, action: #selector(self.fourthButtonAction(sender:)), for: .touchUpInside)
            
            self.firstButtonLabel.isHidden = false
            self.firstButtonLabel.zoomInInfo()
            self.secondButtonLabel.isHidden = false
            self.secondButtonLabel.zoomInInfo()
            self.thirdButtonLabel.isHidden = false
            self.thirdButtonLabel.zoomInInfo()
            self.fourthButtonLabel.isHidden = false
            self.fourthButtonLabel.zoomInInfo()
        }
        
        repeatButtonLabel.isHidden = true
        repeatButton.isHidden = true
        repeatButton.addTarget(self, action: #selector(repeatButtonAction(sender:)), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        dismissButton.isHidden = true
        dismissButtonLabel.isHidden = false
        dismissButtonDuringGame.addTarget(self, action: #selector(dismissButtonActionDuringGame(sender:)), for: .touchUpInside)
        
        animationHero()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isGameOver() -> Bool {
        return score.getQuestionsAsked() >= numberOfQuestionPerRound
    }
    
//MARK: - UploadArrayPositionButton
    func uploadArrayPositionButton() {
        if totalSize.height >= 920 {
            arrayPositionButton = [325, 250, 175, 100]
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            arrayPositionButton = [325, 250, 175, 100]
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            arrayPositionButton = [310, 245, 180, 115]
        } else if totalSize.height <= 670 {
            arrayPositionButton = [290, 231, 173, 114]
        } else {
            arrayPositionButton = [310, 245, 180, 115]
        }
    }
//MARK: DisplayQuestion
    func displayQuestion() {
        switch Locale.current.languageCode {
        case "ru":
            currentQuestion = questionsModel.getRandomQuestion()
        case "tr":
            currentQuestion = questionsModelTR.getRandomQuestion()
        case "es":
            currentQuestion = questionsModelES.getRandomQuestion()
        default:
            currentQuestion = questionsModel.getRandomQuestion()
        }
        
        if let question = currentQuestion {
            let choices = question.getChoices()
            
            
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
                self.playWordSound()
            }
            
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.firstButtonLabel.text = choices[0]
                self.secondButtonLabel.text = choices[1]
                self.thirdButtonLabel.text = choices[2]
                self.fourthButtonLabel.text = choices[3]
            }
            
            if (score.getQuestionsAsked() == numberOfQuestionPerRound - 1) {
//                repeatButton.setTitle("Конец", for: .normal)
            } else {
//                repeatButton.setTitle("Следующий вопрос", for: .normal)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.firstButton.isUserInteractionEnabled = true
            self.secondButton.isUserInteractionEnabled = true
            self.thirdButton.isUserInteractionEnabled = true
            self.fourthButton.isUserInteractionEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.firstButton.isHidden = false
            self.secondButton.isHidden = false
            self.thirdButton.isHidden = false
            self.fourthButton.isHidden = false
        }
        
//        feedbackLabel.isHidden = true
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
        
        score.saveProgress()
        UserDefaults.standard.set(saveArrayWord?.count, forKey: "totalWordsLearned")
        
        playLevelEndSound()
        
        let txt = score.getScore()
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.playResultSound()
            self.resultLabelBackground.isHidden = false
            self.resultLabel.isHidden = false
            self.resultLabel.text = txt
            self.resultLabel.zoomInInfo()
            self.resultLabelBackground.zoomInInfo()
        }
        
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
        
        
        firstButton.isHidden = true
        secondButton.isHidden = true
        thirdButton.isHidden = true
        fourthButton.isHidden = true
        
        //animation
        let resultInt = score.getScoreInt()
        
        waitTime = 0
        if resultInt == 1 {
            startAnimation(viewName: animationView, jsonName: animationName!+"Happy")
        } else if resultInt == 2 {
            startAnimation(viewName: animationView, jsonName: animationName!+"Wait")
        } else {
            startAnimation(viewName: animationView, jsonName: animationName!+"Fail")
        }
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
        } else if animationName == "misterTomato" {
            imgName = "backgroundFoodGame"
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
        animationView.layer.shadowRadius = 8
        animationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationView.layer.shadowOpacity = 0.5
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
//MARK: ResultLabel
    lazy var resultLabel: UILabel = {
        
        var size: CGFloat!
        let positY: CGFloat!
        var leadTrail: CGFloat!
        if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 25
            positY = 90
            leadTrail = 70
        } else if totalSize.height <= 670 {
            size = 25
            positY = 90
            leadTrail = 60
        } else {
            size = 30
            positY = 100
            leadTrail = 45
        }
        
        var fontName = "appleberry"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "appleberry"
        case "tr":
            fontName = "KGSummerStormSmooth"
            if totalSize.height >= 890 {
                size = 20
                leadTrail = 60
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 18
                leadTrail = 65
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 19
                leadTrail = 75
            } else if totalSize.height <= 670 {
                size = 17
                leadTrail = 70
            } else {
                size = 18
                leadTrail = 60
            }
        case "es":
            fontName = "KGSummerStormSmooth"
            if totalSize.height >= 890 {
                size = 20
                leadTrail = 60
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 18
                leadTrail = 65
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 19
                leadTrail = 75
            } else if totalSize.height <= 670 {
                size = 17
                leadTrail = 70
            } else {
                size = 18
                leadTrail = 60
            }
        default:
            fontName = "appleberry"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: size)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.cornerRadius = 15
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOffset = CGSize(width: 0, height: 10)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
            make.leading.trailing.equalToSuperview().inset(leadTrail)
        }
        return lbl
    }()
    lazy var resultLabelBackground: UIImageView = {
        let img = UIImageView(image: UIImage(named: "resultLabelBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 6
        img.layer.shadowOffset = CGSize(width: 0, height: 10)
        img.layer.shadowOpacity = 0.3
        self.view.addSubview(img)
        
        let leadTrail: CGFloat!
        let positY: CGFloat!
        if totalSize.height >= 671 && totalSize.height <= 800 {
            leadTrail = 50
            positY = 90
        } else if totalSize.height <= 671 {
            leadTrail = 45
            positY = 90
        } else {
            leadTrail = 40
            positY = 100
        }
        
        img.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(leadTrail)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    
//MARK: ProgressBar
    lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.trackTintColor = #colorLiteral(red: 0.05198650897, green: 0.2997378504, blue: 0.4364633056, alpha: 0)
        progress.progressTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        self.view.addSubview(progress)
        
        
        
        progress.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(5)
        }
        
        return progress
    }()
//MARK: RandomButtonPosition
    func randomButtonPosition() {
        //1
        randomPositionFirstButton = arrayPositionButton.randomElement()!
        
        guard let chosenIndexOne = self.arrayPositionButton.firstIndex(where: { $0 == randomPositionFirstButton }) else { return }
        
        arrayPositionButton.remove(at: chosenIndexOne)
        
        //2
        randomPositionSecondButton = arrayPositionButton.randomElement()!
        
        guard let chosenIndexTwo = self.arrayPositionButton.firstIndex(where: { $0 == randomPositionSecondButton }) else { return }
        
        arrayPositionButton.remove(at: chosenIndexTwo)
        
        //3
        randomPositionThirdButton = arrayPositionButton.randomElement()!
        
        guard let chosenIndexThree = self.arrayPositionButton.firstIndex(where: { $0 == randomPositionThirdButton }) else { return }
        
        arrayPositionButton.remove(at: chosenIndexThree)
        
        //4
        randomPositionFourthButton = arrayPositionButton.randomElement()!
    }
    
//MARK: FirstButton
    lazy var firstButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 27
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 24
        } else {
            size = 22
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
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
            }
        case "es":
            positY = 2
            fontName = "KGRedHands"
            
            if totalSize.height >= 920 {
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
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
        firstButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    lazy var firstButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletPlayGame"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        if totalSize.height >= 920 {
            hght = 55
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 50
        } else if totalSize.height <= 670 {
            hght = 47
        } else {
            hght = 50
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(randomPositionFirstButton)
            make.height.equalTo(hght)
//            make.width.equalTo(300)
        }
        
        return btn
    }()
    @objc func firstButtonAction(sender: UIButton) {
        waitTime = 0
        
        sender.zoomOut()
            
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            sender.zoomOutClose()
        }
            
        if let question = currentQuestion, let answer = firstButtonLabel.text {
    
            let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == answer })

            if (question.validateAnswer(to: answer)) {
                
                trueAnswer += 1
                
                playWinSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Win")
                
                if isChosenSaveArray == false {
                    
                    localArray.append(answer)
                    saveArrayWord! += localArray
                    localArray.removeAll()
                    
                    UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                }
                
                firstButton.layer.shadowOpacity = 0.6
                secondButton.alpha = 0.4
                thirdButton.alpha = 0.4
                fourthButton.alpha = 0.4
                
                score.incrementCorrectAnswers()
                
            } else {
                
                trueAnswer = 0
                
                playFailSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Fail")
                
                firstButton.alpha = 0.4
                
                if question.validateAnswer(to: (secondButtonLabel.text)!) {
                    thirdButton.alpha = 0.4
                    fourthButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (secondButtonLabel.text)! })

                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (secondButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                } else if question.validateAnswer(to: (thirdButtonLabel.text)!) {
                    secondButton.alpha = 0.4
                    fourthButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (thirdButtonLabel.text)! })

                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (thirdButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                } else if question.validateAnswer(to: (fourthButtonLabel.text)!) {
                    secondButton.alpha = 0.4
                    thirdButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (fourthButtonLabel.text)! })
          
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (fourthButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                }
                
                score.incrementIncorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.82, green:0.40, blue:0.26, alpha:1.0)
//                feedbackLabel.text = "Не правильно"
            }
            
            colorProgressBar()
            UIView.animate(withDuration: 2.0) {
                self.progressBar.setProgress(self.progressCountGame, animated: true)
            }
            progressCountGame += progressCount
            
            firstButton.isUserInteractionEnabled = false
            secondButton.isUserInteractionEnabled = false
            thirdButton.isUserInteractionEnabled = false
            fourthButton.isUserInteractionEnabled = false
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                self.nextQuestion()
            }
            
//            feedbackLabel.isHidden = false
        }
    }
    
//MARK: SecondButton
    lazy var secondButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 27
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 24
        } else {
            size = 22
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
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
            }
        case "es":
            positY = 2
            fontName = "KGRedHands"
            
            if totalSize.height >= 920 {
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
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
        secondButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    lazy var secondButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletPlayGame"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        if totalSize.height >= 920 {
            hght = 55
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 50
        } else if totalSize.height <= 670 {
            hght = 47
        } else {
            hght = 50
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(randomPositionSecondButton)
            make.height.equalTo(hght)
//            make.width.equalTo(300)
        }
        
        return btn
    }()
    @objc func secondButtonAction(sender: UIButton) {
        waitTime = 0
        
        sender.zoomOut()
        
            
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            sender.zoomOutClose()
        }
        
        if let question = currentQuestion, let answer = secondButtonLabel.text {
            
            let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == answer })
                
            if (question.validateAnswer(to: answer)) {
                
                trueAnswer += 1
                
                playWinSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Win")
                
                if isChosenSaveArray == false {
                    
                    localArray.append(answer)
                    saveArrayWord! += localArray
                    localArray.removeAll()
                    
                    UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                }
                
                secondButton.layer.shadowOpacity = 0.6
                firstButton.alpha = 0.4
                thirdButton.alpha = 0.4
                fourthButton.alpha = 0.4
                
                score.incrementCorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.15, green:0.61, blue:0.61, alpha:1.0)
//                feedbackLabel.text = "Правильно!"
            } else {
                
                trueAnswer = 0
                
                playFailSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Fail")
                
                secondButton.alpha = 0.4
                
                if question.validateAnswer(to: (firstButtonLabel.text)!) {
                    thirdButton.alpha = 0.4
                    fourthButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (firstButtonLabel.text)! })

                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (firstButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                    
                } else if question.validateAnswer(to: (thirdButtonLabel.text)!) {
                    firstButton.alpha = 0.4
                    fourthButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (thirdButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (thirdButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                    
                } else if question.validateAnswer(to: (fourthButtonLabel.text)!) {
                    firstButton.alpha = 0.4
                    thirdButton.alpha = 0.4
                
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (fourthButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (fourthButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                }
                
                score.incrementIncorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.82, green:0.40, blue:0.26, alpha:1.0)
//                feedbackLabel.text = "Не правильно"
            }
            
            colorProgressBar()
            UIView.animate(withDuration: 2.0) {
                self.progressBar.setProgress(self.progressCountGame, animated: true)
            }
            progressCountGame += progressCount
            
            firstButton.isUserInteractionEnabled = false
            secondButton.isUserInteractionEnabled = false
            thirdButton.isUserInteractionEnabled = false
            fourthButton.isUserInteractionEnabled = false
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                self.nextQuestion()
            }
            
//            feedbackLabel.isHidden = false
        }
    }
//MARK: ThirdButton
    lazy var thirdButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 27
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 24
        } else {
            size = 22
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
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
            }
        case "es":
            positY = 2
            fontName = "KGRedHands"
            
            if totalSize.height >= 920 {
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
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
        thirdButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    lazy var thirdButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletPlayGame"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        if totalSize.height >= 920 {
            hght = 55
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 50
        } else if totalSize.height <= 670 {
            hght = 47
        } else {
            hght = 50
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(randomPositionThirdButton)
            make.height.equalTo(hght)
//            make.width.equalTo(300)
        }
        
        return btn
    }()
    @objc func thirdButtonAction(sender: UIButton) {
        waitTime = 0
        
        sender.zoomOut()
        
            
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            sender.zoomOutClose()
        }
        
        if let question = currentQuestion, let answer = thirdButtonLabel.text {

            let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == answer })
            
            if (question.validateAnswer(to: answer)) {
          
                trueAnswer += 1
                
                playWinSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Win")
                
                if isChosenSaveArray == false {
                    
                    localArray.append(answer)
                    saveArrayWord! += localArray
                    localArray.removeAll()
                    
                    UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                }
                
                thirdButton.layer.shadowOpacity = 0.6
                firstButton.alpha = 0.4
                secondButton.alpha = 0.4
                fourthButton.alpha = 0.4
                
                score.incrementCorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.15, green:0.61, blue:0.61, alpha:1.0)
//                feedbackLabel.text = "Правильно!"
            } else {
                
                trueAnswer = 0
                
                playFailSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Fail")
                
                thirdButton.alpha = 0.4
                
                if question.validateAnswer(to: (firstButtonLabel.text)!) {
                    secondButton.alpha = 0.4
                    fourthButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (firstButtonLabel.text)! })

                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (firstButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                } else if question.validateAnswer(to: (secondButtonLabel.text)!) {
                    firstButton.alpha = 0.4
                    fourthButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (secondButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (secondButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                } else if question.validateAnswer(to: (fourthButtonLabel.text)!) {
                    firstButton.alpha = 0.4
                    secondButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (fourthButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (fourthButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                }
                
                score.incrementIncorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.82, green:0.40, blue:0.26, alpha:1.0)
//                feedbackLabel.text = "Не правильно"
            }
            
            colorProgressBar()
            UIView.animate(withDuration: 2.0) {
                self.progressBar.setProgress(self.progressCountGame, animated: true)
            }
            progressCountGame += progressCount
            
            firstButton.isUserInteractionEnabled = false
            secondButton.isUserInteractionEnabled = false
            thirdButton.isUserInteractionEnabled = false
            fourthButton.isUserInteractionEnabled = false
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                self.nextQuestion()
            }
            
//            feedbackLabel.isHidden = false
        }
    }
//MARK: FourthButton
    lazy var fourthButtonLabel: UILabel = {
        
        var size: CGFloat!
        if totalSize.height >= 920 {
            size = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 27
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 24
        } else {
            size = 22
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
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
            }
        case "es":
            positY = 2
            fontName = "KGRedHands"
            
            if totalSize.height >= 920 {
                size = 22
            } else if totalSize.height >= 890 && totalSize.height <= 919 {
                size = 21
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                size = 19
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                size = 20
            } else if totalSize.height <= 670 {
                size = 18
            } else {
                size = 18
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
        fourthButton.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    lazy var fourthButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabletPlayGame"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.layer.zPosition = 10
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        if totalSize.height >= 920 {
            hght = 55
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 50
        } else if totalSize.height <= 670 {
            hght = 47
        } else {
            hght = 50
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(randomPositionFourthButton)
            make.height.equalTo(hght)
//            make.width.equalTo(300)
        }
        
        return btn
    }()
    @objc func fourthButtonAction(sender: UIButton) {
        waitTime = 0
        
        sender.zoomOut()
        
            
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            sender.zoomOutClose()
        }
        
        if let question = currentQuestion, let answer = fourthButtonLabel.text {

            let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == answer })
            
            if (question.validateAnswer(to: answer)) {
                trueAnswer += 1
                
                playWinSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Win")
          
                if isChosenSaveArray == false {
                    
                    localArray.append(answer)
                    saveArrayWord! += localArray
                    localArray.removeAll()
                    
                    UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                }
                
                fourthButton.layer.shadowOpacity = 0.6
                firstButton.alpha = 0.4
                secondButton.alpha = 0.4
                thirdButton.alpha = 0.4
                
                score.incrementCorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.15, green:0.61, blue:0.61, alpha:1.0)
//                feedbackLabel.text = "Правильно!"
            } else {
                trueAnswer = 0
                
                playFailSound()
                startAnimation(viewName: animationView, jsonName: animationName!+"Fail")
                
                fourthButton.alpha = 0.4
                
                if question.validateAnswer(to: (firstButtonLabel.text)!) {
                    secondButton.alpha = 0.4
                    thirdButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (firstButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (firstButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                } else if question.validateAnswer(to: (secondButtonLabel.text)!) {
                    firstButton.alpha = 0.4
                    thirdButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (secondButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (secondButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                } else if question.validateAnswer(to: (thirdButtonLabel.text)!) {
                    firstButton.alpha = 0.4
                    secondButton.alpha = 0.4
                    
                    let isChosenSaveArray = saveArrayWord?.contains(where: { $0 as! String == (thirdButtonLabel.text)! })
                    
                    if isChosenSaveArray == true {
                        
                        guard let chosenIndex = self.saveArrayWord?.firstIndex(where: { $0 as! String == (thirdButtonLabel.text)! }) else { return }
                        
                        saveArrayWord?.remove(at: chosenIndex)
                        UserDefaults.standard.set(saveArrayWord, forKey: "saveArrayWord")
                    }
                }
                
                score.incrementIncorrectAnswers()
//                feedbackLabel.textColor = UIColor(red:0.82, green:0.40, blue:0.26, alpha:1.0)
//                feedbackLabel.text = "Не правильно"
            }
            
            colorProgressBar()
            UIView.animate(withDuration: 2.0) {
                self.progressBar.setProgress(self.progressCountGame, animated: true)
            }
            progressCountGame += progressCount
            
            firstButton.isUserInteractionEnabled = false
            secondButton.isUserInteractionEnabled = false
            thirdButton.isUserInteractionEnabled = false
            fourthButton.isUserInteractionEnabled = false
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                self.nextQuestion()
            }
            
//            feedbackLabel.isHidden = false
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
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 24
        } else {
            size = 22
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
            bttmPosit = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 47
            bttmPosit = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 47
            bttmPosit = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 44
            bttmPosit = 90
        } else if totalSize.height <= 670 {
            hght = 43
            bttmPosit = 77
        } else {
            hght = 44
            bttmPosit = 110
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
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            
            UIView.animate(withDuration: 0.4, animations: {
                self.dismissButtonDuringGame.alpha = 1
                self.playWordSoundButton.alpha = 1
            })
            
            self.displayQuestion()
        
            self.repeatButtonLabel.zoomOutInfo()
            self.repeatButton.zoomOutInfo()
            self.resultLabelBackground.zoomOutInfo()
            self.resultLabel.zoomOutInfo()
            self.dismissButtonLabel.zoomOutInfo()
            self.dismissButton.zoomOutInfo()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            self.repeatButtonLabel.isHidden = true
            self.repeatButton.isHidden = true
            self.resultLabelBackground.isHidden = true
            self.resultLabel.isHidden = true
            self.dismissButtonLabel.isHidden = true
            self.dismissButton.isHidden = true
        }
        
            self.progressCountGame = self.progressCount
            self.progressBar.progress = 0.0
        
        
        
            self.firstButton.alpha = 1
            self.secondButton.alpha = 1
            self.thirdButton.alpha = 1
            self.fourthButton.alpha = 1
        
            self.firstButton.layer.shadowOpacity = 0.3
            self.secondButton.layer.shadowOpacity = 0.3
            self.thirdButton.layer.shadowOpacity = 0.3
            self.fourthButton.layer.shadowOpacity = 0.3
        }
    }
    
    func nextQuestion() {
        if (isGameOver()) {
            displayScore()
        } else {
            displayQuestion()
            firstButton.alpha = 1
            secondButton.alpha = 1
            thirdButton.alpha = 1
            fourthButton.alpha = 1
            
            firstButton.layer.shadowOpacity = 0.3
            secondButton.layer.shadowOpacity = 0.3
            thirdButton.layer.shadowOpacity = 0.3
            fourthButton.layer.shadowOpacity = 0.3
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
//MARK: ColorProgressBar
    func colorProgressBar() {
        if trueAnswer == 0 {
            progressBar.progressTintColor = #colorLiteral(red: 1, green: 0.04454364628, blue: 0, alpha: 1)
        } else if trueAnswer == 1 {
            progressBar.progressTintColor = #colorLiteral(red: 1, green: 0.04454364628, blue: 0, alpha: 1)
        } else if trueAnswer == 2 {
            progressBar.progressTintColor = #colorLiteral(red: 1, green: 0.5145392418, blue: 0.0004137319338, alpha: 1)
        } else if trueAnswer == 3 {
            progressBar.progressTintColor = #colorLiteral(red: 1, green: 0.8212612271, blue: 0, alpha: 1)
        } else if trueAnswer == 4 {
            progressBar.progressTintColor = #colorLiteral(red: 0.7187359333, green: 0.9968844056, blue: 0.002284622286, alpha: 1)
        } else if trueAnswer == 5 {
            progressBar.progressTintColor = #colorLiteral(red: 0.06075140089, green: 1, blue: 0, alpha: 1)
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
    
    func playWinSound() {
        guard let path = Bundle.main.path(forResource: "soundWin", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playFailSound() {
        guard let path = Bundle.main.path(forResource: "soundFail", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playResultSound() {
        guard let path = Bundle.main.path(forResource: "confirmationThree", ofType:"wav") else {
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
            size = 24
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            size = 24
        } else {
            size = 22
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
            bttm = 50
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            hght = 47
            bttm = 50
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            hght = 47
            bttm = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 44
            bttm = 30
        } else if totalSize.height <= 670 {
            hght = 43
            bttm = 23
        } else {
            hght = 44
            bttm = 50
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
            
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
        
        score.saveProgress()
        UserDefaults.standard.set(saveArrayWord?.count, forKey: "totalWordsLearned")
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "secondaryMenuDismiss"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
