//
//  PreviewSubMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 20.03.2022.
//

import UIKit
import AVFoundation
import Lottie

class PreviewSubMenuViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    let countProgress = 7
    
    let animationGirlViewOne = AnimationView(name: "basicGirlPreviewThree")
    let animationGirlViewTwo = AnimationView(name: "basicGirlPreviewFour")
    let animationGirlViewThree = AnimationView(name: "basicGirlWait2")
    
    var player: AVAudioPlayer?
    
    let shapeLAyerIYou = CAShapeLayer()
    let iYouAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isThirdPressButtonNextSubMenu")
        UserDefaults.standard.set(false, forKey: "isSecondPressButtonNextSubMenu")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonNextSubMenu")

        setupView()
    }
//MARK: - SetupView
    func setupView() {
        backgroundShadowImage.isHidden = false
        labelPreviewThree.isHidden = false
        labelPreviewFour.isHidden = false
        labelPreviewThree.isHidden = false
        starImage1.isHidden = false
        starImage2.isHidden = false
        starImage3.isHidden = false
        starImage4.isHidden = false
        starImage5.isHidden = false
        
        nextButton.addTarget(self, action: #selector(nextButtonAction(sender:)), for: .touchUpInside)
        iYouButton.addTarget(self, action: #selector(iYouButtonAction(sender:)), for: .touchUpInside)
        buttonIYouCircleProgress()

        animationGirlOne()
        animationGirlTwo()
        animationGirlThree()
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.playProgress()
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundShadowImage.alpha = 0.8
            self.animationGirlViewOne.alpha = 1
            self.iYouButtonView.alpha = 1
        })
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.4, animations: {
                self.labelPreviewThree.alpha = 1
                self.playConfirmationSound()
            })
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.nextButton.alpha = 1
                })
            }
        }
    }
    
//MARK: - BackgroundShadow
    lazy var backgroundShadowImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "notificationBackground"))
        img.contentMode = .scaleAspectFill
        img.transform = CGAffineTransform(rotationAngle: CGFloat(1.57))
        img.alpha = 0
        self.view.addSubview(img)

        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(650)
        }

        return img
    }()
    
//MARK: - Label
    lazy var labelPreviewThree: UIImageView = {
        
        var nameImg = "labelPreviewThree"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewThree"
        case "tr":
            nameImg = "labelPreviewThreeTR"
        case "es":
            nameImg = "labelPreviewThreeES"
        default:
            nameImg = "labelPreviewThree"
        }
        
        let img = UIImageView(image: UIImage(named: nameImg))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 7
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        img.alpha = 0
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 920 {
            positY = -130
            positX = -50
            wdth = 250
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -120
            positX = -50
            wdth = 250
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -130
            positX = -50
            wdth = 250
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -130
            positX = -50
            wdth = 250
        } else if totalSize.height <= 670 {
            positY = -130
            positX = -50
            wdth = 250
        } else {
            positY = -140
            positX = -50
            wdth = 230
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
    lazy var labelPreviewFour: UIImageView = {
        
        var nameImg = "labelPreviewFour"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewFour"
        case "tr":
            nameImg = "labelPreviewFourTR"
        case "es":
            nameImg = "labelPreviewFourES"
        default:
            nameImg = "labelPreviewFour"
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
            positX = 20
            positY = 110
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 250
            positX = 20
            positY = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 230
            positX = 20
            positY = 130
        } else if totalSize.height <= 670 {
            wdth = 210
            positX = 30
            positY = 130
        } else {
            wdth = 230
            positX = 20
            positY = 140
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
    lazy var labelPreviewFive: UIImageView = {
        
        var nameImg = "labelPreviewFive"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewFive"
        case "tr":
            nameImg = "labelPreviewFiveTR"
        case "es":
            nameImg = "labelPreviewFiveES"
        default:
            nameImg = "labelPreviewFive"
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
            positX = -60
            positY = -120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 250
            positX = -60
            positY = -90
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 250
            positX = -60
            positY = -110
        } else if totalSize.height <= 670 {
            wdth = 230
            positX = -60
            positY = -120
        } else {
            wdth = 230
            positX = -60
            positY = -120
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
    
//MARK: Star
    lazy var starImage1: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starFull1")
        img.alpha = 0
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -190
            positX = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -196
            positX = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -137
            positX = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -172
            positX = 0
        } else if totalSize.height <= 670 {
            positY = -125
            positX = -20
        } else {
            positY = -152
            positX = -15
        }
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
        }
        return img
    }()
    lazy var starImage2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starFull1")
        img.alpha = 0
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -190
            positX = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -196
            positX = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -137
            positX = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -172
            positX = 40
        } else if totalSize.height <= 670 {
            positY = -125
            positX = 20
        } else {
            positY = -152
            positX = 25
        }
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
        }
        return img
    }()
    lazy var starImage3: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starFull1")
        img.alpha = 0
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -190
            positX = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -196
            positX = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -137
            positX = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -172
            positX = 80
        } else if totalSize.height <= 670 {
            positY = -125
            positX = 60
        } else {
            positY = -152
            positX = 65
        }
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
        }
        return img
    }()
    lazy var starImage4: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starFull1")
        img.alpha = 0
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -190
            positX = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -196
            positX = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -137
            positX = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -172
            positX = 120
        } else if totalSize.height <= 670 {
            positY = -125
            positX = 100
        } else {
            positY = -152
            positX = 105
        }
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
        }
        return img
    }()
    lazy var starImage5: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "starFull1")
        img.alpha = 0
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -190
            positX = 160
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -196
            positX = 160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -137
            positX = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -172
            positX = 160
        } else if totalSize.height <= 670 {
            positY = -125
            positX = 140
        } else {
            positY = -152
            positX = 145
        }
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
        }
        return img
    }()
