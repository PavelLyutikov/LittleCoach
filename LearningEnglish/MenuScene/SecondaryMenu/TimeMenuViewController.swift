//
//  TimeMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 13.01.2022.
//

import UIKit
import SnapKit
import Lottie
import AVFoundation

class TimeMenuViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    var playerTwo: AVAudioPlayer?
    var playerThree: AVAudioPlayer?
    
    var animationCrownPlay: Bool = false
    
    var buttonTimeProgress = UserDefaults.standard.integer(forKey: "buttonTimeProgress")
    
    var buttonNumberProgress = UserDefaults.standard.integer(forKey: "buttonNumberProgress")
    var buttonNumberComplexProgress = UserDefaults.standard.integer(forKey: "buttonNumberComplexProgress")
    var buttonUnitsOfTimeProgress = UserDefaults.standard.integer(forKey: "buttonUnitsOfTimeProgress")
    var buttonMonthSeasonProgress = UserDefaults.standard.integer(forKey: "buttonMonthSeasonProgress")
    var buttonDayProgress = UserDefaults.standard.integer(forKey: "buttonDayProgress")
    var buttonTimePeriodsProgress = UserDefaults.standard.integer(forKey: "buttonTimePeriodsProgress")
    
    var questionsModel = QuestionModel()
    
    let shapeLAyerNumber = CAShapeLayer()
    let shapeLAyerNumberComplex = CAShapeLayer()
    let shapeLAyerUnitsOfTime = CAShapeLayer()
    let shapeLAyerMonthSeason = CAShapeLayer()
    let shapeLAyerDay = CAShapeLayer()
    let shapeLAyerTimePeriods = CAShapeLayer()
    
    let numberAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let numberComplexAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let unitsOfTimeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let monthSeasonAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let dayAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let timePeriodsAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
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
        alarmClockImage.isHidden = false
        
        //crown
        updateCrown()
        
        //star
        starImage1.isHidden = false
        starImage2.isHidden = false
        starImage3.isHidden = false
        starImage4.isHidden = false
        starImage5.isHidden = false
        
        //arrow
        arrowNumberImage.isHidden = false
        arrowNumberImage2.isHidden = false
        arrowUnitsOfTimeImage.isHidden = false
        arrowMonthSeasonImage.isHidden = false
        arrowDayImage.isHidden = false
        
        mainLabelUnderline.isHidden = false
        mainLabel.isHidden = false
        
        //backgroundLabel
        numberLabel.isHidden = false
        unitsOfTimeLabel.isHidden = false
        monthSeasonLabel.isHidden = false
        dayLabel.isHidden = false
        timePeriodsLabel.isHidden = false
        
        //setupProgress
        colorProgress()
        buttonNumberCircleProgress()
        buttonNumberComplexCircleProgress()
        buttonUnitsOfTimeCircleProgress()
        buttonMonthSeasonCircleProgress()
        buttonDayCircleProgress()
        buttonTimePeriodsCircleProgress()
        playProgress()
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.updateProgress()
            self.scrollWhenOpening()
            self.starUpdate()
        }
        
        //Button
        numberButton.addTarget(self, action: #selector(numberButtonAction(sender:)), for: .touchUpInside)
        numberComplexButton.addTarget(self, action: #selector(numberComplexButtonAction(sender:)), for: .touchUpInside)
        unitsOfTimeButton.addTarget(self, action: #selector(unitsOfTimeButtonAction(sender:)), for: .touchUpInside)
        monthSeasonButton.addTarget(self, action: #selector(monthSeasonButtonAction(sender:)), for: .touchUpInside)
        dayButton.addTarget(self, action: #selector(dayButtonAction(sender:)), for: .touchUpInside)
        timePeriodsButton.addTarget(self, action: #selector(timePeriodsButtonAction(sender:)), for: .touchUpInside)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        
        //ScrollView
        setupScrollView()
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(TimeMenuViewController.refresh), name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimeMenuViewController.lookNewLevel), name: NSNotification.Name(rawValue: "lookNewLevel"), object: nil)
    }
    
//MARK: - Refresh
    @objc func refresh() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.buttonNumberProgress = UserDefaults.standard.integer(forKey: "buttonNumberProgress")
            self.buttonNumberComplexProgress = UserDefaults.standard.integer(forKey: "buttonNumberComplexProgress")
            self.buttonUnitsOfTimeProgress = UserDefaults.standard.integer(forKey: "buttonUnitsOfTimeProgress")
            self.buttonMonthSeasonProgress = UserDefaults.standard.integer(forKey: "buttonMonthSeasonProgress")
            self.buttonDayProgress = UserDefaults.standard.integer(forKey: "buttonDayProgress")
            self.buttonTimePeriodsProgress = UserDefaults.standard.integer(forKey: "buttonTimePeriodsProgress")
            
            self.updateCrown()
            self.colorProgress()
            self.playProgress()
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                self.updateProgress()
            }
            self.starUpdate()
            
            self.buttonTimeProgress = UserDefaults.standard.integer(forKey: "buttonTimeProgress")
            if self.buttonTimeProgress >= 78 {
                if !UserDefaults.standard.bool(forKey: "isFirstOpeningPersonLevel") {
                    UserDefaults.standard.set("personLvl", forKey: "whichLevelUnlocked")
                    
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
                UserDefaults.standard.set(true, forKey: "isFirstOpeningPersonLevel")
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
        //unlockUnitsOfTime/numberComplex
        if buttonNumberProgress >= 8 {
            UserDefaults.standard.set(true, forKey: "isUnitsOfTimeLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isUnitsOfTimeLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockUnitsOfTimeLevel") {
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
                            self.numberComplexButtonView.alpha = 1
                            self.numberComplexButtonView.isUserInteractionEnabled = true
                            self.arrowNumberImage.alpha = 1
                            
                            self.unitsOfTimeButtonView.alpha = 1
                            self.unitsOfTimeButtonView.isUserInteractionEnabled = true
                            self.arrowNumberImage2.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockUnitsOfTimeLevel")
        } else {
            self.numberComplexButtonView.alpha = 0.4
            self.numberComplexButtonView.isUserInteractionEnabled = false
            self.arrowNumberImage.alpha = 0.2
            
            self.unitsOfTimeButtonView.alpha = 0.4
            self.unitsOfTimeButtonView.isUserInteractionEnabled = false
            self.arrowNumberImage2.alpha = 0.2
        }
        
        //unlockMonthSeason
        if buttonUnitsOfTimeProgress >= 12 {
            UserDefaults.standard.set(true, forKey: "isMonthSeasonLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isMonthSeasonLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockMonthSeasonLevel") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 460.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 570.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 510.0), animated: false)
                    }
                })
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.monthSeasonButtonView.alpha = 1
                            self.monthSeasonButtonView.isUserInteractionEnabled = true
                            self.arrowUnitsOfTimeImage.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockMonthSeasonLevel")
        } else {
            self.monthSeasonButtonView.alpha = 0.4
            self.monthSeasonButtonView.isUserInteractionEnabled = false
            self.arrowUnitsOfTimeImage.alpha = 0.2
        }
        
        //unlockDay
        if buttonMonthSeasonProgress >= 12 {
            UserDefaults.standard.set(true, forKey: "isDayLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isDayLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockDayLevel") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 600.0), animated: false)
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
                            self.dayButtonView.alpha = 1
                            self.dayButtonView.isUserInteractionEnabled = true
                            self.arrowMonthSeasonImage.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockDayLevel")
        } else {
            self.dayButtonView.alpha = 0.4
            self.dayButtonView.isUserInteractionEnabled = false
            self.arrowMonthSeasonImage.alpha = 0.2
        }
        
        //unlockTimePeriods
        if buttonDayProgress >= 14 {
            UserDefaults.standard.set(true, forKey: "isTimePeriodsLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isTimePeriodsLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockTimePeriodsLevel") {
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
                            self.timePeriodsButtonView.alpha = 1
                            self.timePeriodsButtonView.isUserInteractionEnabled = true
                            self.arrowDayImage.alpha = 1
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockTimePeriodsLevel")
        } else {
            self.timePeriodsButtonView.alpha = 0.4
            self.timePeriodsButtonView.isUserInteractionEnabled = false
            self.arrowDayImage.alpha = 0.2
        }
    }
