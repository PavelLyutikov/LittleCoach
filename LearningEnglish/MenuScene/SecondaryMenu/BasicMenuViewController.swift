//
//  BasicMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 05.01.2022.
//

import UIKit
import SnapKit
import Lottie
import AVFoundation

class BasicMenuViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    var playerTwo: AVAudioPlayer?
    var playerThree: AVAudioPlayer?
    
    var animationCrownPlay: Bool = false
    
    var buttonBasicProgress = UserDefaults.standard.integer(forKey: "buttonBasicProgress")
    
    var buttonIYouProgress = UserDefaults.standard.integer(forKey: "buttonIYouProgress")
    var buttonIYouComplexProgress = UserDefaults.standard.integer(forKey: "buttonIYouComplexProgress")
    var buttonHelloProgress = UserDefaults.standard.integer(forKey: "buttonHelloProgress")
    var buttonQuestionProgress = UserDefaults.standard.integer(forKey: "buttonQuestionProgress")
    var buttonColorProgress = UserDefaults.standard.integer(forKey: "buttonColorProgress")
    var buttonGeometricShapeProgress = UserDefaults.standard.integer(forKey: "buttonGeometricShapeProgress")
    
    var questionsModel = QuestionModel()
    
    let shapeLAyerIYou = CAShapeLayer()
    let shapeLAyerIYouComplex = CAShapeLayer()
    let shapeLAyerHello = CAShapeLayer()
    let shapeLAyerQuestion = CAShapeLayer()
    let shapeLAyerColor = CAShapeLayer()
    let shapeLAyerGeometricShape = CAShapeLayer()
    
    let iYouAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let iYouComplexAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let helloAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let questionAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let colorAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let geometricShapeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
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
        backpackImage.isHidden = false
        
        //crown
        updateCrown()
        
        //star
        starImage1.isHidden = false
        starImage2.isHidden = false
        starImage3.isHidden = false
        starImage4.isHidden = false
        starImage5.isHidden = false
        
        
        //arrow
        arrowIYouImage.isHidden = false
        arrowIYouImage2.isHidden = false
        arrowHelloImage.isHidden = false
        arrowQuestionImage.isHidden = false
        arrowColorImage.isHidden = false
        
        mainLabelUnderline.isHidden = false
        mainLabel.isHidden = false
        
        //backgroundLabel
        iYouLabel.isHidden = false
        helloLabel.isHidden = false
        questionLabel.isHidden = false
        сolorLabel.isHidden = false
        geometricShapeLabel.isHidden = false
        
        
        //setupProgress
        colorProgress()
        buttonIYouCircleProgress()
        buttonIYouComplexCircleProgress()
        buttonHelloCircleProgress()
        buttonQuestionCircleProgress()
        buttonColorCircleProgress()
        buttonGeometricShapeCircleProgress()
        playProgress()
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.updateProgress()
            self.scrollWhenOpening()
            self.starUpdate()
        }
        
        
        //Button
        iYouButton.addTarget(self, action: #selector(iYouButtonAction(sender:)), for: .touchUpInside)
        iYouComplexButton.addTarget(self, action: #selector(iYouComplexButtonAction(sender:)), for: .touchUpInside)
        helloButton.addTarget(self, action: #selector(helloButtonAction(sender:)), for: .touchUpInside)
        questionButton.addTarget(self, action: #selector(questionButtonAction(sender:)), for: .touchUpInside)
        colorButton.addTarget(self, action: #selector(colorButtonAction(sender:)), for: .touchUpInside)
        geometricShapeButton.addTarget(self, action: #selector(geometricShapeButtonAction(sender:)), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        
        //ScrollView
        setupScrollView()
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(BasicMenuViewController.refresh), name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BasicMenuViewController.lookNewLevel), name: NSNotification.Name(rawValue: "lookNewLevel"), object: nil)
        
        
        if !UserDefaults.standard.bool(forKey: "isFirstOpeningBasicMenu") {
            firstOpeningBasicMenu()
        }
    }
    
    func firstOpeningBasicMenu() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            UserDefaults.standard.set(true, forKey: "isFirstOpeningBasicMenu")
            
            let vc = PreviewSubMenuViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            let transition = CATransition()
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
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

//MARK: - RefreshScreen
    @objc func refresh() {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.buttonIYouProgress = UserDefaults.standard.integer(forKey: "buttonIYouProgress")
            self.buttonIYouComplexProgress = UserDefaults.standard.integer(forKey: "buttonIYouComplexProgress")
            self.buttonHelloProgress = UserDefaults.standard.integer(forKey: "buttonHelloProgress")
            self.buttonQuestionProgress = UserDefaults.standard.integer(forKey: "buttonQuestionProgress")
            self.buttonColorProgress = UserDefaults.standard.integer(forKey: "buttonColorProgress")
            self.buttonGeometricShapeProgress = UserDefaults.standard.integer(forKey: "buttonGeometricShapeProgress")
            
            self.updateCrown()
            self.colorProgress()
            self.playProgress()
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                self.updateProgress()
            }
            self.starUpdate()
            
            self.buttonBasicProgress = UserDefaults.standard.integer(forKey: "buttonBasicProgress")
            if self.buttonBasicProgress >= 56 {
                if !UserDefaults.standard.bool(forKey: "isFirstOpeningTimeLevel") {
                    UserDefaults.standard.set("timeLvl", forKey: "whichLevelUnlocked")
                    
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
                UserDefaults.standard.set(true, forKey: "isFirstOpeningTimeLevel")
            }
        }
    }
    
//MARK: - UpdateProgress
    func updateProgress() {
        //unlockHello/iYouComplex
        if buttonIYouProgress >= 6 {
            UserDefaults.standard.set(true, forKey: "isHelloLevelUnlock")
        }

        //unlockHello
        if UserDefaults.standard.bool(forKey: "isHelloLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockHelloLevel") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 470.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.iYouComplexButtonView.alpha = 1
                            self.iYouComplexButtonView.isUserInteractionEnabled = true
                            self.arrowIYouImage.alpha = 1
                            
                            self.helloButtonView.alpha = 1
                            self.helloButtonView.isUserInteractionEnabled = true
                            self.arrowIYouImage2.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockHelloLevel")
        } else {
            self.iYouComplexButtonView.alpha = 0.4
            self.iYouComplexButtonView.isUserInteractionEnabled = false
            self.arrowIYouImage.alpha = 0.2
            
            self.helloButtonView.alpha = 0.4
            self.helloButtonView.isUserInteractionEnabled = false
            self.arrowIYouImage2.alpha = 0.2
        }
        
        
        //unlockQuestion
        if buttonHelloProgress >= 9 {
            UserDefaults.standard.set(true, forKey: "isQuestionLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isQuestionLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockQuestionLevel") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 410.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 490.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.questionButtonView.alpha = 1
                            self.questionButtonView.isUserInteractionEnabled = true
                            self.arrowHelloImage.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockQuestionLevel")
        } else {
            self.questionButtonView.alpha = 0.4
            self.questionButtonView.isUserInteractionEnabled = false
            self.arrowHelloImage.alpha = 0.2
        }
        
        //unlockColor
        if buttonQuestionProgress >= 10 {
            UserDefaults.standard.set(true, forKey: "isColorLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isColorLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockColorLevel") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 460.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 510.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 530.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 620.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 670.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 540.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.colorButtonView.alpha = 1
                            self.colorButtonView.isUserInteractionEnabled = true
                            self.arrowQuestionImage.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockColorLevel")
        } else {
            self.colorButtonView.alpha = 0.4
            self.colorButtonView.isUserInteractionEnabled = false
            self.arrowQuestionImage.alpha = 0.2
        }
        
        //unlockGeometricShape
        if buttonColorProgress >= 10 {
            UserDefaults.standard.set(true, forKey: "isGeometricShapeLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isGeometricShapeLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockGeometricShapeLevel") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 542.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 557.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 580.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 715.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 738.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 594.0), animated: false)
                    }
                })
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.geometricShapeButtonView.alpha = 1
                            self.geometricShapeButtonView.isUserInteractionEnabled = true
                            self.arrowColorImage.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockGeometricShapeLevel")
        } else {
            self.geometricShapeButtonView.alpha = 0.4
            self.geometricShapeButtonView.isUserInteractionEnabled = false
            self.arrowColorImage.alpha = 0.2
        }
    }