//MARK: - iYouButton
    lazy var iYouButtonView: UIView = {
        let vi = UIView()
        vi.alpha = 0
        self.view.addSubview(vi)
        
        var bttm: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            bttm = 186
            lead = 20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 195
            lead = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 144
            lead = 10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 96
            lead = 20
        } else if totalSize.height <= 670 {
            bttm = 67
            lead = 10
        } else {
            bttm = 162
            lead = 10
        }
        
        vi.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    lazy var iYouButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "iYouButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        iYouButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(76)
        }
        
        return btn
    }()
    @objc func iYouButtonAction(sender: UIButton) {
        
    }
    
    func buttonIYouCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -426
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -410
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -384
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -331
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -296
            positX = -88
        } else {
            positY = -368
            positX = -88
        }
        let progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.position = CGPoint(x: positX, y: positY)
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 12.0
        view.layer.addSublayer(progressLayer)
        iYouButtonView.layer.addSublayer(progressLayer)

        shapeLAyerIYou.path = circularPath.cgPath
        shapeLAyerIYou.position = CGPoint(x: positX, y: positY)
        shapeLAyerIYou.fillColor = UIColor.clear.cgColor
        shapeLAyerIYou.lineWidth = 7
        shapeLAyerIYou.lineCap = .round
        shapeLAyerIYou.strokeEnd = 0
        shapeLAyerIYou.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        view.layer.addSublayer(shapeLAyerIYou)
        iYouButtonView.layer.addSublayer(shapeLAyerIYou)
    }
    
    func playProgress() {
        iYouAnimation.fromValue = iYouAnimation.toValue
        iYouAnimation.isRemovedOnCompletion = false
        iYouAnimation.duration = 0.5
        iYouAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(countProgress) > 8 || CGFloat(countProgress) < 0 {
                return
            }
            iYouAnimation.toValue = CGFloat(countProgress)/8
            shapeLAyerIYou.add(iYouAnimation, forKey: "urSoBasic")
    }
