//
//  PersonMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 24.02.2022.
//
import UIKit
import SnapKit
import Lottie
import AVFoundation

class PersonMenuViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    var playerTwo: AVAudioPlayer?
    var playerThree: AVAudioPlayer?
    
    var animationCrownPlay: Bool = false
    
    var buttonPersonProgress = UserDefaults.standard.integer(forKey: "buttonPersonProgress")
    
    var buttonGeneralProgress = UserDefaults.standard.integer(forKey: "buttonGeneralProgress")
    var buttonFamilyProgress = UserDefaults.standard.integer(forKey: "buttonFamilyProgress")
    var buttonBodyProgress = UserDefaults.standard.integer(forKey: "buttonBodyProgress")
    var buttonFeelingsProgress = UserDefaults.standard.integer(forKey: "buttonFeelingsProgress")
    var buttonAppearanceProgress = UserDefaults.standard.integer(forKey: "buttonAppearanceProgress")
    
    var questionsModel = QuestionModel()
    
    let shapeLAyerGeneral = CAShapeLayer()
    let shapeLAyerFamily = CAShapeLayer()
    let shapeLAyerBody = CAShapeLayer()
    let shapeLAyerFeelings = CAShapeLayer()
    let shapeLAyerAppearance = CAShapeLayer()
    
    let generalAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let familyAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let bodyAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let feelingsAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let appearanceAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        backgroundShadowImage.isHidden = false
        
        //background
        self.view.backgroundColor = .clear
        backgroundImage.isHidden = false
        chalkPersonImage.isHidden = false
        
        //crown
        updateCrown()
        
        //star
        starImage1.isHidden = false
        starImage2.isHidden = false
        starImage3.isHidden = false
        starImage4.isHidden = false
        starImage5.isHidden = false
        
        //arrow
        arrowGeneralImage.isHidden = false
        arrowFamilyImage.isHidden = false
        arrowBodyImage.isHidden = false
        arrowFeelingsImage.isHidden = false
        
        mainLabelUnderline.isHidden = false
        mainLabel.isHidden = false
        
        //backgroundLabel
        generalLabel.isHidden = false
        familyLabel.isHidden = false
        bodyLabel.isHidden = false
        feelingsLabel.isHidden = false
        appearanceLabel.isHidden = false
        
        //setupProgress
        colorProgress()
        
        buttonGeneralCircleProgress()
        buttonFamilyCircleProgress()
        buttonBodyCircleProgress()
        buttonFeelingsCircleProgress()
        buttonAppearanceCircleProgress()
        
        playProgress()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.updateProgress()
            self.scrollWhenOpening()
            self.starUpdate()
        }
        
        //Button
        generalButton.addTarget(self, action: #selector(generalButtonAction(sender:)), for: .touchUpInside)
        familyButton.addTarget(self, action: #selector(familyButtonAction(sender:)), for: .touchUpInside)
        bodyButton.addTarget(self, action: #selector(bodyButtonAction(sender:)), for: .touchUpInside)
        feelingsButton.addTarget(self, action: #selector(feelingsButtonAction(sender:)), for: .touchUpInside)
        appearanceButton.addTarget(self, action: #selector(appearanceButtonAction(sender:)), for: .touchUpInside)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        
        //ScrollView
        setupScrollView()
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(PersonMenuViewController.refresh), name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PersonMenuViewController.lookNewLevel), name: NSNotification.Name(rawValue: "lookNewLevel"), object: nil)
    }
//MARK: - Refresh
    @objc func refresh() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.buttonGeneralProgress = UserDefaults.standard.integer(forKey: "buttonGeneralProgress")
            self.buttonFamilyProgress = UserDefaults.standard.integer(forKey: "buttonFamilyProgress")
            self.buttonBodyProgress = UserDefaults.standard.integer(forKey: "buttonBodyProgress")
            self.buttonFeelingsProgress = UserDefaults.standard.integer(forKey: "buttonFeelingsProgress")
            self.buttonAppearanceProgress = UserDefaults.standard.integer(forKey: "buttonAppearanceProgress")
            
            self.updateCrown()
            self.colorProgress()
            self.playProgress()
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                self.updateProgress()
            }
            self.starUpdate()
            
            
            self.buttonPersonProgress = UserDefaults.standard.integer(forKey: "buttonPersonProgress")
            if self.buttonPersonProgress >= 86 {
                if !UserDefaults.standard.bool(forKey: "isFirstOpeningFoodLevel") {
                    UserDefaults.standard.set("foodLvl", forKey: "whichLevelUnlocked")
                    
                    if self.animationCrownPlay == true {
                        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                            let vc = NotificationLevelUnlockViewController()
                            vc.modalPresentationStyle = .overCurrentContext
                            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            
                            let transition = CATransition()
                            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                            self.view.window!.layer.add(transition, forKey: kCATransition)

                            self.present(vc, animated: true, completion: nil)
                        }
                        self.animationCrownPlay = false
                    } else {
                        let vc = NotificationLevelUnlockViewController()
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        
                        let transition = CATransition()
                        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                        self.view.window!.layer.add(transition, forKey: kCATransition)

                        self.present(vc, animated: true, completion: nil)
                    }
                }
                UserDefaults.standard.set(true, forKey: "isFirstOpeningFoodLevel")
            }
        }
    }