//MARK: - ScrollWhenOpening
    func scrollWhenOpening() {
        UIView.animate(withDuration: 0.5, animations: {
            if self.totalSize.height >= 920 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 60.0), animated: false)
            } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 160.0), animated: false)
            } else if self.totalSize.height <= 670 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 200.0), animated: false)
            } else {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 150.0), animated: false)
            }
        })
        
        //UnlockHello
        if UserDefaults.standard.bool(forKey: "isHelloLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 470.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                }
            })
        }
        
        //UnlockQuestion
        if UserDefaults.standard.bool(forKey: "isQuestionLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 410.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 490.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                }
            })
        }
        //UnlockColor
        if UserDefaults.standard.bool(forKey: "isColorLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 460.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 510.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 530.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 620.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 670.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 540.0), animated: false)
                }
            })
        }
        //UnlockGeometricShape
        if UserDefaults.standard.bool(forKey: "isGeometricShapeLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 542.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 557.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 580.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 715.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 738.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 594.0), animated: false)
                }
            })
        }
    }
//MARK: - PlayProgress
    func playProgress() {
        //iYou
        iYouAnimation.fromValue = iYouAnimation.toValue
        iYouAnimation.isRemovedOnCompletion = false
        iYouAnimation.duration = 0.5
        iYouAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonIYouProgress) > 8 || CGFloat(buttonIYouProgress) < 0 {
                return
            }
            iYouAnimation.toValue = CGFloat(buttonIYouProgress)/8
            shapeLAyerIYou.add(iYouAnimation, forKey: "urSoBasic")
        
        //iYouComplex
        iYouComplexAnimation.fromValue = iYouComplexAnimation.toValue
        iYouComplexAnimation.isRemovedOnCompletion = false
        iYouComplexAnimation.duration = 0.5
        iYouComplexAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonIYouComplexProgress) > 10 || CGFloat(buttonIYouComplexProgress) < 0 {
                return
            }
            iYouComplexAnimation.toValue = CGFloat(buttonIYouComplexProgress)/10
                shapeLAyerIYouComplex.add(iYouComplexAnimation, forKey: "urSoBasic")

        //hello
        helloAnimation.fromValue = helloAnimation.toValue
        helloAnimation.isRemovedOnCompletion = false
        helloAnimation.duration = 0.5
        helloAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonHelloProgress) > 12 || CGFloat(buttonHelloProgress) < 0 {
                return
            }
            helloAnimation.toValue = CGFloat(buttonHelloProgress)/12
            shapeLAyerHello.add(helloAnimation, forKey: "urSoBasic")
        
        //question
        questionAnimation.fromValue = questionAnimation.toValue
        questionAnimation.isRemovedOnCompletion = false
        questionAnimation.duration = 0.5
        questionAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonQuestionProgress) > 13 || CGFloat(buttonQuestionProgress) < 0 {
                return
            }
            questionAnimation.toValue = CGFloat(buttonQuestionProgress)/13
            shapeLAyerQuestion.add(questionAnimation, forKey: "urSoBasic")
        
        //color
        colorAnimation.fromValue = colorAnimation.toValue
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.duration = 0.5
        colorAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonColorProgress) > 13 || CGFloat(buttonColorProgress) < 0 {
                return
            }
            colorAnimation.toValue = CGFloat(buttonColorProgress)/13
            shapeLAyerColor.add(colorAnimation, forKey: "urSoBasic")
        
        
        //geometricShape
        geometricShapeAnimation.fromValue = geometricShapeAnimation.toValue
        geometricShapeAnimation.isRemovedOnCompletion = false
        geometricShapeAnimation.duration = 0.5
        geometricShapeAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonGeometricShapeProgress) > 16 || CGFloat(buttonGeometricShapeProgress) < 0 {
                return
            }
            geometricShapeAnimation.toValue = CGFloat(buttonGeometricShapeProgress)/16
            shapeLAyerGeometricShape.add(geometricShapeAnimation, forKey: "urSoBasic")
        
       
