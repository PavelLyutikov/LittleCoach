//
//  MenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 28.12.2021.
//

import UIKit
import SnapKit
import Lottie
import AVFoundation


class MenuViewController: UIViewController, UIScrollViewDelegate {

    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    
    var checkLanguage = ""
    
    var buttonBasicProgress = UserDefaults.standard.integer(forKey: "buttonBasicProgress")
    var buttonTimeProgress = UserDefaults.standard.integer(forKey: "buttonTimeProgress")
    var buttonPersonProgress = UserDefaults.standard.integer(forKey: "buttonPersonProgress")
    var buttonFoodProgress = UserDefaults.standard.integer(forKey: "buttonFoodProgress")
    
    var totalWordsLearned = UserDefaults.standard.integer(forKey: "totalWordsLearned")
    
//    var questionsModel = QuestionModel()
    
    let shapeLAyerBasic = CAShapeLayer()
    let shapeLAyerTime = CAShapeLayer()
    let shapeLAyerPerson = CAShapeLayer()
    let shapeLAyerFood = CAShapeLayer()
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let timeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let personAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let foodAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    let animationTimeButtonView = AnimationView(name: "lock")
    let animationPersonButtonView = AnimationView(name: "lock")
    let animationFoodButtonView = AnimationView(name: "lock")
    
    let animationPersonWorkingView = AnimationView(name: "personWorking")
    
    var lastOffset: CGPoint = .zero
    var lastOffsetCapture: TimeInterval = .zero
    var isScrollingFast: Bool = false
    var buttonTwoShow: Bool = false
    
    var positionScrollView = 0.0
    private var lastContentOffset: CGFloat = 0
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkingImageLanguage()
        spawnBackgroundView()

        aboveScrollView.isUserInteractionEnabled = false
        underScrollView.isUserInteractionEnabled = false
        
        
        spawnBasicButtonView()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            self.spawnTimeButtonView()
            self.spawnPersonButtonView()
            self.spawnFoodButtonView()

            self.aboveScrollView.isUserInteractionEnabled = true
            self.underScrollView.isUserInteractionEnabled = true
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.spawnBlackboardInfoButton()
        }

        //ScrollView
        underSetupScrollView()
        setupScrollView()
        aboveScrollView.delegate = self
        underScrollView.delegate = self
        
        
//        notification
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.refresh), name: NSNotification.Name(rawValue: "secondaryMenuDismiss"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.infoBlackboardAnimation), name: NSNotification.Name(rawValue: "infoBlackboardDismiss"), object: nil)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                self.spawnAnimationProgress()
        }
        
        UserDefaults.standard.set(true, forKey: "OpeningNotificationIfEnglishLevelA2")
        
        if !UserDefaults.standard.bool(forKey: "isFirstOpeningMainMenu") {
            firstOpeningMenu()

            Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { (timer) in
                self.animationInfoBlackboard()
                
            }
        }
    }
    
//MARK: - CheckingImageLanguage
    func checkingImageLanguage() {
        switch Locale.current.languageCode {
        case "ru":
            checkLanguage = ""
        case "tr":
            checkLanguage = "TR"
        case "es":
            checkLanguage = "ES"
        default:
            checkLanguage = ""
        }
    }