//MARK: - scrollWhenOpening
    func scrollWhenOpening() {
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
        
        //unitsOfTime
        if UserDefaults.standard.bool(forKey: "isUnitsOfTimeLevelUnlock") {
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
        }
        
        //unlockMonthSeason
        if UserDefaults.standard.bool(forKey: "isMonthSeasonLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 430.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 460.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 570.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 510.0), animated: false)
                }
            })
        }
        
        //unlockDay
        if UserDefaults.standard.bool(forKey: "isDayLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 600.0), animated: false)
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
        
        //timePeriods
        if UserDefaults.standard.bool(forKey: "isTimePeriodsLevelUnlock") {
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
        
        //number
        numberAnimation.fromValue = numberAnimation.toValue
        numberAnimation.isRemovedOnCompletion = false
        numberAnimation.duration = 0.5
        numberAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonNumberProgress) > 11 || CGFloat(buttonNumberProgress) < 0 {
                return
            }
        numberAnimation.toValue = CGFloat(buttonNumberProgress)/11
        shapeLAyerNumber.add(numberAnimation, forKey: "urSoBasic")
        
        //numberComplex
        numberComplexAnimation.fromValue = numberComplexAnimation.toValue
        numberComplexAnimation.isRemovedOnCompletion = false
        numberComplexAnimation.duration = 0.5
        numberComplexAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonNumberComplexProgress) > 22 || CGFloat(buttonNumberComplexProgress) < 0 {
                return
            }
        numberComplexAnimation.toValue = CGFloat(buttonNumberComplexProgress)/22
        shapeLAyerNumberComplex.add(numberComplexAnimation, forKey: "urSoBasic")
        
        //unitsOfTime
        unitsOfTimeAnimation.fromValue = unitsOfTimeAnimation.toValue
        unitsOfTimeAnimation.isRemovedOnCompletion = false
        unitsOfTimeAnimation.duration = 0.5
        unitsOfTimeAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonUnitsOfTimeProgress) > 16 || CGFloat(buttonUnitsOfTimeProgress) < 0 {
                return
            }
        unitsOfTimeAnimation.toValue = CGFloat(buttonUnitsOfTimeProgress)/16
        shapeLAyerUnitsOfTime.add(unitsOfTimeAnimation, forKey: "urSoBasic")
        
        //monthSeason
        monthSeasonAnimation.fromValue = monthSeasonAnimation.toValue
        monthSeasonAnimation.isRemovedOnCompletion = false
        monthSeasonAnimation.duration = 0.5
        monthSeasonAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonMonthSeasonProgress) > 16 || CGFloat(buttonMonthSeasonProgress) < 0 {
                return
            }
        monthSeasonAnimation.toValue = CGFloat(buttonMonthSeasonProgress)/16
        shapeLAyerMonthSeason.add(monthSeasonAnimation, forKey: "urSoBasic")
        
        //day
        dayAnimation.fromValue = dayAnimation.toValue
        dayAnimation.isRemovedOnCompletion = false
        dayAnimation.duration = 0.5
        dayAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonDayProgress) > 19 || CGFloat(buttonDayProgress) < 0 {
                return
            }
        dayAnimation.toValue = CGFloat(buttonDayProgress)/19
        shapeLAyerDay.add(dayAnimation, forKey: "urSoBasic")
        
        //timePeriods
        timePeriodsAnimation.fromValue = timePeriodsAnimation.toValue
        timePeriodsAnimation.isRemovedOnCompletion = false
        timePeriodsAnimation.duration = 0.5
        timePeriodsAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonTimePeriodsProgress) > 20 || CGFloat(buttonTimePeriodsProgress) < 0 {
                return
            }
        timePeriodsAnimation.toValue = CGFloat(buttonTimePeriodsProgress)/20
        shapeLAyerTimePeriods.add(timePeriodsAnimation, forKey: "urSoBasic")
        