//        UserDefaults.standard.set(8, forKey: "buttonIYouProgress")
//        UserDefaults.standard.set(12, forKey: "buttonHelloProgress")
//        UserDefaults.standard.set(13, forKey: "buttonQuestionProgress")
//        UserDefaults.standard.set(13, forKey: "buttonColorProgress")
//        UserDefaults.standard.set(16, forKey: "buttonGeometricShapeProgress")
        
        //saveProgress
        buttonBasicProgress = buttonIYouProgress + buttonIYouComplexProgress + buttonHelloProgress + buttonQuestionProgress + buttonColorProgress + buttonGeometricShapeProgress

//        UserDefaults.standard.set(73, forKey: "buttonBasicProgress")

        UserDefaults.standard.set(buttonBasicProgress, forKey: "buttonBasicProgress")
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
        lbl.text = "Самое начало".localized()
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
            positY = -410
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -390
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
        lbl.text = "_______".localized()
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
            positY = -405
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -385
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
            positY = -510
            positX = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -493
            positX = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -460
            positX = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -493
            positX = 0
        } else if totalSize.height <= 670 {
            positY = -440
            positX = -20
        } else {
            positY = -442
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
            positY = -510
            positX = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -493
            positX = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -460
            positX = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -493
            positX = 40
        } else if totalSize.height <= 670 {
            positY = -440
            positX = 20
        } else {
            positY = -442
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
            positY = -510
            positX = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -493
            positX = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -460
            positX = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -493
            positX = 80
        } else if totalSize.height <= 670 {
            positY = -440
            positX = 60
        } else {
            positY = -442
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
            positY = -510
            positX = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -493
            positX = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -460
            positX = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -493
            positX = 120
        } else if totalSize.height <= 670 {
            positY = -440
            positX = 100
        } else {
            positY = -442
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
            positY = -510
            positX = 160
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -493
            positX = 160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -460
            positX = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -493
            positX = 160
        } else if totalSize.height <= 670 {
            positY = -440
            positX = 140
        } else {
            positY = -442
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
        if buttonBasicProgress >= 14 {
            starImage1.image = UIImage(named: "starFull1")
        } else {
            starImage1.image = UIImage(named: "star1")
        }
        if buttonBasicProgress >= 28 {
            starImage2.image = UIImage(named: "starFull2")
        } else {
            starImage2.image = UIImage(named: "star2")
        }
        if buttonBasicProgress >= 42 {
            starImage3.image = UIImage(named: "starFull3")
        } else {
            starImage3.image = UIImage(named: "star3")
        }
        if buttonBasicProgress >= 56 {
            starImage4.image = UIImage(named: "starFull1")
        } else {
            starImage4.image = UIImage(named: "star1")
        }
        if buttonBasicProgress >= 70 {
            starImage5.image = UIImage(named: "starFull2")
        } else {
            starImage5.image = UIImage(named: "star2")
        }
    }