//MARK: - SpawnView
    func firstOpeningMenu() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            UserDefaults.standard.set(true, forKey: "isFirstOpeningMainMenu")
            
            let vc = PreviewMainMenuViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

            let transition = CATransition()
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
        }
    }
    func spawnBackgroundView() {
        
        //Background
        self.view.backgroundColor = #colorLiteral(red: 0.0007665856392, green: 0.2268449068, blue: 0.2813578248, alpha: 1)
        backgroundImage.isHidden = false
        
        
        underBackgroundImage.isHidden = false
        roadBackgroundImage.isHidden = false
        roadBackgroundImage2.isHidden = false
        totalWordsLearnedLabel.isHidden = false
        davidingLineImage.isHidden = false
        refreshLevelEnglish()
        englishLevelLabel.isHidden = false
    }
    
    func spawnBasicButtonView() {
        backgroundViewBasicButton.isHidden = false
        
        backgroundBasicButton.isHidden = false
        titleBasicImageButton.isHidden = false
        
        buttonBasicCircleProgress()
        
        buttonBasic.addTarget(self, action: #selector(buttonBasicAction(sender:)), for: .touchUpInside)
    }
    func spawnTimeButtonView() {
        backgroundTimeButton.isHidden = false
        titleTimeImageButton.isHidden = false
        
        buttonTimeCircleProgress()

        buttonTime.addTarget(self, action: #selector(buttonTimeAction(sender:)), for: .touchUpInside)
    }
    func spawnPersonButtonView() {
        backgroundPersonButton.isHidden = false
        titlePersonImageButton.isHidden = false
        
        buttonPersonCircleProgress()
        
        buttonPerson.addTarget(self, action: #selector(buttonPersonAction(sender:)), for: .touchUpInside)
    }
    func spawnFoodButtonView() {
        backgroundFoodButton.isHidden = false
        titleFoodImageButton.isHidden = false
        
        buttonFoodCircleProgress()
        
        buttonFood.addTarget(self, action: #selector(buttonFoodAction(sender:)), for: .touchUpInside)
    }
    
    func spawnAnimationProgress() {
        colorProgress()
        playProgress()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.updateProgress()
            self.scrollWhenOpening()
        }
    }
    
    func spawnBlackboardInfoButton() {
        buttonBlackboardInfo.addTarget(self, action: #selector(buttonBlackboardInfoAction(sender:)), for: .touchUpInside)
        
        
        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 70
        } else if totalSize.height <= 670 {
            positY = 60
        } else {
            positY = 45
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY)
        })
    }
    //animationPersonWorking
    func spawnAnimationPersonWorking() {
        blackboard.isHidden = false
        infoNotification.isHidden = false
        animationPersonWorking()
    }
    
//MARK: - Refresh
    @objc func refresh() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in

            self.buttonBasicProgress = UserDefaults.standard.integer(forKey: "buttonBasicProgress")
            self.buttonTimeProgress = UserDefaults.standard.integer(forKey: "buttonTimeProgress")
            self.buttonPersonProgress = UserDefaults.standard.integer(forKey: "buttonPersonProgress")
            self.buttonFoodProgress = UserDefaults.standard.integer(forKey: "buttonFoodProgress")
            
            self.totalWordsLearned = UserDefaults.standard.integer(forKey: "totalWordsLearned")
            
            self.colorProgress()
            self.playProgress()
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                self.updateProgress()
            }
            self.totalWordsLearnedLabel.text = "Слов в запасе:".localized() + "  \n       ".localized() + "\(self.totalWordsLearned)"
            
            
            self.refreshLevelEnglish()
            
            
            //blacboard
            var positY: CGFloat!
            if self.totalSize.height >= 920 {
                positY = 60
            } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                positY = 55
            } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                positY = 45
            } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                positY = 70
            } else if self.totalSize.height <= 670 {
                positY = 60
            } else {
                positY = 45
            }
            UIView.animate(withDuration: 0.6, animations: {
                self.blackboard.transform = CGAffineTransform(translationX: 0, y: 0)
                self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY)
            })
            
            self.spawnNotificationEnglishLevel()
        }
    }
    
    func refreshLevelEnglish() {
        var txtLvlEng: String!
        if totalWordsLearned <= 1500 {
            txtLvlEng = "A1"
        } else if totalWordsLearned >= 1501 && totalWordsLearned <= 2500 {
            txtLvlEng = "A2"
        } else if totalWordsLearned >= 2501 && totalWordsLearned <= 3200 {
            txtLvlEng = "B1"
        } else if totalWordsLearned >= 3201 && totalWordsLearned <= 3700 {
            txtLvlEng = "B2"
        } else if totalWordsLearned >= 3701 && totalWordsLearned <= 4500 {
            txtLvlEng = "C1"
        } else if totalWordsLearned >= 4500 {
            txtLvlEng = "C2"
        }
        
        englishLevelLabel.text = txtLvlEng
    }
    
    @objc func infoBlackboardAnimation() {
        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 70
        } else if totalSize.height <= 670 {
            positY = 60
        } else {
            positY = 45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.blackboard.transform = CGAffineTransform(translationX: 0, y: 0)
            self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY)
        })
    }
    
//MARK: - SpawnNotificationEnglishLevel
    func spawnNotificationEnglishLevel() {
        if totalWordsLearned >= 1501 && totalWordsLearned <= 2500 {
            if !UserDefaults.standard.bool(forKey: "OpeningNotificationIfEnglishLevelA2") {
                
                let vc = NotificationEnglishLevelUnlockViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "OpeningNotificationIfEnglishLevelA2")
            }
        } else if totalWordsLearned >= 2501 && totalWordsLearned <= 3200 {
            if !UserDefaults.standard.bool(forKey: "OpeningNotificationIfEnglishLevelB1") {
                
                let vc = NotificationEnglishLevelUnlockViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "OpeningNotificationIfEnglishLevelB1")
            }
        } else if totalWordsLearned >= 3201 && totalWordsLearned <= 3700 {
            if !UserDefaults.standard.bool(forKey: "OpeningNotificationIfEnglishLevelB2") {
                
                let vc = NotificationEnglishLevelUnlockViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "OpeningNotificationIfEnglishLevelB2")
            }
        } else if totalWordsLearned >= 3701 && totalWordsLearned <= 4500 {
            if !UserDefaults.standard.bool(forKey: "OpeningNotificationIfEnglishLevelC1") {
                
                let vc = NotificationEnglishLevelUnlockViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "OpeningNotificationIfEnglishLevelC1")
            }
        } else if totalWordsLearned >= 4501 {
            if !UserDefaults.standard.bool(forKey: "OpeningNotificationIfEnglishLevelC2") {
                
                let vc = NotificationEnglishLevelUnlockViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "OpeningNotificationIfEnglishLevelC2")
            }
        }
    }
    