//MARK: - LookNewLevel
    @objc func lookNewLevel() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundShadowImage.alpha = 0
        })
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "secondaryMenuDismiss"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
//MARK: - UpdateProgress
    func updateProgress() {
        //unlockFamily
        if buttonGeneralProgress >= 15 {
            UserDefaults.standard.set(true, forKey: "isFamilyLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isFamilyLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockFamilyLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 300.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 450.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    }
                })
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowGeneralImage.alpha = 1
                            self.familyButtonView.alpha = 1
                            self.familyButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockFamilyLevelUnlock")
        } else {
            self.arrowGeneralImage.alpha = 0.2
            self.familyButtonView.alpha = 0.4
            self.familyButtonView.isUserInteractionEnabled = false
        }
        
        //unlockBody
        if buttonFamilyProgress >= 20 {
            UserDefaults.standard.set(true, forKey: "isBodyLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isBodyLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockBodyLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 600.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 620.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 550.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowFamilyImage.alpha = 1
                            self.bodyButtonView.alpha = 1
                            self.bodyButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockBodyLevelUnlock")
        } else {
            self.arrowFamilyImage.alpha = 0.2
            self.bodyButtonView.alpha = 0.4
            self.bodyButtonView.isUserInteractionEnabled = false
        }
        
        //unlockFeelings
        if buttonBodyProgress >= 24 {
            UserDefaults.standard.set(true, forKey: "isFeelingsLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isFeelingsLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockFeelingsLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 630.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 630.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 660.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 760.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 780.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 670.0), animated: false)
                    }
                })
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowBodyImage.alpha = 1
                            self.feelingsButtonView.alpha = 1
                            self.feelingsButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockFeelingsLevelUnlock")
        } else {
            self.arrowBodyImage.alpha = 0.2
            self.feelingsButtonView.alpha = 0.4
            self.feelingsButtonView.isUserInteractionEnabled = false
        }
        
        //unlockAppearance
        if buttonFeelingsProgress >= 14 {
            UserDefaults.standard.set(true, forKey: "isAppearanceLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isAppearanceLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockAppearanceLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 715.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 722.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 736.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 882.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 888.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 743.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowFeelingsImage.alpha = 1
                            self.appearanceButtonView.alpha = 1
                            self.appearanceButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockAppearanceLevelUnlock")
        } else {
            self.arrowFeelingsImage.alpha = 0.2
            self.appearanceButtonView.alpha = 0.4
            self.appearanceButtonView.isUserInteractionEnabled = false
        }
    }