//MARK: IYouButton
    lazy var iYouButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var bttm: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            bttm = 600
            lead = 20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 600
            lead = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 600
            lead = 10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 600
            lead = 20
        } else if totalSize.height <= 670 {
            bttm = 600
            lead = 10
        } else {
            bttm = 600
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

        UserDefaults.standard.set("iYou", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.iYou.count, forKey: "numberOfQuestionPerRound")
        
        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
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

        view.layer.addSublayer(shapeLAyerIYou)
        iYouButtonView.layer.addSublayer(shapeLAyerIYou)
        
    }
    //crown
    lazy var crownIYouImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        iYouButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-35)
            make.centerYWithinMargins.equalTo(-120)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowIYouImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowIYouImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        iYouButtonView.addSubview(img)
        
        let wdth: CGFloat!
        let positY: CGFloat!
        let positX: CGFloat!
        if totalSize.height >= 890 {
            wdth = 145
            positY = -20
            positX = 85
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 130
            positY = -27
            positX = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 138
            positY = -20
            positX = 82
        } else if totalSize.height <= 670 {
            wdth = 120
            positY = -20
            positX = 73
        } else {
            wdth = 130
            positY = -20
            positX = 78
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    lazy var arrowIYouImage2: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowIYouImage2"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        iYouButtonView.addSubview(img)
        
        let wdth: CGFloat!
        let positY: CGFloat!
        if totalSize.height >= 830 {
            wdth = 65
            positY = 60
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 62
            positY = 58
        } else if totalSize.height <= 671 {
            wdth = 58
            positY = 52
        } else {
            wdth = 60
            positY = 56
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(10)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var iYouLabel: UILabel = {
        
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
        lbl.text = "Местоимения".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        iYouButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(130)
            make.centerYWithinMargins.equalTo(-120)
        }
        return lbl
    }()
    
//MARK: iYouComplexButton
    lazy var iYouComplexButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var bttm: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            bttm = 550
            trail = 26
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 550
            trail = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 550
            trail = 10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 550
            trail = 20
        } else if totalSize.height <= 670 {
            bttm = 550
            trail = 10
        } else {
            bttm = 550
            trail = 0
        }
        
        vi.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var iYouComplexButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "iYouComplexButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        iYouComplexButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(83)
        }
        
        return btn
    }()
    @objc func iYouComplexButtonAction(sender: UIButton) {
        UserDefaults.standard.set("iYouComplex", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.iYouComplex.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonIYouComplexCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -424
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -408
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -382
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -329
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -294
            positX = -88
        } else {
            positY = -366
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
        iYouComplexButtonView.layer.addSublayer(progressLayer)
        
        shapeLAyerIYouComplex.path = circularPath.cgPath
        shapeLAyerIYouComplex.position = CGPoint(x: positX, y: positY)
        shapeLAyerIYouComplex.fillColor = UIColor.clear.cgColor
        shapeLAyerIYouComplex.lineWidth = 7
        shapeLAyerIYouComplex.lineCap = .round
        shapeLAyerIYouComplex.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerIYouComplex)
        iYouComplexButtonView.layer.addSublayer(shapeLAyerIYouComplex)
    }
    //crown
    lazy var crownIYouComplexImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        iYouComplexButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(35)
            make.centerYWithinMargins.equalTo(-120)
        }
        
        return img
    }()