//MARK: - UpdateProgress
    func updateProgress() {
        //unlockTimeLevel
        if buttonBasicProgress >= 56 {
            UserDefaults.standard.set(true, forKey: "isTimeLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isTimeLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockTimeLevel") {
                UIView.animate(withDuration: 1.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 510.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 550.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 545.0), animated: false)
                    } else {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 490.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    self.animationTimeButtonView.play { (finished) in
                        self.animationTimeButtonView.isHidden = true
                        }
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 1.0, animations: {
                            self.titleTimeImageButton.image = UIImage(named: "tabletMainMenuTime" + self.checkLanguage)
                            self.backgroundTimeButton.image = UIImage(named: "timeButtonBackground")
                            self.timeButtonView.isUserInteractionEnabled = true
                            })
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockTimeLevel")
        } else {
            self.animationTimeLock()
            self.titleTimeImageButton.image = UIImage(named: "tabletMainMenuTimeGray" + self.checkLanguage)
            self.backgroundTimeButton.image = UIImage(named: "timeButtonBackgroundGray")
            self.timeButtonView.isUserInteractionEnabled = false
        }
        
        //unlockPersonLevel
        if buttonTimeProgress >= 78 {
            UserDefaults.standard.set(true, forKey: "isPersonLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isPersonLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockPersonLevel") {
                UIView.animate(withDuration: 1.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1040.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1040.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1060.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1110.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1110.0), animated: false)
                    } else {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1060.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    self.animationPersonButtonView.play { (finished) in
                        self.animationPersonButtonView.isHidden = true
                        }
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 1.0, animations: {
                            self.titlePersonImageButton.image = UIImage(named: "tabletMainMenuPerson" + self.checkLanguage)
                            self.backgroundPersonButton.image = UIImage(named: "personButtonBackground")
                            self.personButtonView.isUserInteractionEnabled = true
                            })
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockPersonLevel")
        } else {
            self.animationPersonLock()
            self.titlePersonImageButton.image = UIImage(named: "tabletMainMenuPersonGray" + self.checkLanguage)
            self.backgroundPersonButton.image = UIImage(named: "personButtonBackgroundGray")
            self.personButtonView.isUserInteractionEnabled = false
        }
        
        //unlockFoodLevel
        if buttonPersonProgress >= 86 {
            UserDefaults.standard.set(true, forKey: "isFoodLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isFoodLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockFoodLevel") {
                UIView.animate(withDuration: 1.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1640.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1625.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1635.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1680.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1680.0), animated: false)
                    } else {
                        self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1635.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    self.animationFoodButtonView.play { (finished) in
                        self.animationFoodButtonView.isHidden = true
                        }
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                        UIView.animate(withDuration: 1.0, animations: {
                            self.titleFoodImageButton.image = UIImage(named: "tabletMainMenuFood" + self.checkLanguage)
                            self.backgroundFoodButton.image = UIImage(named: "foodButtonBackground")
                            self.foodButtonView.isUserInteractionEnabled = true
                            })
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockFoodLevel")
        } else {
            self.animationFoodLock()
            self.titleFoodImageButton.image = UIImage(named: "tabletMainMenuFoodGray" + self.checkLanguage)
            self.backgroundFoodButton.image = UIImage(named: "foodButtonBackgroundGray")
            self.foodButtonView.isUserInteractionEnabled = false
        }
    }
    
//MARK: - ScrollWhenOpening
    func scrollWhenOpening() {
        
        //timeUnlock
        if UserDefaults.standard.bool(forKey: "isTimeLevelUnlock") {
            UIView.animate(withDuration: 1.5, animations: {
                if self.totalSize.height >= 920 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 510.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 550.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 545.0), animated: false)
                } else {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 490.0), animated: false)
                }
            })
        }
        
        //personUnlock
        if UserDefaults.standard.bool(forKey: "isPersonLevelUnlock") {
            UIView.animate(withDuration: 1.5, animations: {
                if self.totalSize.height >= 920 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1040.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1040.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1060.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1110.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1110.0), animated: false)
                } else {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1060.0), animated: false)
                }
            })
        }
        
        //foodUnlock
        if UserDefaults.standard.bool(forKey: "isFoodLevelUnlock") {
            UIView.animate(withDuration: 1.5, animations: {
                if self.totalSize.height >= 920 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1640.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1625.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1635.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1680.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1680.0), animated: false)
                } else {
                    self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: 1635.0), animated: false)
                }
            })
        }
        
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            let positY = self.aboveScrollView.contentOffset.y + 0.5

            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                self.aboveScrollView.setContentOffset(CGPoint(x: 0.0, y: positY), animated: false)
            }
        }
    }
    