//MARK: - scrollWhenOpening
    func scrollWhenOpening() {
        
        //general
        UIView.animate(withDuration: 0.5, animations: {
            if self.totalSize.height >= 920 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
            } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 200.0), animated: false)
            } else if self.totalSize.height <= 670 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 200.0), animated: false)
            } else {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            }
        })
        
        //family
        if UserDefaults.standard.bool(forKey: "isFamilyLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 300.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 300.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 480.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                }
            })
        }
        
        //body
        if UserDefaults.standard.bool(forKey: "isBodyLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 600.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 620.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 550.0), animated: false)
                }
            })
        }
        
        //feelings
        if UserDefaults.standard.bool(forKey: "isFeelingsLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 630.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 630.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 660.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 760.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 780.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 670.0), animated: false)
                }
            })
        }
        
        //appearance
        if UserDefaults.standard.bool(forKey: "isAppearanceLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 715.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 722.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 736.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 882.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 888.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 743.0), animated: false)
                }
            })
        }
    }
//MARK: PlayProgress
    func playProgress() {
        
        //general
        generalAnimation.fromValue = generalAnimation.toValue
        generalAnimation.isRemovedOnCompletion = false
        generalAnimation.duration = 0.5
        generalAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonGeneralProgress) > 21 || CGFloat(buttonGeneralProgress) < 0 {
                return
            }
        generalAnimation.toValue = CGFloat(buttonGeneralProgress)/21
        shapeLAyerGeneral.add(generalAnimation, forKey: "urSoBasic")
        
        //family
        familyAnimation.fromValue = familyAnimation.toValue
        familyAnimation.isRemovedOnCompletion = false
        familyAnimation.duration = 0.5
        familyAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonFamilyProgress) > 28 || CGFloat(buttonFamilyProgress) < 0 {
                return
            }
        familyAnimation.toValue = CGFloat(buttonFamilyProgress)/28
        shapeLAyerFamily.add(familyAnimation, forKey: "urSoBasic")
        
        //body
        bodyAnimation.fromValue = bodyAnimation.toValue
        bodyAnimation.isRemovedOnCompletion = false
        bodyAnimation.duration = 0.5
        bodyAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonBodyProgress) > 33 || CGFloat(buttonBodyProgress) < 0 {
                return
            }
        bodyAnimation.toValue = CGFloat(buttonBodyProgress)/33
        shapeLAyerBody.add(bodyAnimation, forKey: "urSoBasic")
        
        //feelings
        feelingsAnimation.fromValue = feelingsAnimation.toValue
        feelingsAnimation.isRemovedOnCompletion = false
        feelingsAnimation.duration = 0.5
        feelingsAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonFeelingsProgress) > 20 || CGFloat(buttonFeelingsProgress) < 0 {
                return
            }
        feelingsAnimation.toValue = CGFloat(buttonFeelingsProgress)/20
        shapeLAyerFeelings.add(feelingsAnimation, forKey: "urSoBasic")
        
        
        //appearance
        appearanceAnimation.fromValue = appearanceAnimation.toValue
        appearanceAnimation.isRemovedOnCompletion = false
        appearanceAnimation.duration = 0.5
        appearanceAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonAppearanceProgress) > 21 || CGFloat(buttonAppearanceProgress) < 0 {
                return
            }
        appearanceAnimation.toValue = CGFloat(buttonAppearanceProgress)/21
        shapeLAyerAppearance.add(appearanceAnimation, forKey: "urSoBasic")
        
        
//        UserDefaults.standard.set(21, forKey: "buttonGeneralProgress")
//        UserDefaults.standard.set(28, forKey: "buttonFamilyProgress")
//        UserDefaults.standard.set(33, forKey: "buttonBodyProgress")
//        UserDefaults.standard.set(20, forKey: "buttonFeelingsProgress")
        
        //saveProgress
        buttonPersonProgress = buttonGeneralProgress + buttonFamilyProgress + buttonBodyProgress + buttonFeelingsProgress + buttonAppearanceProgress
        