//MARK: helloButton
    lazy var helloButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var bttm: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            bttm = 350
            lead = 45
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 355
            lead = 45
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 350
            lead = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 355
            lead = 45
        } else if totalSize.height <= 670 {
            bttm = 370
            lead = 35
        } else {
            bttm = 360
            lead = 35
        }
        
        vi.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var helloButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "helloButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        helloButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        
        return btn
    }()
    @objc func helloButtonAction(sender: UIButton) {
        UserDefaults.standard.set("hello", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.hello.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonHelloCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -424
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -408
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -382
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -329
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -294
            positX = -88
        } else {
            positY = -366
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
        helloButtonView.layer.addSublayer(progressLayer)
        
        
        shapeLAyerHello.path = circularPath.cgPath
        shapeLAyerHello.position = CGPoint(x: positX, y: positY)
        shapeLAyerHello.fillColor = UIColor.clear.cgColor
        shapeLAyerHello.lineWidth = 7
        shapeLAyerHello.lineCap = .round
        shapeLAyerHello.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerHello)
        helloButtonView.layer.addSublayer(shapeLAyerHello)
    }
    //crown
    lazy var crownHelloImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.5))
        helloButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(25)
            make.centerYWithinMargins.equalTo(-125)
        }
        
        return img
    }()
    //Arrow
    lazy var arrowHelloImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowHelloImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        helloButtonView.addSubview(img)
        
        let positX: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            positX = 95
            wdth = 160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 87
            wdth = 160
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 87
            wdth = 160
        } else if totalSize.height <= 671 {
            positX = 83
            wdth = 155
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.06))
        } else {
            positX = 80
            wdth = 145
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(-40)
        }
        
        return img
    }()
    
    //Label
    lazy var helloLabel: UILabel = {
        
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
        lbl.text = "Этикет".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        helloButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-70)
            make.centerYWithinMargins.equalTo(-120)
        }
        return lbl
    }()
    
