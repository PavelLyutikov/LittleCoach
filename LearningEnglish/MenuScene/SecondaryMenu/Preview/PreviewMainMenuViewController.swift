//
//  PreviewMainMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 18.03.2022.
//

import UIKit
import AVFoundation
import Lottie

class PreviewMainMenuViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    let countProgress = 5
    
    let animationGirlViewOne = AnimationView(name: "basicGirlWait")
    let animationGirlViewTwo = AnimationView(name: "basicGirlPreview")
    let animationGirlViewThree = AnimationView(name: "basicGirlPreviewTwo")
    
    let shapeLAyerBasic = CAShapeLayer()
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    var player: AVAudioPlayer?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isThirdPressButtonNext")
        UserDefaults.standard.set(false, forKey: "isSecondPressButtonNext")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonNext")

        setupView()
    }
//MARK: - SetupView
    func setupView() {
        backgroundShadowImage.isHidden = false
        blackboard.isHidden = false
        totalWordsLearnedLabel.isHidden = false
        englishLevelLabel.isHidden = false
        davidingLineImage.isHidden = false
        labelPreviewOne.isHidden = false
        labelPreviewTwo.isHidden = false
        labelPreviewThree.isHidden = false
        buttonBasicCircleProgress()
        
        buttonBasic.addTarget(self, action: #selector(buttonBasicAction(sender:)), for: .touchUpInside)
        
        animationGirlOne()
        animationGirlTwo()
        animationGirlThree()
        nextButton.addTarget(self, action: #selector(nextButtonAction(sender:)), for: .touchUpInside)
        

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.4, animations: {
                self.backgroundShadowImage.alpha = 0.8
                self.animationGirlViewOne.alpha = 1
            })
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.labelPreviewOne.alpha = 1
                    self.playConfirmationSound()
                })
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.nextButton.alpha = 1
                    })
                }
            }
            
        }
        
        
    }
    
//MARK: - BackgroundShadow
    lazy var backgroundShadowImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "notificationBackground"))
        img.contentMode = .scaleAspectFill
        img.alpha = 0
        img.transform = CGAffineTransform(rotationAngle: CGFloat(1.57))
        self.view.addSubview(img)

        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(650)
        }

        return img
    }()
//MARK: Blackboard
    lazy var blackboard: UIImageView = {
        let img = UIImageView(image: UIImage(named: "mainMenuBlackboard"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        img.alpha = 0
        self.view.addSubview(img)
        
        let wdth = totalSize.width - 5
        
        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = -345
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -330
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -310
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -298
        } else  if totalSize.height <= 670 {
            positY = -270
        } else {
            positY = -295
        }
        
        img.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.centerX.equalToSuperview()
            make.width.equalTo(wdth)
        }
        
        return img
    }()
    //TotalWordsLearnedLabel
    lazy var totalWordsLearnedLabel: UILabel = {
        
        var positY: CGFloat!
        var positX: CGFloat!
        var size: CGFloat!
        var lineSpace: CGFloat!
        if totalSize.height >= 890 {
            positY = -20
            positX = -100
            size = 20
            lineSpace = 1.3
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -23
            positX = -90
            size = 18
            lineSpace = 1.3
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 0
            positX = -80
            size = 22
            lineSpace = 1.15
        } else if totalSize.height <= 670 {
            positY = 0
            positX = -80
            size = 19
            lineSpace = 1.3
        } else {
            positY = -23
            positX = -80
            size = 18
            lineSpace = 1.3
        }
        
        //Locate
            var fontName = "lcChalk"
            switch Locale.current.languageCode {

            case "ru":
                fontName = "lcChalk"

            case "tr":
                fontName = "Lorjuk"
                
                if totalSize.height >= 890 {
                    positY = -15
                    positX = -74
                    size = 29
                    lineSpace = 1.0
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    positY = -20
                    positX = -74
                    size = 27
                    lineSpace = 1.0
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    positY = 3
                    positX = -70
                    size = 29
                    lineSpace = 1.0
                } else if totalSize.height <= 670 {
                    positY = 0
                    positX = -67
                    size = 26
                    lineSpace = 1.0
                } else {
                    positY = -21
                    positX = -67
                    size = 26
                    lineSpace = 1.0
                }
            case "es":
                fontName = "Lorjuk"
                
                if totalSize.height >= 890 {
                    positY = -15
                    positX = -100
                    size = 29
                    lineSpace = 1.0
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    positY = -20
                    positX = -90
                    size = 27
                    lineSpace = 1.0
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    positY = 3
                    positX = -80
                    size = 29
                    lineSpace = 1.0
                } else if totalSize.height <= 670 {
                    positY = 0
                    positX = -80
                    size = 26
                    lineSpace = 1.0
                } else {
                    positY = -21
                    positX = -80
                    size = 26
                    lineSpace = 1.0
                }
            default:
                fontName = "lcChalk"
            }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: size)
        lbl.text = "Слов в запасе:".localized() + "\n  2999"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.setLineSpacing(lineSpacing: 0.0, lineHeightMultiple: lineSpace)
        self.view.addSubview(lbl)
        blackboard.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.centerXWithinMargins.equalTo(positX)
        }
        
        return lbl
    }()
    