//        UserDefaults.standard.set(98, forKey: "buttonPersonProgress")
        
        UserDefaults.standard.set(buttonPersonProgress, forKey: "buttonPersonProgress")
    }
//MARK: BackgroundShadow
    lazy var backgroundShadowImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "notificationBackground"))
        img.contentMode = .scaleAspectFill
        img.alpha = 0.7
        img.transform = CGAffineTransform(rotationAngle: CGFloat(1.57))
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(650)
        }
        
        return img
    }()
//MARK: MainLabel
    lazy var mainLabel: UILabel = {
        
        var fontName = "lcChalk"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
            fontSize = 35
        case "tr":
            fontName = "Backnotes-Regular"
            fontSize = 50
        case "es":
            fontName = "Backnotes-Regular"
            fontSize = 50
        default:
            fontName = "lcChalk"
            fontSize = 35
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "Человек".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        backgroundView.addSubview(lbl)
        
        var positY: CGFloat!
        if totalSize.height >= 890 {
            positY = -430
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -400
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -410
        } else if totalSize.height <= 670 {
            positY = -390
        } else {
            positY = -380
        }
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        return lbl
    }()
    lazy var mainLabelUnderline: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "lcChalk", size: 35)
        lbl.text = "____".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 8
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.5
        self.view.addSubview(lbl)
        backgroundView.addSubview(lbl)
        
        var positY: CGFloat!
        if totalSize.height >= 890 {
            positY = -425
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -395
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -405
        } else if totalSize.height <= 670 {
            positY = -385
        } else {
            positY = -375
        }
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        return lbl
    }()
//MARK: Star
    lazy var starImage1: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -530
            positX = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -485
            positX = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 0
        } else if totalSize.height <= 670 {
            positY = -460
            positX = -20
        } else {
            positY = -462
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
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -530
            positX = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -485
            positX = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 40
        } else if totalSize.height <= 670 {
            positY = -460
            positX = 20
        } else {
            positY = -462
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
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -530
            positX = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -485
            positX = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 80
        } else if totalSize.height <= 670 {
            positY = -460
            positX = 60
        } else {
            positY = -462
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
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -530
            positX = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -485
            positX = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 120
        } else if totalSize.height <= 670 {
            positY = -460
            positX = 100
        } else {
            positY = -462
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
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -530
            positX = 160
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -485
            positX = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 160
        } else if totalSize.height <= 670 {
            positY = -460
            positX = 140
        } else {
            positY = -462
            positX = 145
        }
        
        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
        }
        return img
    }()
    
    func starUpdate() {
        if buttonPersonProgress >= 32 {
            starImage1.image = UIImage(named: "starFull1")
        } else {
            starImage1.image = UIImage(named: "star1")
        }
        if buttonPersonProgress >= 54 {
            starImage2.image = UIImage(named: "starFull2")
        } else {
            starImage2.image = UIImage(named: "star2")
        }
        if buttonPersonProgress >= 76 {
            starImage3.image = UIImage(named: "starFull3")
        } else {
            starImage3.image = UIImage(named: "star3")
        }
        if buttonPersonProgress >= 98 {
            starImage4.image = UIImage(named: "starFull1")
        } else {
            starImage4.image = UIImage(named: "star1")
        }
        if buttonPersonProgress >= 120 {
            starImage5.image = UIImage(named: "starFull2")
        } else {
            starImage5.image = UIImage(named: "star2")
        }
    }