//MARK: PlayProgress
    func playProgress(){
        
        //basicAnimation
        basicAnimation.fromValue = basicAnimation.toValue
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.both

        if CGFloat(buttonBasicProgress) > 73 || CGFloat(buttonBasicProgress) < 0 {
            return
        }
        basicAnimation.toValue = CGFloat(buttonBasicProgress)/73
        shapeLAyerBasic.add(basicAnimation, forKey: "urSoBasic")
        
        //timeAnimation
        timeAnimation.fromValue = timeAnimation.toValue
        timeAnimation.isRemovedOnCompletion = false
        timeAnimation.duration = 0.5
        timeAnimation.fillMode = CAMediaTimingFillMode.both
        
        if CGFloat(buttonTimeProgress) > 104 || CGFloat(buttonTimeProgress) < 0 {
            return
        }
        timeAnimation.toValue = CGFloat(buttonTimeProgress)/104
        shapeLAyerTime.add(timeAnimation, forKey: "urSoBasic")
                
        //personAnimation
        personAnimation.fromValue = personAnimation.toValue
        personAnimation.isRemovedOnCompletion = false
        personAnimation.duration = 0.5
        personAnimation.fillMode = CAMediaTimingFillMode.both
        
        if CGFloat(buttonPersonProgress) > 123 || CGFloat(buttonPersonProgress) < 0 {
            return
        }
        personAnimation.toValue = CGFloat(buttonPersonProgress)/123
        shapeLAyerPerson.add(personAnimation, forKey: "urSoBasic")
        
        //foodAnimation
        foodAnimation.fromValue = foodAnimation.toValue
        foodAnimation.isRemovedOnCompletion = false
        foodAnimation.duration = 0.5
        foodAnimation.fillMode = CAMediaTimingFillMode.both
        
        if CGFloat(buttonFoodProgress) > 180 || CGFloat(buttonFoodProgress) < 0 {
            return
        }
        foodAnimation.toValue = CGFloat(buttonFoodProgress)/180
        shapeLAyerFood.add(foodAnimation, forKey: "urSoBasic")
    }
    
//MARK: Blackboard
    lazy var blackboard: UIImageView = {
        let img = UIImageView(image: UIImage(named: "mainMenuBlackboard"))
        img.layer.zPosition = 22
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
//        img.alpha = 0
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
        lbl.text = "Слов в запасе:".localized() + "  \n       ".localized() + "\(totalWordsLearned)"
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
    
//MARK: - BlackboardInfoButton
    lazy var buttonBlackboardInfo: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "blackboardInfoButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        btn.adjustsImageWhenHighlighted = false
        self.view.addSubview(btn)
        
        
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
        
        btn.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        return btn
    }()
    @objc func buttonBlackboardInfoAction(sender: UIButton) {
        
        playPressSound()
        
        UserDefaults.standard.set(true, forKey: "infoBlackboardButtonAnimationActive")
        
        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 75
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 65
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 90
        } else if totalSize.height <= 670 {
            positY = 80
        } else {
            positY = 65
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY)
        })
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.6, animations: {
                self.blackboard.transform = CGAffineTransform(translationX: 0, y: -200)
                self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: -200)
            })
        }
        
        
        Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false) { (timer) in
            let vc = InfoBlackboardViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

            let transition = CATransition()
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
        }
    }
    
//MARK: BasicButton
    lazy var basicButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(-1185)
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
        
        UserDefaults.standard.set(true, forKey: "infoBlackboardButtonAnimationActive")
        UserDefaults.standard.set(true, forKey: "firstOpeningBasicButton")

        playPressSound()
        
        
        if !UserDefaults.standard.bool(forKey: "infoBlackboardButtonStopAnimation") {
        
            UIView.animate(withDuration: 0.6, animations: {
                self.blackboard.transform = CGAffineTransform(translationX: 0, y: -140)
                self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: -140)
                
            })
            
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                let vc = BasicMenuViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                
                let transition = CATransition()
                transition.duration = 0.6
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
            }
            
        } else {
            
            Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.6, animations: {
                    self.blackboard.transform = CGAffineTransform(translationX: 0, y: -140)
                    self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: -140)
                    
                })
                
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                    let vc = BasicMenuViewController()
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                    
                    let transition = CATransition()
                    transition.duration = 0.6
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                    self.view.window!.layer.add(transition, forKey: kCATransition)

                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
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
        
        
        if !UserDefaults.standard.bool(forKey: "firstOpeningBasicButton") {
                Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { (timer) in
                    if !UserDefaults.standard.bool(forKey: "firstOpeningBasicButton") {
                        if UserDefaults.standard.bool(forKey: "isFirstOpeningEnglishLevelViewController") == true {
                        UIView.animate(withDuration: 0.3, animations: {
                            progressLayer.shadowColor = #colorLiteral(red: 0, green: 0.8043571466, blue: 1, alpha: 1)
                            progressLayer.shadowRadius = 15
                            progressLayer.shadowOpacity = 0.8
                        })
                        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                            UIView.animate(withDuration: 0.3, animations: {
                                progressLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                                progressLayer.shadowRadius = 5
                                progressLayer.shadowOpacity = 0.3
                            })
                        }
                        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (timer) in
                            UIView.animate(withDuration: 0.3, animations: {
                                progressLayer.shadowColor = #colorLiteral(red: 0, green: 0.8043571466, blue: 1, alpha: 1)
                                progressLayer.shadowRadius = 15
                                progressLayer.shadowOpacity = 0.8
                            })
                        }
                        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (timer) in
                            UIView.animate(withDuration: 0.3, animations: {
                                progressLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                                progressLayer.shadowRadius = 5
                                progressLayer.shadowOpacity = 0.3
                            })
                        }
                    }
                }
            }
        }
        view.layer.addSublayer(progressLayer)
        basicButtonView.layer.addSublayer(progressLayer)

        shapeLAyerBasic.path = circularPath2.cgPath
        shapeLAyerBasic.position = CGPoint(x: positX, y: positY)
        shapeLAyerBasic.fillColor = UIColor.clear.cgColor
        shapeLAyerBasic.strokeColor = UIColor.green.cgColor
        shapeLAyerBasic.lineWidth = 7
        shapeLAyerBasic.lineCap = .round
        shapeLAyerBasic.strokeEnd = 0
        shapeLAyerBasic.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shapeLAyerBasic.shadowRadius = 5
        shapeLAyerBasic.shadowOffset = CGSize(width: 0, height: 0)
        shapeLAyerBasic.shadowOpacity = 0.3
        view.layer.addSublayer(shapeLAyerBasic)
        basicButtonView.layer.addSublayer(shapeLAyerBasic)
    }
    //TabletImage
    lazy var titleBasicImageButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tabletMainMenuStart" + checkLanguage))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        basicButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(-230)
        }
        return img
    }()
    //BacgroundImage
    lazy var backgroundBasicButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "sunriseBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        basicButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(370)
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(-10)
        }
        
        return img
    }()
    lazy var backgroundViewBasicButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "basicButtonViewBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        basicButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(-80)
        }
        
        return img
    }()
    