//englishLevelLabel
    lazy var englishLevelLabel: UILabel = {
        
        var positY: CGFloat!
        var positX: CGFloat!
        var size: CGFloat!
        if totalSize.height >= 890 {
            positY = -15
            positX = 110
            size = 33
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -20
            positX = 110
            size = 33
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 2
            positX = 115
            size = 33
        } else if totalSize.height <= 670 {
            positY = 3
            positX = 100
            size = 30
        } else {
            positY = -17
            positX = 110
            size = 33
        }
        
        //Locate
            var fontName = "lcChalk"
            switch Locale.current.languageCode {
            case "ru":
                fontName = "lcChalk"
            case "tr":
                fontName = "Lorjuk"
    
                if totalSize.height >= 890 {
                    size = 39
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    size = 39
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    size = 39
                } else if totalSize.height <= 670 {
                    size = 36
                } else {
                    size = 39
                }
            case "es":
                fontName = "Lorjuk"
    
                if totalSize.height >= 890 {
                    size = 39
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    size = 39
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    size = 39
                } else if totalSize.height <= 670 {
                    size = 36
                } else {
                    size = 39
                }
            default:
                fontName = "lcChalk"
            }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: size)
        lbl.text = "A1"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        blackboard.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.centerXWithinMargins.equalTo(positX)
        }
        
        return lbl
    }()
    
//LINE
    lazy var davidingLineImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "davidingLine"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        blackboard.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positY = -18
            positX = 30
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -22
            positX = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 0
            positX = 40
        } else if totalSize.height <= 670 {
            positY = -2
            positX = 30
        } else {
            positY = -21
            positX = 30
        }
        
        img.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    
//MARK: - Label
    lazy var labelPreviewOne: UIImageView = {
        
        var nameImg = "labelPreviewOne"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewOne"
        case "tr":
            nameImg = "labelPreviewOneTR"
        case "es":
            nameImg = "labelPreviewOneES"
        default:
            nameImg = "labelPreviewOne"
        }
        
        let img = UIImageView(image: UIImage(named: nameImg))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 7
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        img.alpha = 0
        self.view.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 250
            positX = -70
            positY = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 250
            positX = -80
            positY = 90
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 230
            positX = -70
            positY = 85
        } else if totalSize.height <= 670 {
            wdth = 230
            positX = -70
            positY = 70
        } else {
            wdth = 230
            positX = -70
            positY = 85
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(30)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
    lazy var labelPreviewTwo: UIImageView = {
        
        var nameImg = "labelPreview"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreview"
        case "tr":
            nameImg = "labelPreviewTR"
        case "es":
            nameImg = "labelPreviewES"
        default:
            nameImg = "labelPreview"
        }
        
        let img = UIImageView(image: UIImage(named: nameImg))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 7
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        img.alpha = 0
        self.view.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 250
            positX = -50
            positY = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 250
            positX = -50
            positY = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 250
            positX = -50
            positY = 40
        } else if totalSize.height <= 670 {
            wdth = 230
            positX = -50
            positY = 50
        } else {
            wdth = 230
            positX = -50
            positY = 20
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
    lazy var labelPreviewThree: UIImageView = {
        
        var nameImg = "labelPreviewTwo"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewTwo"
        case "tr":
            nameImg = "labelPreviewTwoTR"
        case "es":
            nameImg = "labelPreviewTwoES"
        default:
            nameImg = "labelPreviewTwo"
        }
        
        let img = UIImageView(image: UIImage(named: nameImg))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 7
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        img.alpha = 0
        self.view.addSubview(img)
        
        var wdth: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 250
            positY = -100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 250
            positY = -100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 250
            positY = -80
        } else if totalSize.height <= 670 {
            wdth = 230
            positY = -80
        } else {
            wdth = 240
            positY = -90
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
//MARK: BasicButton
    lazy var basicButtonView: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        var positY: CGFloat!
        if self.totalSize.height >= 920 {
            positY = 142
        } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
            positY = 137
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 153
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 166
        } else if totalSize.height <= 670 {
            positY = 151
        } else {
            positY = 147
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.centerXWithinMargins.equalTo(5)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var buttonBasic: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "basicButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        self.view.addSubview(btn)
        basicButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        return btn
    }()
    @objc func buttonBasicAction(sender: UIButton) {
        UserDefaults.standard.set("basicGirl", forKey: "animationName")

        playPressSound()
        
        let vc = BasicMenuViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonBasicCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 10, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        let circularPath2 = UIBezierPath(arcCenter: view.center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -430
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -415
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -390
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -335
            positX = -108
        } else if totalSize.height <= 670 {
            positY = -300
            positX = -88
        } else {
            positY = -373
            positX = -89
        }
        
        let progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = #colorLiteral(red: 0, green: 0.3544611674, blue: 0.440676345, alpha: 1)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.position = CGPoint(x: positX, y: positY)
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 100.0
        progressLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        progressLayer.shadowRadius = 5
        progressLayer.shadowOffset = CGSize(width: 0, height: 0)
        progressLayer.shadowOpacity = 0.3
        view.layer.addSublayer(progressLayer)
        basicButtonView.layer.addSublayer(progressLayer)

        shapeLAyerBasic.path = circularPath2.cgPath
        shapeLAyerBasic.position = CGPoint(x: positX, y: positY)
        shapeLAyerBasic.fillColor = UIColor.clear.cgColor
        shapeLAyerBasic.strokeColor = UIColor.green.cgColor
        shapeLAyerBasic.lineWidth = 7
        shapeLAyerBasic.lineCap = .round
        shapeLAyerBasic.strokeEnd = 0
        shapeLAyerBasic.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        view.layer.addSublayer(shapeLAyerBasic)
        basicButtonView.layer.addSublayer(shapeLAyerBasic)
    }
    func playProgress(){
        basicAnimation.fromValue = basicAnimation.toValue
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.both

        if CGFloat(countProgress) > 8 || CGFloat(countProgress) < 0 {
            return
        }
        basicAnimation.toValue = CGFloat(countProgress)/8
        shapeLAyerBasic.add(basicAnimation, forKey: "urSoBasic")
    }
    