//        UserDefaults.standard.set(11, forKey: "buttonNumberProgress")
//        UserDefaults.standard.set(16, forKey: "buttonUnitsOfTimeProgress")
//        UserDefaults.standard.set(16, forKey: "buttonMonthSeasonProgress")
//        UserDefaults.standard.set(19, forKey: "buttonDayProgress")
//        UserDefaults.standard.set(20, forKey: "buttonTimePeriodsProgress")
        
        //saveProgress
        buttonTimeProgress = buttonNumberProgress + buttonNumberComplexProgress + buttonUnitsOfTimeProgress + buttonMonthSeasonProgress + buttonDayProgress + buttonTimePeriodsProgress
        
//        UserDefaults.standard.set(104, forKey: "buttonTimeProgress")
        
        UserDefaults.standard.set(buttonTimeProgress, forKey: "buttonTimeProgress")
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
        lbl.text = "Время и числа".localized()
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
        lbl.text = "_______"
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
        if buttonTimeProgress >= 21 {
            starImage1.image = UIImage(named: "starFull1")
        } else {
            starImage1.image = UIImage(named: "star1")
        }
        if buttonTimeProgress >= 41 {
            starImage2.image = UIImage(named: "starFull2")
        } else {
            starImage2.image = UIImage(named: "star2")
        }
        if buttonTimeProgress >= 62 {
            starImage3.image = UIImage(named: "starFull3")
        } else {
            starImage3.image = UIImage(named: "star3")
        }
        if buttonTimeProgress >= 83 {
            starImage4.image = UIImage(named: "starFull1")
        } else {
            starImage4.image = UIImage(named: "star1")
        }
        if buttonTimeProgress >= 100 {
            starImage5.image = UIImage(named: "starFull2")
        } else {
            starImage5.image = UIImage(named: "star2")
        }
    }