//MARK: - GeneralButton
    lazy var generalButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = -163
            lead = 67
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -163
            lead = 67
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -163
            lead = 67
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -163
            lead = 67
        } else if totalSize.height <= 670 {
            positY = -163
            lead = 67
        } else {
            positY = -163
            lead = 67
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var generalButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "generalButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        generalButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(67)
        }
        
        return btn
    }()
    @objc func generalButtonAction(sender: UIButton) {
        UserDefaults.standard.set("person", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.person.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonGeneralCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -426
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -413
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -387
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -332
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -299
            positX = -88
        } else {
            positY = -371
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
        generalButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerGeneral.path = circularPath.cgPath
        shapeLAyerGeneral.position = CGPoint(x: positX, y: positY)
        shapeLAyerGeneral.fillColor = UIColor.clear.cgColor
        shapeLAyerGeneral.lineWidth = 7
        shapeLAyerGeneral.lineCap = .round
        shapeLAyerGeneral.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerGeneral)
        generalButtonView.layer.addSublayer(shapeLAyerGeneral)
        
    }
    //crown
    lazy var crownGeneralImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.6))
        generalButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(30)
            make.centerYWithinMargins.equalTo(-128)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowGeneralImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowGeneralImage"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.3))
        self.view.addSubview(img)
        generalButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
            wdth = 143
            positX = 62
            positY = 67
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 140
            positX = 60
            positY = 65
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.35))
            wdth = 135
            positX = 44
            positY = 65
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 140
            positX = 60
            positY = 65
        } else if totalSize.height <= 670 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.47))
            wdth = 135
            positX = 40
            positY = 65
        } else {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.47))
            wdth = 135
            positX = 40
            positY = 65
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var generalLabel: UILabel = {
        
        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 17
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 26
        case "es":
            fontName = "hodgepodgery"
            fontSize = 26
        default:
            fontName = "dsEraserCyr"
            fontSize = 17
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "Общее".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        self.view.addSubview(lbl)
        generalButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-45)
            make.centerYWithinMargins.equalTo(-140)
        }
        return lbl
    }()
//MARK: - FamilyButton
    lazy var familyButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 67
            trail = 19
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 67
            trail = 19
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 67
            trail = 19
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 67
            trail = 19
        } else if totalSize.height <= 670 {
            positY = 67
            trail = 19
        } else {
            positY = 67
            trail = 19
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var familyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "familyButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        familyButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(62)
        }
        
        return btn
    }()
    @objc func familyButtonAction(sender: UIButton) {
        UserDefaults.standard.set("family", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.family.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonFamilyCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -427
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -414
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -388
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -333
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -300
            positX = -88
        } else {
            positY = -372
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
        familyButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerFamily.path = circularPath.cgPath
        shapeLAyerFamily.position = CGPoint(x: positX, y: positY)
        shapeLAyerFamily.fillColor = UIColor.clear.cgColor
        shapeLAyerFamily.lineWidth = 7
        shapeLAyerFamily.lineCap = .round
        shapeLAyerFamily.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerFamily)
        familyButtonView.layer.addSublayer(shapeLAyerFamily)
        
    }
    //crown
    lazy var crownFamilyImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.6))
        familyButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(55)
            make.centerYWithinMargins.equalTo(-110)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowFamilyImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowFamilyImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        familyButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.15))
            wdth = 190
            positX = -45
            positY = 63
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
            wdth = 185
            positX = -35
            positY = 63
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
            wdth = 165
            positX = -26
            positY = 55
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
            wdth = 185
            positX = -35
            positY = 63
        } else if totalSize.height <= 670 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
            wdth = 160
            positX = -18
            positY = 53
        } else {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
            wdth = 160
            positX = -18
            positY = 53
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var familyLabel: UILabel = {

        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 17
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 26
        case "es":
            fontName = "hodgepodgery"
            fontSize = 26
        default:
            fontName = "dsEraserCyr"
            fontSize = 17
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "Семья".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        self.view.addSubview(lbl)
        familyButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-150)
        }
        return lbl
    }()