//MARK: QuestionButton
    lazy var questionButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var bttm: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            bttm = 320
            trail = -7
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 320
            trail = -20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 320
            trail = -20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 320
            trail = -10
        } else if totalSize.height <= 670 {
            bttm = 320
            trail = -20
        } else {
            bttm = 320
            trail = -20
        }
        
        vi.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var questionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "questionButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        questionButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        
        return btn
    }()
    @objc func questionButtonAction(sender: UIButton) {
        UserDefaults.standard.set("question", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.question.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonQuestionCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -431
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -415
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -389
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -336
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -297
            positX = -88
        } else {
            positY = -373
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
        questionButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerQuestion.path = circularPath.cgPath
        shapeLAyerQuestion.position = CGPoint(x: positX, y: positY)
        shapeLAyerQuestion.fillColor = UIColor.clear.cgColor
        shapeLAyerQuestion.lineWidth = 7
        shapeLAyerQuestion.lineCap = .round
        shapeLAyerQuestion.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerQuestion)
        questionButtonView.layer.addSublayer(shapeLAyerQuestion)
    }
    //crown
    lazy var crownQuestionImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        questionButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-35)
            make.centerYWithinMargins.equalTo(-125)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowQuestionImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowQuestionImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        questionButtonView.addSubview(img)
        
        let positX: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            positX = -110
            wdth = 210
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = -87
            wdth = 210
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = -102
            wdth = 210
        } else {
            positX = -95
            wdth = 178
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(25)
        }
        
        return img
    }()
    
    //Label
    lazy var questionLabel: UILabel = {
        
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
        lbl.text = "Вопросы".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        questionButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(5)
            make.centerYWithinMargins.equalTo(-160)
        }
        return lbl
    }()
    