//MARK: - NextButton
    lazy var nextButton: UIButton = {
        
        var nameImg = "goodButton"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "goodButton"
        case "tr":
            nameImg = "goodButtonTR"
        case "es":
            nameImg = "goodButtonES"
        default:
            nameImg = "goodButton"
        }
        
        let btn = UIButton()
        btn.setImage(UIImage(named: nameImg), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.alpha = 0
        self.view.addSubview(btn)
        
        var hght: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 830 {
            hght = 45
            positY = 350
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            hght = 45
            positY = 300
        } else if totalSize.height <= 670 {
            hght = 42
            positY = 270
        } else {
            hght = 42
            positY = 320
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(hght)
        }

        return btn
    }()
    @objc func nextButtonAction(sender: UIButton) {
        playPressSound()
    
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonNext") {
            sender.zoomOut()
            UIView.animate(withDuration: 0.4, animations: {
                self.nextButton.alpha = 0
                self.labelPreviewOne.alpha = 0
            })
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.animationGirlViewOne.alpha = 0
                })
                sender.zoomIn()
                
                var nameImg = "okButton"
                switch Locale.current.languageCode {
                case "ru":
                    nameImg = "okButton"
                case "tr":
                    nameImg = "okButtonTR"
                case "es":
                    nameImg = "okButtonES"
                default:
                    nameImg = "okButton"
                }
                
                self.nextButton.setImage(UIImage(named: nameImg), for: .normal)
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                    self.animationGirlViewOne.isHidden = true
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationGirlViewTwo.alpha = 1
                        self.blackboard.alpha = 1
                    })
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.labelPreviewTwo.alpha = 1
                            self.nextButton.alpha = 1
                            self.playConfirmationSound()
                        })
                    }
                }
            }
        } else {
            if !UserDefaults.standard.bool(forKey: "isSecondPressButtonNext") {
                sender.zoomOut()
                UIView.animate(withDuration: 0.4, animations: {
                    self.nextButton.alpha = 0
                    self.labelPreviewTwo.alpha = 0
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationGirlViewTwo.alpha = 0
                        self.blackboard.alpha = 0
                    })
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                        sender.zoomIn()
                        self.animationGirlViewTwo.isHidden = true
                        
                        var nameImg = "okButtonTwo"
                        switch Locale.current.languageCode {
                        case "ru":
                            nameImg = "okButtonTwo"
                        case "tr":
                            nameImg = "okButtonTwoTR"
                        case "es":
                            nameImg = "okButtonTwoES"
                        default:
                            nameImg = "okButtonTwo"
                        }
                        self.nextButton.setImage(UIImage(named: nameImg), for: .normal)
                        UIView.animate(withDuration: 0.4, animations: {
                            self.animationGirlViewThree.alpha = 1
                            self.basicButtonView.alpha = 1
                        })
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                            UIView.animate(withDuration: 0.4, animations: {
                                self.labelPreviewThree.alpha = 1
                                self.playConfirmationSound()
                            })
                            
                            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                                UIView.animate(withDuration: 0.4, animations: {
                                    self.nextButton.alpha = 1
                                    self.playProgress()
                                })
                            }
                        }
                    }
                }
            } else {
                if !UserDefaults.standard.bool(forKey: "isThirdPressButtonNext") {
                    sender.zoomOut()
                    
                    UIView.animate(withDuration: 0.4, animations: {
                        self.nextButton.alpha = 0
                        self.labelPreviewThree.alpha = 0
                    })
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.animationGirlViewThree.alpha = 0
                            self.backgroundShadowImage.alpha = 0
                            self.basicButtonView.alpha = 0
                        })
                        
                        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (timer) in
                            self.dismiss(animated: false)
                        }
                    }
                }
                UserDefaults.standard.set(true, forKey: "isThirdPressButtonNext")
            }
            UserDefaults.standard.set(true, forKey: "isSecondPressButtonNext")
        }
        UserDefaults.standard.set(true, forKey: "isFirstPressButtonNext")
        
    }