//MARK: - NextButton
    lazy var nextButton: UIButton = {
        
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
    
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonNextSubMenu") {
            sender.zoomOut()
            UIView.animate(withDuration: 0.4, animations: {
                self.nextButton.alpha = 0
                self.labelPreviewThree.alpha = 0
            })
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.animationGirlViewOne.alpha = 0
                    self.iYouButtonView.alpha = 0
                })
                sender.zoomIn()
                
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
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                    self.animationGirlViewOne.isHidden = true
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationGirlViewTwo.alpha = 1
                    })
                    
                    //star
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.starImage1.alpha = 1
                            self.playConfirmationSoundTwo()
                        })
                    }
                    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.starImage2.alpha = 1
                            self.playConfirmationSoundTwo()
                        })
                    }
                    Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.starImage3.alpha = 1
                            self.playConfirmationSoundTwo()
                        })
                    }
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.starImage4.alpha = 1
                            self.playConfirmationSoundTwo()
                        })
                    }
                    Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.starImage5.alpha = 1
                            self.playConfirmationSoundTwo()
                        })
                    }
                    
                    
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.labelPreviewFour.alpha = 1
                            self.nextButton.alpha = 1
                            self.playConfirmationSound()
                        })
                    }
                }
            }
        } else {
            if !UserDefaults.standard.bool(forKey: "isSecondPressButtonNextSubMenu") {
                sender.zoomOut()
                UIView.animate(withDuration: 0.4, animations: {
                    self.nextButton.alpha = 0
                    self.labelPreviewFour.alpha = 0
                })
                
                //star
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.starImage1.alpha = 0
                    })
                }
                Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.starImage2.alpha = 0
                    })
                }
                Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.starImage3.alpha = 0
                    })
                }
                Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.starImage4.alpha = 0
                    })
                }
                Timer.scheduledTimer(withTimeInterval: 1.7, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.starImage5.alpha = 0
                    })
                }
                
    
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationGirlViewTwo.alpha = 0
                    })
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                        sender.zoomIn()
                        self.animationGirlViewTwo.isHidden = true
                        
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
                        self.nextButton.setImage(UIImage(named: nameImg), for: .normal)
                        UIView.animate(withDuration: 0.4, animations: {
                            self.animationGirlViewThree.alpha = 1
                        })
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                            UIView.animate(withDuration: 0.4, animations: {
                                self.labelPreviewFive.alpha = 1
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
            } else {
                if !UserDefaults.standard.bool(forKey: "isThirdPressButtonNextSubMenu") {
                    sender.zoomOut()
                    
                    UIView.animate(withDuration: 0.4, animations: {
                        self.nextButton.alpha = 0
                        self.labelPreviewFive.alpha = 0
                    })
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.animationGirlViewThree.alpha = 0
                            self.backgroundShadowImage.alpha = 0
                        })
                        
                        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (timer) in
                            self.dismiss(animated: false)
                        }
                    }
                }
                UserDefaults.standard.set(true, forKey: "isThirdPressButtonNextSubMenu")
            }
            UserDefaults.standard.set(true, forKey: "isSecondPressButtonNextSubMenu")
        }
        UserDefaults.standard.set(true, forKey: "isFirstPressButtonNextSubMenu")
        
    }
//MARK: - AnimationGirl
    func animationGirlOne() {
        animationGirlViewOne.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationGirlViewOne.contentMode = .scaleAspectFit
        animationGirlViewOne.loopMode = .repeat(300)
        animationGirlViewOne.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationGirlViewOne.layer.shadowRadius = 7
        animationGirlViewOne.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationGirlViewOne.layer.shadowOpacity = 0.3
        animationGirlViewOne.alpha = 0
        self.view.addSubview(animationGirlViewOne)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 300
            positX = 50
            positY = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 300
            positX = 50
            positY = 120
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 300
            positX = 50
            positY = 120
        } else if totalSize.height <= 670 {
            wdth = 290
            positX = 50
            positY = 110
        } else {
            wdth = 290
            positX = 50
            positY = 80
        }
        
        animationGirlViewOne.snp.makeConstraints { make in
            make.width.height.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        animationGirlViewOne.play()
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
        if totalSize.height >= 920 {
            wdth = 310
            positX = -40
            positY = -80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 310
            positX = -40
            positY = -90
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 300
            positX = -40
            positY = -40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 300
            positX = -40
            positY = -70
        } else if totalSize.height <= 670 {
            wdth = 280
            positX = -40
            positY = -20
        } else {
            wdth = 280
            positX = -40
            positY = -50
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
        animationGirlViewThree.loopMode = .playOnce
        animationGirlViewThree.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationGirlViewThree.layer.shadowRadius = 7
        animationGirlViewThree.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationGirlViewThree.layer.shadowOpacity = 0.3
        animationGirlViewThree.alpha = 0
        self.view.addSubview(animationGirlViewThree)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 320
            positX = 100
            positY = 90
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 320
            positX = 100
            positY = 120
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 310
            positX = 100
            positY = 100
        } else if totalSize.height <= 670 {
            wdth = 300
            positX = 100
            positY = 80
        } else {
            wdth = 310
            positX = 100
            positY = 90
        }
        
        animationGirlViewThree.snp.makeConstraints { make in
            make.width.height.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        animationGirlViewThree.play { (finished) in
            self.animationGirlViewThree.pause()
        }
        
        var number = 0
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            number += 1
            if number >= 4 {
                self.animationGirlViewThree.play { (finished) in
                    self.animationGirlViewThree.pause()
                }
                number = 0
            }
        }
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
    
    func playConfirmationSoundTwo() {
        guard let path = Bundle.main.path(forResource: "confirmationSound", ofType:"wav") else {
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