//MARK: - NumberButton
    lazy var numberButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = -140
            trail = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -140
            trail = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -140
            trail = 80
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -140
            trail = 80
        } else if totalSize.height <= 670 {
            positY = -140
            trail = 80
        } else {
            positY = -140
            trail = 80
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var numberButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "numberButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        numberButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(76)
        }
        
        return btn
    }()
    @objc func numberButtonAction(sender: UIButton) {
        UserDefaults.standard.set("number", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.number.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonNumberCircleProgress() {
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
        numberButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerNumber.path = circularPath.cgPath
        shapeLAyerNumber.position = CGPoint(x: positX, y: positY)
        shapeLAyerNumber.fillColor = UIColor.clear.cgColor
        shapeLAyerNumber.lineWidth = 7
        shapeLAyerNumber.lineCap = .round
        shapeLAyerNumber.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerNumber)
        numberButtonView.layer.addSublayer(shapeLAyerNumber)
        
    }
    //crown
    lazy var crownNumberImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.6))
        numberButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(35)
            make.centerYWithinMargins.equalTo(-120)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowNumberImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowNumberImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        numberButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 145
            positX = -75
            positY = 10
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
            wdth = 125
            positX = -60
            positY = 5
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 145
            positX = -71
            positY = 10
        } else {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.25))
            wdth = 120
            positX = -58
            positY = 5
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    lazy var arrowNumberImage2: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowNumberImage2"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        numberButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 890 {
            wdth = 140
            positY = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 130
            positY = 77
        } else {
            wdth = 120
            positY = 71
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(47)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var numberLabel: UILabel = {
        
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
        lbl.text = "Числа".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        self.view.addSubview(lbl)
        numberButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-70)
            make.centerYWithinMargins.equalTo(-140)
        }
        return lbl
    }()
//MARK: - NumberComplexButton
    lazy var numberComplexButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = -50
            lead = 7
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -50
            lead = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -50
            lead = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -50
            lead = 0
        } else if totalSize.height <= 670 {
            positY = -40
            lead = -10
        } else {
            positY = -50
            lead = -10
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var numberComplexButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "numberComplexButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        numberComplexButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(76)
        }
        
        return btn
    }()
    @objc func numberComplexButtonAction(sender: UIButton) {
        UserDefaults.standard.set("numberComplex", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.numberComplex.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonNumberComplexCircleProgress() {
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
        numberComplexButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerNumberComplex.path = circularPath.cgPath
        shapeLAyerNumberComplex.position = CGPoint(x: positX, y: positY)
        shapeLAyerNumberComplex.fillColor = UIColor.clear.cgColor
        shapeLAyerNumberComplex.lineWidth = 7
        shapeLAyerNumberComplex.lineCap = .round
        shapeLAyerNumberComplex.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerNumberComplex)
        numberComplexButtonView.layer.addSublayer(shapeLAyerNumberComplex)
        
    }
    //crown
    lazy var crownNumberComplexImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.4))
        numberComplexButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-15)
            make.centerYWithinMargins.equalTo(-128)
        }
        
        return img
    }()