//MARK: - AnimationGirl
    func animationGirlOne() {
        animationGirlViewOne.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationGirlViewOne.contentMode = .scaleAspectFit
        animationGirlViewOne.loopMode = .playOnce
        animationGirlViewOne.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationGirlViewOne.layer.shadowRadius = 7
        animationGirlViewOne.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationGirlViewOne.layer.shadowOpacity = 0.3
        animationGirlViewOne.alpha = 0
        self.view.addSubview(animationGirlViewOne)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 830 {
            wdth = 320
            positX = -70
            positY = -120
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 320
            positX = -80
            positY = -130
        } else if totalSize.height <= 670 {
            wdth = 300
            positX = -70
            positY = -135
        } else {
            wdth = 310
            positX = -70
            positY = -120
        }
        animationGirlViewOne.snp.makeConstraints { make in
            make.width.height.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        animationGirlViewOne.play { (finished) in
            self.animationGirlViewOne.pause()
        }
        
        var number = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            number += 1
            if number >= 4 {
                self.animationGirlViewOne.play { (finished) in
                    self.animationGirlViewOne.pause()
                }
                number = 0
            }
        }
        
    }
    func animationGirlTwo() {
        animationGirlViewTwo.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationGirlViewTwo.contentMode = .scaleAspectFit
        animationGirlViewTwo.loopMode = .repeat(300)
        animationGirlViewTwo.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationGirlViewTwo.layer.shadowRadius = 7
        animationGirlViewTwo.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationGirlViewTwo.layer.shadowOpacity = 0.3
        animationGirlViewTwo.alpha = 0
        self.view.addSubview(animationGirlViewTwo)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 830 {
            wdth = 320
            positX = 70
            positY = -180
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 320
            positX = 70
            positY = -160
        } else if totalSize.height <= 670 {
            wdth = 300
            positX = 80
            positY = -140
        } else {
            wdth = 310
            positX = 70
            positY = -180
        }
        
        animationGirlViewTwo.snp.makeConstraints { make in
            make.width.height.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        animationGirlViewTwo.play()
    }
    func animationGirlThree() {
        animationGirlViewThree.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationGirlViewThree.contentMode = .scaleAspectFit
        animationGirlViewThree.loopMode = .repeat(300)
        animationGirlViewThree.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationGirlViewThree.layer.shadowRadius = 7
        animationGirlViewThree.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationGirlViewThree.layer.shadowOpacity = 0.3
        animationGirlViewThree.alpha = 0
        self.view.addSubview(animationGirlViewThree)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 890 {
            positY = 150
            positX = 130
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 160
            positX = 130
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 185
            positX = 150
        } else if totalSize.height <= 670 {
            positY = 170
            positX = 130
        } else {
            positY = 170
            positX = 130
        }
        
        animationGirlViewThree.snp.makeConstraints { make in
            make.width.height.equalTo(280)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        animationGirlViewThree.play()
    }
    
//MARK: - Sound
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
    
    func playConfirmationSound() {
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
}