//MARK: TimeButton
    lazy var timeButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(-660)
            make.centerXWithinMargins.equalTo(10)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var buttonTime: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "timeButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        self.view.addSubview(btn)
        timeButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        return btn
    }()
    @objc func buttonTimeAction(sender: UIButton) {
        UserDefaults.standard.set("misterWatch", forKey: "animationName")

        playPressSound()
        
        UIView.animate(withDuration: 0.6, animations: {
            self.blackboard.transform = CGAffineTransform(translationX: 0, y: -140)
            self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: -140)
        })
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            let vc = TimeMenuViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            
            let transition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func buttonTimeCircleProgress() {
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
        timeButtonView.layer.addSublayer(progressLayer)

        shapeLAyerTime.path = circularPath2.cgPath
        shapeLAyerTime.position = CGPoint(x: positX, y: positY)
        shapeLAyerTime.fillColor = UIColor.clear.cgColor
        shapeLAyerTime.strokeColor = UIColor.green.cgColor
        shapeLAyerTime.lineWidth = 7
        shapeLAyerTime.lineCap = .round
        shapeLAyerTime.strokeEnd = 0
        shapeLAyerTime.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shapeLAyerTime.shadowRadius = 5
        shapeLAyerTime.shadowOffset = CGSize(width: 0, height: 0)
        shapeLAyerTime.shadowOpacity = 0.3
        view.layer.addSublayer(shapeLAyerTime)
        timeButtonView.layer.addSublayer(shapeLAyerTime)
    }
    //TabletImage
    lazy var titleTimeImageButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tabletMainMenuTime" + checkLanguage))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        timeButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.centerXWithinMargins.equalTo(-35)
            make.centerYWithinMargins.equalTo(-210)
        }
        
        return img
    }()
    //BacgroundImage
    lazy var backgroundTimeButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "timeButtonBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        timeButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(370)
            make.centerXWithinMargins.equalTo(-15)
            make.centerYWithinMargins.equalTo(10)
        }
        
        return img
    }()
    //lock
    func animationTimeLock() {
        animationTimeButtonView.contentMode = .scaleAspectFit
        animationTimeButtonView.loopMode = .playOnce
        animationTimeButtonView.layer.zPosition = 10
        self.view.addSubview(animationTimeButtonView)
        backgroundView.addSubview(animationTimeButtonView)
        
        animationTimeButtonView.snp.makeConstraints { make in
            make.width.height.equalTo(180)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-710)
        }
    }
    