//MARK: - BodyButton
    lazy var bodyButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 245
            lead = 38
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 245
            lead = 38
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 245
            lead = 38
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 245
            lead = 38
        } else if totalSize.height <= 670 {
            positY = 245
            lead = 38
        } else {
            positY = 245
            lead = 38
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var bodyButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "bodyButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        bodyButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
        }
        
        return btn
    }()
    @objc func bodyButtonAction(sender: UIButton) {
        UserDefaults.standard.set("body", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.body.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonBodyCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -423
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -410
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -384
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -329
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
        bodyButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerBody.path = circularPath.cgPath
        shapeLAyerBody.position = CGPoint(x: positX, y: positY)
        shapeLAyerBody.fillColor = UIColor.clear.cgColor
        shapeLAyerBody.lineWidth = 7
        shapeLAyerBody.lineCap = .round
        shapeLAyerBody.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerBody)
        bodyButtonView.layer.addSublayer(shapeLAyerBody)
        
    }
    //crown
    lazy var crownBodyImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.25))
        bodyButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(35)
            make.centerYWithinMargins.equalTo(-122)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowBodyImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowBodyImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        bodyButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 253
            positX = 50
            positY = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 240
            positX = 41
            positY = 5
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 235
            positX = 42
            positY = -8
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 240
            positX = 41
            positY = 5
        } else if totalSize.height <= 670 {
            wdth = 220
            positX = 35
            positY = -5
        } else {
            wdth = 220
            positX = 35
            positY = -5
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var bodyLabel: UILabel = {

        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 17
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 26
        case "es":
            fontName = "hodgepodgery"
            fontSize = 26
        default:
            fontName = "dsEraserCyr"
            fontSize = 17
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "Тело".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        self.view.addSubview(lbl)
        bodyButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-30)
            make.centerYWithinMargins.equalTo(-140)
        }
        return lbl
    }()
//MARK: - FeelingsButton
    lazy var feelingsButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 390
            trail = -15
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 390
            trail = -15
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 390
            trail = -15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 390
            trail = -15
        } else if totalSize.height <= 670 {
            positY = 390
            trail = -15
        } else {
            positY = 390
            trail = -15
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var feelingsButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "feelingsButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        feelingsButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(87)
        }
        
        return btn
    }()
    @objc func feelingsButtonAction(sender: UIButton) {
        UserDefaults.standard.set("feelings", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.feelings.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonFeelingsCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -417
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -404
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -378
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -323
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -290
            positX = -88
        } else {
            positY = -362
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
        feelingsButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerFeelings.path = circularPath.cgPath
        shapeLAyerFeelings.position = CGPoint(x: positX, y: positY)
        shapeLAyerFeelings.fillColor = UIColor.clear.cgColor
        shapeLAyerFeelings.lineWidth = 7
        shapeLAyerFeelings.lineCap = .round
        shapeLAyerFeelings.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerFeelings)
        feelingsButtonView.layer.addSublayer(shapeLAyerFeelings)
        
    }
    //crown
    lazy var crownFeelingsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.22))
        feelingsButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-5)
            make.centerYWithinMargins.equalTo(-125)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowFeelingsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowFeelingsImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        feelingsButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 182
            positX = -127
            positY = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 165
            positX = -120
            positY = 33
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
            wdth = 158
            positX = -107
            positY = 37
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
            wdth = 173
            positX = -115
            positY = 35
        } else if totalSize.height <= 670 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
            wdth = 155
            positX = -95
            positY = 35
        } else {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
            wdth = 152
            positX = -105
            positY = 35
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var feelingsLabel: UILabel = {
        
//        let size: CGFloat!
//        if totalSize.height >= 890 && totalSize.height <= 919 {
//            size = 17
//        } else if totalSize.height >= 830 && totalSize.height <= 889 {
//            size = 16
//        } else {
//            size = 15
//        }
        
        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 17
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 26
        case "es":
            fontName = "hodgepodgery"
            fontSize = 26
        default:
            fontName = "dsEraserCyr"
            fontSize = 17
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "Чувства и \n \nэмоции".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        self.view.addSubview(lbl)
        feelingsButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(40)
        }
        return lbl
    }()