//MARK: ColorButton
    lazy var colorButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var bttm: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            bttm = 160
            lead = -10
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 160
            lead = -10
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 160
            lead = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 160
            lead = -10
        } else if totalSize.height <= 670 {
            bttm = 160
            lead = -10
        } else {
            bttm = 160
            lead = -10
        }
        
        vi.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var colorButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "colorButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        colorButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(67)
        }
        
        return btn
    }()
    @objc func colorButtonAction(sender: UIButton) {
        UserDefaults.standard.set("color", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.color.count, forKey: "numberOfQuestionPerRound")

        playPressSound()
        
        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonColorCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -430
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -415
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -389
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -335
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -300
            positX = -88
        } else {
            positY = -373
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
        colorButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerColor.path = circularPath.cgPath
        shapeLAyerColor.position = CGPoint(x: positX, y: positY)
        shapeLAyerColor.fillColor = UIColor.clear.cgColor
        shapeLAyerColor.lineWidth = 7
        shapeLAyerColor.lineCap = .round
        shapeLAyerColor.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerColor)
        colorButtonView.layer.addSublayer(shapeLAyerColor)
    }
    //Label
    lazy var сolorLabel: UILabel = {
        
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
        lbl.text = "Цвета".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        self.view.addSubview(lbl)
        colorButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-5)
            make.centerYWithinMargins.equalTo(-140)
        }
        return lbl
    }()
    //crown
    lazy var crownColorImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.45))
        colorButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(50)
            make.centerYWithinMargins.equalTo(-115)
        }
        
        return img
    }()
    //Arrow
    lazy var arrowColorImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowColorImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        colorButtonView.addSubview(img)
        
        let positX: CGFloat!
        let positY: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            positX = 70
            positY = 30
            wdth = 180
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positX = 60
            positY = 20
            wdth = 170
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 70
            positY = 25
            wdth = 170
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.05))
        } else if totalSize.height <= 671 {
            positX = 45
            positY = 22
            wdth = 155
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.20))
        } else {
            positX = 50
            positY = 25
            wdth = 160
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.15))
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
//MARK: GeometricShape
    lazy var geometricShapeButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var bttm: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            bttm = 10
            trail = 52
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            bttm = 10
            trail = 50
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            bttm = 16
            trail = 35
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            bttm = 10
            trail = 50
        } else if totalSize.height <= 670 {
            bttm = 10
            trail = 50
        } else {
            bttm = 10
            trail = 40
        }
        
        vi.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bttm)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var geometricShapeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "geometricShapeButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        geometricShapeButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(67)
        }
        
        return btn
    }()
    @objc func geometricShapeButtonAction(sender: UIButton) {
        UserDefaults.standard.set("geometricShape", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.geometricShape.count, forKey: "numberOfQuestionPerRound")
        
        playPressSound()

        let vc = NotificationPlayGameViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: true, completion: nil)
    }
    
    func buttonGeometricShapeCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -431
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -415
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -389
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -336
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -299
            positX = -88
        } else {
            positY = -373
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
        geometricShapeButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerGeometricShape.path = circularPath.cgPath
        shapeLAyerGeometricShape.position = CGPoint(x: positX, y: positY)
        shapeLAyerGeometricShape.fillColor = UIColor.clear.cgColor
        shapeLAyerGeometricShape.lineWidth = 7
        shapeLAyerGeometricShape.lineCap = .round
        shapeLAyerGeometricShape.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerGeometricShape)
        geometricShapeButtonView.layer.addSublayer(shapeLAyerGeometricShape)
    }
    //Label
    lazy var geometricShapeLabel: UILabel = {
        
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
        lbl.text = "Геометрические \n\nФигуры".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        geometricShapeButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-160)
        }
        return lbl
    }()
    //crown
    lazy var crownGeometricShapeImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.8))
        geometricShapeButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-40)
            make.centerYWithinMargins.equalTo(-120)
        }
        
        return img
    }()