//MARK: PersonButton
    lazy var personButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(-100)
            make.centerXWithinMargins.equalTo(30)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var buttonPerson: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "personButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        self.view.addSubview(btn)
        personButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70)
        }
        
        return btn
    }()
    
    @objc func buttonPersonAction(sender: UIButton) {
        UserDefaults.standard.set("person", forKey: "animationName")

        playPressSound()
        
        UIView.animate(withDuration: 0.6, animations: {
            self.blackboard.transform = CGAffineTransform(translationX: 0, y: -140)
            self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: -140)
        })
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            let vc = PersonMenuViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            
            let transition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func buttonPersonCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 10, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        let circularPath2 = UIBezierPath(arcCenter: view.center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -427
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -412
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -387
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -332
            positX = -108
        } else if totalSize.height <= 670 {
            positY = -297
            positX = -88
        } else {
            positY = -370
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
        personButtonView.layer.addSublayer(progressLayer)

        shapeLAyerPerson.path = circularPath2.cgPath
        shapeLAyerPerson.position = CGPoint(x: positX, y: positY)
        shapeLAyerPerson.fillColor = UIColor.clear.cgColor
        shapeLAyerPerson.strokeColor = UIColor.green.cgColor
        shapeLAyerPerson.lineWidth = 7
        shapeLAyerPerson.lineCap = .round
        shapeLAyerPerson.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shapeLAyerPerson.shadowRadius = 5
        shapeLAyerPerson.shadowOffset = CGSize(width: 0, height: 0)
        shapeLAyerPerson.shadowOpacity = 0.3
        shapeLAyerPerson.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerPerson)
        personButtonView.layer.addSublayer(shapeLAyerPerson)
    }
    //TabletImage
    lazy var titlePersonImageButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tabletMainMenuPerson" + checkLanguage))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        personButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-210)
        }
        
        return img
    }()
    //BacgroundImage
    lazy var backgroundPersonButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "personButtonBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        personButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(370)
            make.centerXWithinMargins.equalTo(-35)
            make.centerYWithinMargins.equalTo(40)
        }
        
        return img
    }()
    //lock
    func animationPersonLock() {
        animationPersonButtonView.contentMode = .scaleAspectFit
        animationPersonButtonView.loopMode = .playOnce
        animationPersonButtonView.layer.zPosition = 10
        self.view.addSubview(animationPersonButtonView)
        backgroundView.addSubview(animationPersonButtonView)
        
        animationPersonButtonView.snp.makeConstraints { make in
            make.width.height.equalTo(180)
            make.centerXWithinMargins.equalTo(30)
            make.centerYWithinMargins.equalTo(-165)
        }
    }
    
    