//MARK: - AppearanceButton
    lazy var appearanceButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 580
            lead = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 580
            lead = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 580
            lead = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 580
            lead = 0
        } else if totalSize.height <= 670 {
            positY = 580
            lead = 0
        } else {
            positY = 580
            lead = 0
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var appearanceButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "appearanceButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        appearanceButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        return btn
    }()
    @objc func appearanceButtonAction(sender: UIButton) {
        UserDefaults.standard.set("appearance", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.appearance.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonAppearanceCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -432
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -419
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -393
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -338
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -305
            positX = -88
        } else {
            positY = -377
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
        appearanceButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerAppearance.path = circularPath.cgPath
        shapeLAyerAppearance.position = CGPoint(x: positX, y: positY)
        shapeLAyerAppearance.fillColor = UIColor.clear.cgColor
        shapeLAyerAppearance.lineWidth = 7
        shapeLAyerAppearance.lineCap = .round
        shapeLAyerAppearance.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerAppearance)
        appearanceButtonView.layer.addSublayer(shapeLAyerAppearance)
        
    }
    //crown
    lazy var crownAppearanceImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        appearanceButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-19)
            make.centerYWithinMargins.equalTo(-137)
        }
        
        return img
    }()
    
    //Label
    lazy var appearanceLabel: UILabel = {

        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 17
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 26
        case "es":
            fontName = "hodgepodgery"
            fontSize = 26
        default:
            fontName = "dsEraserCyr"
            fontSize = 17
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "Внешность".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        appearanceButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(25)
            make.centerYWithinMargins.equalTo(-170)
        }
        return lbl
    }()