//MARK: - UnitsOfTimeButton
    lazy var unitsOfTimeButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 110
            trail = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 110
            trail = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 100
            trail = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 90
            trail = 0
        } else if totalSize.height <= 670 {
            positY = 90
            trail = 0
        } else {
            positY = 87
            trail = 0
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var unitsOfTimeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "unitsOfTimeButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        unitsOfTimeButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(65)
        }
        
        return btn
    }()
    @objc func unitsOfTimeButtonAction(sender: UIButton) {
        UserDefaults.standard.set("unitsOfTime", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.unitsOfTime.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonUnitsOfTimeCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -430
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -417
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -391
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -336
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -303
            positX = -88
        } else {
            positY = -375
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
        unitsOfTimeButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerUnitsOfTime.path = circularPath.cgPath
        shapeLAyerUnitsOfTime.position = CGPoint(x: positX, y: positY)
        shapeLAyerUnitsOfTime.fillColor = UIColor.clear.cgColor
        shapeLAyerUnitsOfTime.lineWidth = 7
        shapeLAyerUnitsOfTime.lineCap = .round
        shapeLAyerUnitsOfTime.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerUnitsOfTime)
        unitsOfTimeButtonView.layer.addSublayer(shapeLAyerUnitsOfTime)
        
    }
    //crown
    lazy var crownUnitsOfTimeImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.5))
        unitsOfTimeButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(50)
            make.centerYWithinMargins.equalTo(-115)
        }
        
        return img
    }()
    //Label
    lazy var unitsOfTimeLabel: UILabel = {
        
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
        lbl.text = "Единицы \n \nвремени".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        self.view.addSubview(lbl)
        unitsOfTimeButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(10)
            make.centerYWithinMargins.equalTo(-170)
        }
        return lbl
    }()
    //Arrow
    lazy var arrowUnitsOfTimeImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowUnitsOfTimeImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        unitsOfTimeButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            wdth = 200
            positY = 0
            positX = -80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 200
            positY = 0
            positX = -80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 180
            positY = 4
            positX = -78
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 200
            positY = 0
            positX = -80
        } else {
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
            wdth = 180
            positY = 5
            positX = -70
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
//MARK: - MonthSeason
    lazy var monthSeasonButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 205
            lead = 20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 205
            lead = 10
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 205
            lead = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 198
            lead = 7
        } else if totalSize.height <= 670 {
            positY = 210
            lead = 0
        } else {
            positY = 215
            lead = 0
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var monthSeasonButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "monthSeasonButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        monthSeasonButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        return btn
    }()
    @objc func monthSeasonButtonAction(sender: UIButton) {
        UserDefaults.standard.set("monthSeason", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.monthSeason.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonMonthSeasonCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -437
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -421
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -395
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -340
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -307
            positX = -88
        } else {
            positY = -379
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
        monthSeasonButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerMonthSeason.path = circularPath.cgPath
        shapeLAyerMonthSeason.position = CGPoint(x: positX, y: positY)
        shapeLAyerMonthSeason.fillColor = UIColor.clear.cgColor
        shapeLAyerMonthSeason.lineWidth = 7
        shapeLAyerMonthSeason.lineCap = .round
        shapeLAyerMonthSeason.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerMonthSeason)
        monthSeasonButtonView.layer.addSublayer(shapeLAyerMonthSeason)
        
    }
    //crown
    lazy var crownMonthSeasonImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.9))
        monthSeasonButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(45)
            make.centerYWithinMargins.equalTo(-120)
        }
        
        return img
    }()
    lazy var arrowMonthSeasonImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowMonthSeasonImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        monthSeasonButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 210
            positY = 50
            positX = 50
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 210
            positY = 50
            positX = 50
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 190
            positY = 40
            positX = 50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 210
            positY = 50
            positX = 50
        } else {
            wdth = 180
            positY = 35
            positX = 50
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var monthSeasonLabel: UILabel = {
        
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
        lbl.text = "Месяцы \n \nи сезоны".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        self.view.addSubview(lbl)
        monthSeasonButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-15)
            make.centerYWithinMargins.equalTo(-170)
        }
        return lbl
    }()