//MARK: - ColorProgress
    func colorProgress() {
        //iYou
        if buttonIYouProgress >= 7 {
            shapeLAyerIYou.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonIYouProgress >= 5 {
            shapeLAyerIYou.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonIYouProgress >= 3 {
            shapeLAyerIYou.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonIYouProgress >= 2 {
            shapeLAyerIYou.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonIYouProgress >= 0 {
            shapeLAyerIYou.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //iYouComplex
        if buttonIYouComplexProgress >= 8 {
            shapeLAyerIYouComplex.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonIYouComplexProgress >= 6 {
            shapeLAyerIYouComplex.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonIYouComplexProgress >= 4 {
            shapeLAyerIYouComplex.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonIYouComplexProgress >= 2 {
            shapeLAyerIYouComplex.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonIYouComplexProgress >= 0 {
            shapeLAyerIYouComplex.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //hello
        if buttonHelloProgress >= 10 {
            shapeLAyerHello.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonHelloProgress >= 7 {
            shapeLAyerHello.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonHelloProgress >= 5 {
            shapeLAyerHello.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonHelloProgress >= 3 {
            shapeLAyerHello.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonHelloProgress >= 0 {
            shapeLAyerHello.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //question
        if buttonQuestionProgress >= 11 {
            shapeLAyerQuestion.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonQuestionProgress >= 8 {
            shapeLAyerQuestion.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonQuestionProgress >= 5 {
            shapeLAyerQuestion.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonQuestionProgress >= 3 {
            shapeLAyerQuestion.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonQuestionProgress >= 0 {
            shapeLAyerQuestion.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //color
        if buttonColorProgress >= 11 {
            shapeLAyerColor.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonColorProgress >= 8 {
            shapeLAyerColor.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonColorProgress >= 5 {
            shapeLAyerColor.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonColorProgress >= 3 {
            shapeLAyerColor.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonColorProgress >= 0 {
            shapeLAyerColor.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //geometricShape
        if buttonGeometricShapeProgress >= 14 {
            shapeLAyerGeometricShape.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonGeometricShapeProgress >= 10 {
            shapeLAyerGeometricShape.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonGeometricShapeProgress >= 7 {
            shapeLAyerGeometricShape.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonGeometricShapeProgress >= 3 {
            shapeLAyerGeometricShape.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonGeometricShapeProgress >= 0 {
            shapeLAyerGeometricShape.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
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
//        view.backgroundColor = #colorLiteral(red: 0.04012636441, green: 0.2313559893, blue: 0.3368890507, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "blackboardBasicMenu"))
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
    //backpack
    lazy var backpackImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "backpack"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        if totalSize.height >= 890 {
            positY = 510
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 480
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 510
        } else if totalSize.height <= 670 {
            positY = 470
        } else {
            positY = 470
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.centerXWithinMargins.equalTo(-120)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(backgroundView)
//        scrollViewContainer.addArrangedSubview(backgroundImage)
//        scrollViewContainer.addArrangedSubview(greenView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        var positBttm: CGFloat!
        if totalSize.height >= 920 {
            positBttm = -34
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttm = -19
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttm = 10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttm = -52
        } else if totalSize.height <= 670 {
            positBttm = -4
        } else {
            positBttm = 30
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
        if buttonIYouProgress == 8 {
            UserDefaults.standard.set(true, forKey: "crownIYouBool")
        }
        if buttonIYouComplexProgress == 10 {
            UserDefaults.standard.set(true, forKey: "crownIYouComplexBool")
        }
        if buttonHelloProgress == 12 {
            UserDefaults.standard.set(true, forKey: "crownHelloBool")
        }
        if buttonQuestionProgress == 13 {
            UserDefaults.standard.set(true, forKey: "crownQuestionBool")
        }
        if buttonColorProgress == 13 {
            UserDefaults.standard.set(true, forKey: "crownColorBool")
        }
        if buttonGeometricShapeProgress == 16 {
            UserDefaults.standard.set(true, forKey: "crownGeometricShapeBool")
        }
        
        //spawn
        if UserDefaults.standard.bool(forKey: "crownIYouBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownIYou") {
                animationReward()
                playConfirmationSound()
                crownIYouImage.isHidden = false
                crownIYouImage.pulsate()
            } else {
                crownIYouImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownIYou")
            
        }
        if UserDefaults.standard.bool(forKey: "crownIYouComplexBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownIYouComplex") {
                animationReward()
                playConfirmationSound()
                crownIYouComplexImage.isHidden = false
                crownIYouComplexImage.pulsate()
            } else {
                crownIYouComplexImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownIYouComplex")
        }
        if UserDefaults.standard.bool(forKey: "crownHelloBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownHello") {
                animationReward()
                playConfirmationSound()
                crownHelloImage.isHidden = false
                crownHelloImage.pulsate()
            } else {
                crownHelloImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownHello")
        }
        if UserDefaults.standard.bool(forKey: "crownQuestionBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownQuestion") {
                animationReward()
                playConfirmationSound()
                crownQuestionImage.isHidden = false
                crownQuestionImage.pulsate()
            } else {
                crownQuestionImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownQuestion")
        }
        if UserDefaults.standard.bool(forKey: "crownColorBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownColor") {
                animationReward()
                playConfirmationSound()
                crownColorImage.isHidden = false
                crownColorImage.pulsate()
            } else {
                crownColorImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownColor")
        }
        if UserDefaults.standard.bool(forKey: "crownGeometricShapeBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownGeometricShape") {
                animationReward()
                playConfirmationSound()
                crownGeometricShapeImage.isHidden = false
                crownGeometricShapeImage.pulsate()
            } else {
                crownGeometricShapeImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownGeometricShape")
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
            positY = -500
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -483
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -460
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -483
        } else if totalSize.height <= 670 {
            positY = -445
        } else {
            positY = -440
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