//MARK: - ColorProgress
    func colorProgress() {
        //General
        if buttonGeneralProgress >= 17 {
            shapeLAyerGeneral.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonGeneralProgress >= 13 {
            shapeLAyerGeneral.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonGeneralProgress >= 9 {
            shapeLAyerGeneral.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonGeneralProgress >= 5 {
            shapeLAyerGeneral.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonGeneralProgress >= 0 {
            shapeLAyerGeneral.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //family
        if buttonFamilyProgress >= 22 {
            shapeLAyerFamily.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonFamilyProgress >= 16 {
            shapeLAyerFamily.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonFamilyProgress >= 11 {
            shapeLAyerFamily.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonFamilyProgress >= 6 {
            shapeLAyerFamily.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonFamilyProgress >= 0 {
            shapeLAyerFamily.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //body
        if buttonBodyProgress >= 25 {
            shapeLAyerBody.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonBodyProgress >= 18 {
            shapeLAyerBody.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonBodyProgress >= 13 {
            shapeLAyerBody.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonBodyProgress >= 6 {
            shapeLAyerBody.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonBodyProgress >= 0 {
            shapeLAyerBody.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //feelings
        if buttonFeelingsProgress >= 14 {
            shapeLAyerFeelings.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonFeelingsProgress >= 11 {
            shapeLAyerFeelings.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonFeelingsProgress >= 7 {
            shapeLAyerFeelings.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonFeelingsProgress >= 4 {
            shapeLAyerFeelings.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonFeelingsProgress >= 0 {
            shapeLAyerFeelings.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //appearance
        if buttonAppearanceProgress >= 15 {
            shapeLAyerAppearance.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonAppearanceProgress >= 11 {
            shapeLAyerAppearance.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonAppearanceProgress >= 7 {
            shapeLAyerAppearance.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonAppearanceProgress >= 4 {
            shapeLAyerAppearance.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonAppearanceProgress >= 0 {
            shapeLAyerAppearance.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }

    }
    
//MARK: ScrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let backgroundView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1100).isActive = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "blackboardTimeMenu"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(100)
            make.leading.trailing.equalTo(0)
        }
        
        return img
    }()
    //chalkPerson
    lazy var chalkPersonImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "chalkPerson"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 920 {
            positY = 640
            wdth = 160
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 615
            wdth = 155
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 600
            wdth = 140
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 630
            wdth = 150
        } else if totalSize.height <= 670 {
            positY = 590
            wdth = 125
        } else {
            positY = 585
            wdth = 135
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(100)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(backgroundView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        var positBttm: CGFloat!
        if totalSize.height >= 920 {
            positBttm = -207
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttm = -184
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttm = -146
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttm = -218
        } else if totalSize.height <= 670 {
            positBttm = -156
        } else {
            positBttm = -121
        }
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 300).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: positBttm).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

//MARK: RewardCrown
    func updateCrown() {
        //saveProgress
        //general
        if buttonGeneralProgress == 21 {
            UserDefaults.standard.set(true, forKey: "crownGeneralBool")
        }
        //family
        if buttonFamilyProgress == 28 {
            UserDefaults.standard.set(true, forKey: "crownFamilyBool")
        }
        //body
        if buttonBodyProgress == 33 {
            UserDefaults.standard.set(true, forKey: "crownBodyBool")
        }
        //feelings
        if buttonFeelingsProgress == 20 {
            UserDefaults.standard.set(true, forKey: "crownFeelingsBool")
        }
        //appearance
        if buttonAppearanceProgress == 21 {
            UserDefaults.standard.set(true, forKey: "crownAppearanceBool")
        }
        
        //spawn
        //general
        if UserDefaults.standard.bool(forKey: "crownGeneralBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownGeneral") {
                animationReward()
                playConfirmationSound()
                crownGeneralImage.isHidden = false
                crownGeneralImage.pulsate()
            } else {
                crownGeneralImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownGeneral")
        }
        //family
        if UserDefaults.standard.bool(forKey: "crownFamilyBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownFamily") {
                animationReward()
                playConfirmationSound()
                crownFamilyImage.isHidden = false
                crownFamilyImage.pulsate()
            } else {
                crownFamilyImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownFamily")
        }
        //body
        if UserDefaults.standard.bool(forKey: "crownBodyBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownBody") {
                animationReward()
                playConfirmationSound()
                crownBodyImage.isHidden = false
                crownBodyImage.pulsate()
            } else {
                crownBodyImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownBody")
        }
        //feelings
        if UserDefaults.standard.bool(forKey: "crownFeelingsBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownFeelings") {
                animationReward()
                playConfirmationSound()
                crownFeelingsImage.isHidden = false
                crownFeelingsImage.pulsate()
            } else {
                crownFeelingsImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownFeelings")
        }
        //appearance
        if UserDefaults.standard.bool(forKey: "crownAppearanceBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownAppearance") {
                animationReward()
                playConfirmationSound()
                crownAppearanceImage.isHidden = false
                crownAppearanceImage.pulsate()
            } else {
                crownAppearanceImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownAppearance")
        }
        
    }
    //Animation
    func animationReward() {
        let animationView = AnimationView(name: "confetti")
        animationView.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: 600)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        self.view.addSubview(animationView)
        
        animationView.play { (finished) in
            animationView.isHidden = true
        }
        
        playConfettiSound()
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            self.playConfettiSound()
        }
        
        animationCrownPlay = true
    }
//MARK: - DismissButton
    lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeButtonChalk"), for: .normal)
        btn.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        backgroundView.addSubview(btn)
        
        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = -520
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -503
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -480
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -513
        } else if totalSize.height <= 670 {
            positY = -460
        } else {
            positY = -460
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-150)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        return btn
    }()
    @objc func dismissButtonAction(sender: UIButton) {
        playPressSound()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundShadowImage.alpha = 0
        })
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "secondaryMenuDismiss"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
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
    
    func playConfettiSound() {
        guard let path = Bundle.main.path(forResource: "confettiSound", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            playerTwo = try AVAudioPlayer(contentsOf: url)
            playerTwo?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playConfirmationSound() {
        guard let path = Bundle.main.path(forResource: "confirmationSound", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            playerThree = try AVAudioPlayer(contentsOf: url)
            playerThree?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