//MARK: - Day
    lazy var dayButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 430
            trail = 25
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 430
            trail = 25
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 420
            trail = 25
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 425
            trail = 25
        } else if totalSize.height <= 670 {
            positY = 418
            trail = 20
        } else {
            positY = 425
            trail = 25
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var dayButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dayButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        dayButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        return btn
    }()
    @objc func dayButtonAction(sender: UIButton) {
        UserDefaults.standard.set("day", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.day.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonDayCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -429
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
        dayButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerDay.path = circularPath.cgPath
        shapeLAyerDay.position = CGPoint(x: positX, y: positY)
        shapeLAyerDay.fillColor = UIColor.clear.cgColor
        shapeLAyerDay.lineWidth = 7
        shapeLAyerDay.lineCap = .round
        shapeLAyerDay.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerDay)
        dayButtonView.layer.addSublayer(shapeLAyerDay)
        
    }
    //crown
    lazy var crownDayImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.4))
        dayButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-15)
            make.centerYWithinMargins.equalTo(-135)
        }
        
        return img
    }()
    //Arrow
    lazy var arrowDayImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowDayImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        dayButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            wdth = 150
            positX = -60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 160
            positX = -60
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 140
            positX = -50
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 160
            positX = -60
        } else {
            wdth = 120
            positX = -50
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(10)
        }
        
        return img
    }()
    //Label
    lazy var dayLabel: UILabel = {
        
        let size: CGFloat!
        if totalSize.height >= 890 && totalSize.height <= 919 {
            size = 17
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            size = 16
        } else {
            size = 15
        }
        
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
        lbl.text = "День".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        dayButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-170)
        }
        return lbl
    }()
//MARK: - TimePeriods
    lazy var timePeriodsButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 550
            lead = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 550
            lead = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 550
            lead = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 550
            lead = 20
        } else if totalSize.height <= 670 {
            positY = 545
            lead = 17
        } else {
            positY = 550
            lead = 15
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var timePeriodsButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "timePeriodsButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        timePeriodsButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }
        
        return btn
    }()
    @objc func timePeriodsButtonAction(sender: UIButton) {
        UserDefaults.standard.set("timePeriods", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.timePeriods.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonTimePeriodsCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -429
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
        timePeriodsButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerTimePeriods.path = circularPath.cgPath
        shapeLAyerTimePeriods.position = CGPoint(x: positX, y: positY)
        shapeLAyerTimePeriods.fillColor = UIColor.clear.cgColor
        shapeLAyerTimePeriods.lineWidth = 7
        shapeLAyerTimePeriods.lineCap = .round
        shapeLAyerTimePeriods.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerTimePeriods)
        timePeriodsButtonView.layer.addSublayer(shapeLAyerTimePeriods)
        
    }
    //crown
    lazy var crownTimePeriodsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        timePeriodsButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-15)
            make.centerYWithinMargins.equalTo(-135)
        }
        
        return img
    }()
    
    //Label
    lazy var timePeriodsLabel: UILabel = {
        
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
        lbl.text = "Интервалы времени".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        timePeriodsButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(40)
            make.centerYWithinMargins.equalTo(15)
        }
        return lbl
    }()