//MARK: FoodButton
    lazy var foodButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(460)
            make.centerXWithinMargins.equalTo(-30)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var buttonFood: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "foodButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        self.view.addSubview(btn)
        foodButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(85)
        }
        
        return btn
    }()
    
    @objc func buttonFoodAction(sender: UIButton) {
        UserDefaults.standard.set("misterTomato", forKey: "animationName")

        playPressSound()
        
        UIView.animate(withDuration: 0.6, animations: {
            self.blackboard.transform = CGAffineTransform(translationX: 0, y: -140)
            self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: -140)
        })
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            let vc = FoodMenuViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            
            let transition = CATransition()
            transition.duration = 0.6
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func buttonFoodCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 10, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        let circularPath2 = UIBezierPath(arcCenter: view.center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -421.5
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -406
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -380.5
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -326
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -291.5
            positX = -87.5
        } else {
            positY = -364.5
            positX = -87.3
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
        foodButtonView.layer.addSublayer(progressLayer)

        shapeLAyerFood.path = circularPath2.cgPath
        shapeLAyerFood.position = CGPoint(x: positX, y: positY)
        shapeLAyerFood.fillColor = UIColor.clear.cgColor
        shapeLAyerFood.strokeColor = UIColor.green.cgColor
        shapeLAyerFood.lineWidth = 7
        shapeLAyerFood.lineCap = .round
        shapeLAyerFood.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shapeLAyerFood.shadowRadius = 5
        shapeLAyerFood.shadowOffset = CGSize(width: 0, height: 0)
        shapeLAyerFood.shadowOpacity = 0.3
        shapeLAyerFood.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerFood)
        foodButtonView.layer.addSublayer(shapeLAyerFood)
    }
    
    //TabletImage
    lazy var titleFoodImageButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "tabletMainMenuFood" + checkLanguage))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        foodButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-210)
        }
        
        return img
    }()
    
    //BacgroundImage
    lazy var backgroundFoodButton: UIImageView = {
        let img = UIImageView(image: UIImage(named: "foodButtonBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 10
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.4
        self.view.addSubview(img)
        foodButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(370)
            make.centerXWithinMargins.equalTo(35)
            make.centerYWithinMargins.equalTo(50)
        }
        
        return img
    }()
    
    //lock
    func animationFoodLock() {
        animationFoodButtonView.contentMode = .scaleAspectFit
        animationFoodButtonView.loopMode = .playOnce
        animationFoodButtonView.layer.zPosition = 10
        self.view.addSubview(animationFoodButtonView)
        backgroundView.addSubview(animationFoodButtonView)
        
        animationFoodButtonView.snp.makeConstraints { make in
            make.width.height.equalTo(180)
            make.centerXWithinMargins.equalTo(-30)
            make.centerYWithinMargins.equalTo(400)
        }
    }
//MARK: - ColorProgress
    func colorProgress() {
        
        //basic
        if buttonBasicProgress >= 60 {
            shapeLAyerBasic.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonBasicProgress >= 45 {
            shapeLAyerBasic.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonBasicProgress >= 30 {
            shapeLAyerBasic.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonBasicProgress >= 15 {
            shapeLAyerBasic.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonBasicProgress >= 0 {
            shapeLAyerBasic.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //time
        if buttonTimeProgress >= 60 {
            shapeLAyerTime.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonTimeProgress >= 45 {
            shapeLAyerTime.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonTimeProgress >= 30 {
            shapeLAyerTime.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonTimeProgress >= 15 {
            shapeLAyerTime.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonTimeProgress >= 0 {
            shapeLAyerTime.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //person
        if buttonPersonProgress >= 86 {
            shapeLAyerPerson.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonPersonProgress >= 64 {
            shapeLAyerPerson.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonPersonProgress >= 43 {
            shapeLAyerPerson.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonPersonProgress >= 21 {
            shapeLAyerPerson.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonPersonProgress >= 0 {
            shapeLAyerPerson.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //food
        if buttonFoodProgress >= 126 {
            shapeLAyerFood.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonFoodProgress >= 94 {
            shapeLAyerFood.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonFoodProgress >= 63 {
            shapeLAyerFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonFoodProgress >= 31 {
            shapeLAyerFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonFoodProgress >= 0 {
            shapeLAyerFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
    }
    
//MARK: ScrollView
    let aboveScrollView: UIScrollView = {
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
        view.heightAnchor.constraint(equalToConstant: 4000).isActive = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "backgroundMenu"))
        img.contentMode = .scaleToFill
        self.view.addSubview(img)

        img.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }

        return img
    }()
    
    //Road
    lazy var roadBackgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "roadBackgroundMainMenu"))
        img.contentMode = .scaleAspectFit
        img.alpha = 0.7
        self.view.addSubview(img)
        backgroundView.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-410)
            make.width.equalTo(160)
        }

        return img
    }()
    lazy var roadBackgroundImage2: UIImageView = {
        let img = UIImageView(image: UIImage(named: "roadBackgroundMainMenu"))
        img.contentMode = .scaleAspectFit
        img.alpha = 0.7
        self.view.addSubview(img)
        backgroundView.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(1640)
            make.width.equalTo(160)
        }

        return img
    }()
    
    //PersonWorkingAnimation
    func animationPersonWorking() {
        animationPersonWorkingView.contentMode = .scaleAspectFit
        animationPersonWorkingView.loopMode = .autoReverse
        animationPersonWorkingView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationPersonWorkingView.layer.shadowRadius = 12
        animationPersonWorkingView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationPersonWorkingView.layer.shadowOpacity = 0.4
        self.view.addSubview(animationPersonWorkingView)
        backgroundView.addSubview(animationPersonWorkingView)
        
        animationPersonWorkingView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(1370)
        }
    }
    lazy var infoNotification: UIImageView = {
        var imgName: String!
        switch Locale.current.languageCode {
        case "ru":
            imgName = "infoNotification"
        case "tr":
            imgName = "infoNotificationTR"
        case "es":
            imgName = "infoNotificationES"
        default:
            imgName = "infoNotification"
        }
        
        let img = UIImageView(image: UIImage(named: imgName))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 12
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
        self.view.addSubview(img)
        backgroundView.addSubview(img)

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(30)
            make.centerYWithinMargins.equalTo(1490)
            make.width.equalTo(230)
        }

        return img
    }()
    
    func setupScrollView() {
        view.addSubview(aboveScrollView)
        aboveScrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(backgroundView)
        
        var topPosit: CGFloat!
        if totalSize.height >= 920 {
            topPosit = -250
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            topPosit = -270
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            topPosit = -280
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = -280
        } else if totalSize.height <= 670 {
            topPosit = -330
        } else {
            topPosit = -300
        }

        aboveScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        aboveScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        aboveScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        aboveScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: aboveScrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: aboveScrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: aboveScrollView.topAnchor, constant: topPosit).isActive = true
        
        var bttmPosit: CGFloat!
        if totalSize.height >= 671 && totalSize.height <= 800 {
            bttmPosit = 570
        } else if totalSize.height <= 670 {
            bttmPosit = 570
        } else {
            bttmPosit = 600
        }
        scrollViewContainer.bottomAnchor.constraint(equalTo: aboveScrollView.bottomAnchor, constant: bttmPosit).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: aboveScrollView.widthAnchor).isActive = true
    }
    
//MARK: UnderScrollView
    let underScrollView: UIScrollView = {
        let underScrollView = UIScrollView()

        underScrollView.translatesAutoresizingMaskIntoConstraints = false
        return underScrollView
    }()

    let underScrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let underBackgroundView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var underBackgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "backgroundUnderMainMenu"))
        img.contentMode = .scaleAspectFit
        img.alpha = 0.6
        self.view.addSubview(img)
        underBackgroundView.addSubview(img)

        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = 1070
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1050
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1010
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 970
        } else if totalSize.height <= 670 {
            positY = 970
        } else {
            positY = 1000
        }
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
            make.leading.trailing.equalToSuperview().inset(-10)
        }

        return img
    }()
    
    func underSetupScrollView() {
        view.addSubview(underScrollView)
        underScrollView.addSubview(underScrollViewContainer)
        underScrollViewContainer.addArrangedSubview(underBackgroundView)
        
        var topPosit: CGFloat!
        if totalSize.height >= 920 {
            topPosit = -250
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            topPosit = -290
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            topPosit = -350
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            topPosit = -310
        } else if totalSize.height <= 670 {
            topPosit = -430
        } else {
            topPosit = -410
        }

        underScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        underScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        underScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        underScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        underScrollViewContainer.leadingAnchor.constraint(equalTo: underScrollView.leadingAnchor).isActive = true
        underScrollViewContainer.trailingAnchor.constraint(equalTo: underScrollView.trailingAnchor).isActive = true
        underScrollViewContainer.topAnchor.constraint(equalTo: underScrollView.topAnchor, constant: topPosit).isActive = true
        underScrollViewContainer.bottomAnchor.constraint(equalTo: underScrollView.bottomAnchor, constant: -650).isActive = true
        
        // this is important for scrolling
        underScrollViewContainer.widthAnchor.constraint(equalTo: underScrollView.widthAnchor).isActive = true
    }
    
//MARK: - ScrollViewAnimation
    func scrollViewDidScroll(_ scrolled: UIScrollView) {

        let currentOffset = scrolled.contentOffset
        let currentTime = Date.timeIntervalSinceReferenceDate
        let timeDiff = currentTime - lastOffsetCapture
        let captureInterval = 0.1
        
        if timeDiff > captureInterval {
            
            let distance = currentOffset.y - lastOffset.y     // calc distance
            let scrollSpeedNotAbs = (distance * 10) / 1000     // pixels per ms*10
            let scrollSpeed = fabsf(Float(scrollSpeedNotAbs))  // absolute value
            
            if scrollSpeed > 0.5 {
                isScrollingFast = true
//                print("Fast")
            } else {
                isScrollingFast = false
//                print("Slow")
            }
                        
            lastOffset = currentOffset
            lastOffsetCapture = currentTime
            
            
            //autoScroll
//            print(aboveScrollView.contentOffset.y)
            
            //startButton
            if aboveScrollView.contentOffset.y <= 270.0 {
                if buttonTwoShow == true {
                    if totalSize.height >= 920 {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                        })
                    } else if totalSize.height >= 890 && totalSize.height <= 919 {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                        })
                    } else if totalSize.height >= 830 && totalSize.height <= 889 {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: -48.0), animated: false)
                        })
                    } else if totalSize.height >= 671 && totalSize.height <= 800 {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
                        })
                    } else if totalSize.height <= 670 {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 20.0), animated: false)
                        })
                    } else {
                        UIView.animate(withDuration: 1.5, animations: {
                            self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: -40.0), animated: false)
                        })
                    }
                }
            //timeButton
            } else if aboveScrollView.contentOffset.y >= 271.0 && aboveScrollView.contentOffset.y <= 829.0 {
                
                buttonTwoShow = true
                
                if totalSize.height >= 920 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 870.0), animated: false)
                    })
                } else if totalSize.height >= 890 && totalSize.height <= 919 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 850.0), animated: false)
                    })
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 810.0), animated: false)
                    })
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 900.0), animated: false)
                    })
                } else if totalSize.height <= 670 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 840.0), animated: false)
                    })
                } else {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 770.0), animated: false)
                    })
                }
                
            //personButton
            } else if aboveScrollView.contentOffset.y >= 830.0 && aboveScrollView.contentOffset.y <= 1379.0 {
                
                if totalSize.height >= 920 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 1780.0), animated: false)
                    })
                } else if totalSize.height >= 890 && totalSize.height <= 919 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 1730.0), animated: false)
                    })
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 1630.0), animated: false)
                    })
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 1780.0), animated: false)
                    })
                } else if totalSize.height <= 670 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 1650.0), animated: false)
                    })
                } else {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 1560.0), animated: false)
                    })
                }
                
            //foodButton
            } else if aboveScrollView.contentOffset.y >= 1380.0 {
                
                if totalSize.height >= 920 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 2690.0), animated: false)
                    })
                } else if totalSize.height >= 890 && totalSize.height <= 919 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 2610.0), animated: false)
                    })
                } else if totalSize.height >= 830 && totalSize.height <= 889 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 2470.0), animated: false)
                    })
                } else if totalSize.height >= 671 && totalSize.height <= 800 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 2660.0), animated: false)
                    })
                } else if totalSize.height <= 670 {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 2400.0), animated: false)
                    })
                } else {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.underScrollView.setContentOffset(CGPoint(x: 0.0, y: 2370.0), animated: false)
                    })
                }
            }
            
            
            
            if aboveScrollView.contentOffset.y >= 1300.0 {
                spawnAnimationPersonWorking()
                animationPersonWorkingView.play()
            } else {
                
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
//MARK: - PreviewAnimationInfoBlackboard
    func animationInfoBlackboard() {
        
        var positY: CGFloat!
        var positY2: CGFloat!
        if totalSize.height >= 920 {
            positY = 70
            positY2 = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 65
            positY2 = 55
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 55
            positY2 = 45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 80
            positY2 = 70
        } else if totalSize.height <= 670 {
            positY = 70
            positY2 = 60
        } else {
            positY = 55
            positY2 = 45
        }
        
        if !UserDefaults.standard.bool(forKey: "infoBlackboardButtonAnimationActive") {
            
            UserDefaults.standard.set(true, forKey: "infoBlackboardButtonStopAnimation")
            
            UIView.animate(withDuration: 0.2, animations: {
                self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY)
            })
        
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY2)
                })
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY)
                })
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.buttonBlackboardInfo.transform = CGAffineTransform(translationX: 0, y: positY2)
                })
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                    UserDefaults.standard.set(false, forKey: "infoBlackboardButtonStopAnimation")
                }
            }
        
        }
    }
}