//MARK: - ColorProgress
    func colorProgress() {
        //Number
        if buttonNumberProgress >= 9 {
            shapeLAyerNumber.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonNumberProgress >= 7 {
            shapeLAyerNumber.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonNumberProgress >= 5 {
            shapeLAyerNumber.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonNumberProgress >= 3 {
            shapeLAyerNumber.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonNumberProgress >= 0 {
            shapeLAyerNumber.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //NumberComplex
        if buttonNumberComplexProgress >= 18 {
            shapeLAyerNumberComplex.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonNumberComplexProgress >= 14 {
            shapeLAyerNumberComplex.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonNumberComplexProgress >= 9 {
            shapeLAyerNumberComplex.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonNumberComplexProgress >= 4 {
            shapeLAyerNumberComplex.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonNumberComplexProgress >= 0 {
            shapeLAyerNumberComplex.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //UnitsOfTime
        if buttonUnitsOfTimeProgress >= 14 {
            shapeLAyerUnitsOfTime.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonUnitsOfTimeProgress >= 11 {
            shapeLAyerUnitsOfTime.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonUnitsOfTimeProgress >= 7 {
            shapeLAyerUnitsOfTime.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonUnitsOfTimeProgress >= 3 {
            shapeLAyerUnitsOfTime.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonUnitsOfTimeProgress >= 0 {
            shapeLAyerUnitsOfTime.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //MonthSeason
        if buttonMonthSeasonProgress >= 14 {
            shapeLAyerMonthSeason.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonMonthSeasonProgress >= 11 {
            shapeLAyerMonthSeason.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonMonthSeasonProgress >= 7 {
            shapeLAyerMonthSeason.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonMonthSeasonProgress >= 3 {
            shapeLAyerMonthSeason.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonMonthSeasonProgress >= 0 {
            shapeLAyerMonthSeason.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //Day
        if buttonDayProgress >= 17 {
            shapeLAyerDay.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonDayProgress >= 12 {
            shapeLAyerDay.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonDayProgress >= 8 {
            shapeLAyerDay.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonDayProgress >= 4 {
            shapeLAyerDay.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonDayProgress >= 0 {
            shapeLAyerDay.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //TimePeriods
        if buttonTimePeriodsProgress >= 17 {
            shapeLAyerTimePeriods.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonTimePeriodsProgress >= 12 {
            shapeLAyerTimePeriods.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonTimePeriodsProgress >= 8 {
            shapeLAyerTimePeriods.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonTimePeriodsProgress >= 4 {
            shapeLAyerTimePeriods.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonTimePeriodsProgress >= 0 {
            shapeLAyerTimePeriods.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
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
    //alarmClock
    lazy var alarmClockImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "alarmClock"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.3))
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 920 {
            positY = 690
            wdth = 130
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 670
            wdth = 130
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 660
            wdth = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 670
            wdth = 130
        } else if totalSize.height <= 670 {
            positY = 640
            wdth = 100
        } else {
            positY = 640
            wdth = 90
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
//        scrollViewContainer.addArrangedSubview(backgroundImage)
//        scrollViewContainer.addArrangedSubview(greenView)

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
        //number
        if buttonNumberProgress == 11 {
            UserDefaults.standard.set(true, forKey: "crownNumberBool")
        }
        //numberComplex
        if buttonNumberComplexProgress == 22 {
            UserDefaults.standard.set(true, forKey: "crownNumberComplexBool")
        }
        //unitsOfTime
        if buttonUnitsOfTimeProgress == 16 {
            UserDefaults.standard.set(true, forKey: "crownUnitsOfTimeBool")
        }
        //monthSeason
        if buttonMonthSeasonProgress == 16 {
            UserDefaults.standard.set(true, forKey: "crownMonthSeasonBool")
        }
        //day
        if buttonDayProgress == 19 {
            UserDefaults.standard.set(true, forKey: "crownDayBool")
        }
        //timePeriods
        if buttonTimePeriodsProgress == 20 {
            UserDefaults.standard.set(true, forKey: "crownTimePeriodsBool")
        }
        
        
        
        //spawn
        //number
        if UserDefaults.standard.bool(forKey: "crownNumberBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownNumber") {
                animationReward()
                playConfirmationSound()
                crownNumberImage.isHidden = false
                crownNumberImage.pulsate()
            } else {
                crownNumberImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownNumber")
        }
        //numberComplex
        if UserDefaults.standard.bool(forKey: "crownNumberComplexBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownNumberComplex") {
                animationReward()
                playConfirmationSound()
                crownNumberComplexImage.isHidden = false
                crownNumberComplexImage.pulsate()
            } else {
                crownNumberComplexImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownNumberComplex")
        }
        //UnitsOfTime
        if UserDefaults.standard.bool(forKey: "crownUnitsOfTimeBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownUnitsOfTime") {
                animationReward()
                playConfirmationSound()
                crownUnitsOfTimeImage.isHidden = false
                crownUnitsOfTimeImage.pulsate()
            } else {
                crownUnitsOfTimeImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownUnitsOfTime")
        }
        //MonthSeason
        if UserDefaults.standard.bool(forKey: "crownMonthSeasonBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownMonthSeason") {
                animationReward()
                playConfirmationSound()
                crownMonthSeasonImage.isHidden = false
                crownMonthSeasonImage.pulsate()
            } else {
                crownMonthSeasonImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownMonthSeason")
        }
        //Day
        if UserDefaults.standard.bool(forKey: "crownDayBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownDay") {
                animationReward()
                playConfirmationSound()
                crownDayImage.isHidden = false
                crownDayImage.pulsate()
            } else {
                crownDayImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownDay")
        }
        //TimePeriods
        if UserDefaults.standard.bool(forKey: "crownTimePeriodsBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnTimePeriods") {
                animationReward()
                playConfirmationSound()
                crownTimePeriodsImage.isHidden = false
                crownTimePeriodsImage.pulsate()
            } else {
                crownTimePeriodsImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnTimePeriods")
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
