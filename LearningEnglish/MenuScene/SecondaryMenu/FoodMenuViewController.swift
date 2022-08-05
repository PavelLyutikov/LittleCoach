//
//  FoodMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 26.03.2022.
// 295 words

import UIKit
import SnapKit
import Lottie
import AVFoundation

class FoodMenuViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    var playerTwo: AVAudioPlayer?
    var playerThree: AVAudioPlayer?
    
    var buttonFoodProgress = UserDefaults.standard.integer(forKey: "buttonFoodProgress")
    
    var buttonAboutFoodProgress = UserDefaults.standard.integer(forKey: "buttonAboutFoodProgress")
    var buttonDrinkProgress = UserDefaults.standard.integer(forKey: "buttonDrinkProgress")
    var buttonDrinkReverseProgress = UserDefaults.standard.integer(forKey: "buttonDrinkReverseProgress")
    var buttonMilkProgress = UserDefaults.standard.integer(forKey: "buttonMilkProgress")
    var buttonMilkReverseProgress = UserDefaults.standard.integer(forKey: "buttonMilkReverseProgress")
    var buttonVegetableProgress = UserDefaults.standard.integer(forKey: "buttonVegetableProgress")
    var buttonFruitProgress = UserDefaults.standard.integer(forKey: "buttonFruitProgress")
    var buttonNutProgress = UserDefaults.standard.integer(forKey: "buttonNutProgress")
    var buttonMeatProgress = UserDefaults.standard.integer(forKey: "buttonMeatProgress")
    var buttonProductsProgress = UserDefaults.standard.integer(forKey: "buttonProductsProgress")
    var buttonProductsReverseProgress = UserDefaults.standard.integer(forKey: "buttonProductsReverseProgress")
    var buttonSweetsProgress = UserDefaults.standard.integer(forKey: "buttonSweetsProgress")
    var buttonCookedFoodProgress = UserDefaults.standard.integer(forKey: "buttonCookedFoodProgress")
    
    var questionsModel = QuestionModel()
    
    let shapeLAyerAboutFood = CAShapeLayer()
    let shapeLAyerDrink = CAShapeLayer()
    let shapeLAyerDrinkReverse = CAShapeLayer()
    let shapeLAyerMilk = CAShapeLayer()
    let shapeLAyerMilkReverse = CAShapeLayer()
    let shapeLAyerVegetable = CAShapeLayer()
    let shapeLAyerFruit = CAShapeLayer()
    let shapeLAyerNut = CAShapeLayer()
    let shapeLAyerMeat = CAShapeLayer()
    let shapeLAyerProducts = CAShapeLayer()
    let shapeLAyerProductsReverse = CAShapeLayer()
    let shapeLAyerSweets = CAShapeLayer()
    let shapeLAyerCookedFood = CAShapeLayer()
    
    let aboutFoodAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let drinkAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let drinkReverseAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let milkAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let milkReverseAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let vegetableAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let fruitAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let nutAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let meatAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let productsAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let productsReverseAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let sweetsAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let cookedFoodAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
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
        chalkBurgerImage.isHidden = false
        
        //crown
        updateCrown()
        
        //star
        starImage1.isHidden = false
        starImage2.isHidden = false
        starImage3.isHidden = false
        starImage4.isHidden = false
        starImage5.isHidden = false
        
        //arrow
        arrowAboutFoodImage.isHidden = false
        arrowDrinkImage.isHidden = false
        arrowMilkImage.isHidden = false
        arrowVegetableImage.isHidden = false
        arrowFruitImage.isHidden = false
        arrowMeatImage.isHidden = false
        arrowProductsImage.isHidden = false
        arrowSweetsImage.isHidden = false
        
        mainLabelUnderline.isHidden = false
        mainLabel.isHidden = false
        
        //backgroundLabel
        aboutFoodLabel.isHidden = false
        drinkLabel.isHidden = false
        milkLabel.isHidden = false
        vegetableLabel.isHidden = false
        fruitLabel.isHidden = false
        nutLabel.isHidden = false
        meatLabel.isHidden = false
        productsLabel.isHidden = false
        sweetsLabel.isHidden = false
        cookedFoodLabel.isHidden = false
        
        //setupProgress
        colorProgress()
        
        buttonAboutFoodCircleProgress()
        buttonDrinkCircleProgress()
        buttonDrinkReverseCircleProgress()
        buttonMilkCircleProgress()
        buttonMilkReverseCircleProgress()
        buttonVegetableCircleProgress()
        buttonFruitCircleProgress()
        buttonNutCircleProgress()
        buttonMeatCircleProgress()
        buttonProductsCircleProgress()
        buttonProductsReverseCircleProgress()
        buttonSweetsCircleProgress()
        buttonCookedFoodCircleProgress()
        
        playProgress()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            self.updateProgress()
            self.scrollWhenOpening()
            self.starUpdate()
        }
        
        //Button
        aboutFoodButton.addTarget(self, action: #selector(aboutFoodButtonAction(sender:)), for: .touchUpInside)
        drinkButton.addTarget(self, action: #selector(drinkButtonAction(sender:)), for: .touchUpInside)
        drinkReverseButton.addTarget(self, action: #selector(drinkReverseButtonAction(sender:)), for: .touchUpInside)
        milkButton.addTarget(self, action: #selector(milkButtonAction(sender:)), for: .touchUpInside)
        milkReverseButton.addTarget(self, action: #selector(milkReverseButtonAction(sender:)), for: .touchUpInside)
        vegetableButton.addTarget(self, action: #selector(vegetableButtonAction(sender:)), for: .touchUpInside)
        fruitButton.addTarget(self, action: #selector(fruitButtonAction(sender:)), for: .touchUpInside)
        nutButton.addTarget(self, action: #selector(nutButtonAction(sender:)), for: .touchUpInside)
        meatButton.addTarget(self, action: #selector(meatButtonAction(sender:)), for: .touchUpInside)
        productsButton.addTarget(self, action: #selector(productsButtonAction(sender:)), for: .touchUpInside)
        productsReverseButton.addTarget(self, action: #selector(productsReverseButtonAction(sender:)), for: .touchUpInside)
        sweetsButton.addTarget(self, action: #selector(sweetsButtonAction(sender:)), for: .touchUpInside)
        cookedFoodButton.addTarget(self, action: #selector(cookedFoodButtonAction(sender:)), for: .touchUpInside)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        
        //ScrollView
        setupScrollView()
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(FoodMenuViewController.refresh), name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
    }
    
    @objc func refresh() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.buttonAboutFoodProgress = UserDefaults.standard.integer(forKey: "buttonAboutFoodProgress")
            self.buttonDrinkProgress = UserDefaults.standard.integer(forKey: "buttonDrinkProgress")
            self.buttonDrinkReverseProgress = UserDefaults.standard.integer(forKey: "buttonDrinkReverseProgress")
            self.buttonMilkProgress = UserDefaults.standard.integer(forKey: "buttonMilkProgress")
            self.buttonMilkReverseProgress = UserDefaults.standard.integer(forKey: "buttonMilkReverseProgress")
            self.buttonVegetableProgress = UserDefaults.standard.integer(forKey: "buttonVegetableProgress")
            self.buttonFruitProgress = UserDefaults.standard.integer(forKey: "buttonFruitProgress")
            self.buttonNutProgress = UserDefaults.standard.integer(forKey: "buttonNutProgress")
            self.buttonMeatProgress = UserDefaults.standard.integer(forKey: "buttonMeatProgress")
            self.buttonProductsProgress = UserDefaults.standard.integer(forKey: "buttonProductsProgress")
            self.buttonProductsReverseProgress = UserDefaults.standard.integer(forKey: "buttonProductsReverseProgress")
            self.buttonSweetsProgress = UserDefaults.standard.integer(forKey: "buttonSweetsProgress")
            self.buttonCookedFoodProgress = UserDefaults.standard.integer(forKey: "buttonCookedFoodProgress")
            
            self.updateCrown()
            self.colorProgress()
            self.playProgress()
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                self.updateProgress()
            }
            self.starUpdate()
        }
    }
//MARK: - UpdateProgress
    func updateProgress() {
        //unlockDrink
        if buttonAboutFoodProgress >= 15 {
            UserDefaults.standard.set(true, forKey: "isDrinkLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isDrinkLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockDrinkLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 420.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 450.0), animated: false)
                    }
                })
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowAboutFoodImage.alpha = 1
                            self.drinkButtonView.alpha = 1
                            self.drinkButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockDrinkLevelUnlock")
        } else {
            self.arrowAboutFoodImage.alpha = 0.2
            self.drinkButtonView.alpha = 0.4
            self.drinkButtonView.isUserInteractionEnabled = false
        }

        //unlockMilk
        if buttonDrinkProgress >= 13 {
            UserDefaults.standard.set(true, forKey: "isMilkLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isMilkLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockMilkLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 650.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 650.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 690.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 780.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 750.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 710.0), animated: false)
                    }
                })
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowDrinkImage.alpha = 1
                            self.milkButtonView.alpha = 1
                            self.milkButtonView.isUserInteractionEnabled = true
                        
                            self.drinkReverseButtonView.alpha = 1
                            self.drinkReverseButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockMilkLevelUnlock")
        } else {
            self.arrowDrinkImage.alpha = 0.2
            self.milkButtonView.alpha = 0.4
            self.milkButtonView.isUserInteractionEnabled = false
            
            self.drinkReverseButtonView.alpha = 0.4
            self.drinkReverseButtonView.isUserInteractionEnabled = false
        }

        //unlockVegetable
        if buttonMilkProgress >= 10 {
            UserDefaults.standard.set(true, forKey: "isVegetableLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isVegetableLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockVegetableLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 950.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 950.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 980.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1080.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1060.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 990.0), animated: false)
                    }
                })

                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowMilkImage.alpha = 1
                            self.vegetableButtonView.alpha = 1
                            self.vegetableButtonView.isUserInteractionEnabled = true
                        
                            self.milkReverseButtonView.alpha = 1
                            self.milkReverseButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockVegetableLevelUnlock")
        } else {
            self.arrowMilkImage.alpha = 0.2
            self.vegetableButtonView.alpha = 0.4
            self.vegetableButtonView.isUserInteractionEnabled = false
            
            self.milkReverseButtonView.alpha = 0.4
            self.milkReverseButtonView.isUserInteractionEnabled = false
        }
        
        //unlockFruit
        if buttonVegetableProgress >= 14 {
            UserDefaults.standard.set(true, forKey: "isFruitLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isFruitLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockFruitLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1150.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1150.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1160.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1250.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1270.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1170.0), animated: false)
                    }
                })

                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowVegetableImage.alpha = 1
                            self.fruitButtonView.alpha = 1
                            self.fruitButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockFruitLevelUnlock")
        } else {
            self.arrowVegetableImage.alpha = 0.2
            self.fruitButtonView.alpha = 0.4
            self.fruitButtonView.isUserInteractionEnabled = false
        }
        
        //unlockMeat
        if buttonFruitProgress >= 23 {
            UserDefaults.standard.set(true, forKey: "isMeatLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isMeatLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockMeatLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1530.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1530.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1550.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1600.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1610.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1560.0), animated: false)
                    }
                })

                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowFruitImage.alpha = 1
                            self.meatButtonView.alpha = 1
                            self.meatButtonView.isUserInteractionEnabled = true
                        
                            self.nutButtonView.alpha = 1
                            self.nutButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockMeatLevelUnlock")
        } else {
            self.arrowFruitImage.alpha = 0.2
            self.meatButtonView.alpha = 0.4
            self.meatButtonView.isUserInteractionEnabled = false
            
            self.nutButtonView.alpha = 0.4
            self.nutButtonView.isUserInteractionEnabled = false
        }
        
        //unlockProducts
        if buttonMeatProgress >= 12 {
            UserDefaults.standard.set(true, forKey: "isProductsLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isProductsLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockProductsLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1700.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1700.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1720.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1810.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1800.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1720.0), animated: false)
                    }
                })

                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowMeatImage.alpha = 1
                            self.productsButtonView.alpha = 1
                            self.productsButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockProductsLevelUnlock")
        } else {
            self.arrowMeatImage.alpha = 0.2
            self.productsButtonView.alpha = 0.4
            self.productsButtonView.isUserInteractionEnabled = false
        }
        
        //unlockSweets
        if buttonProductsProgress >= 13 {
            UserDefaults.standard.set(true, forKey: "isSweetsLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isSweetsLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockSweetsLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1900.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1900.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1920.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2060.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2070.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1920.0), animated: false)
                    }
                })

                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowProductsImage.alpha = 1
                            self.sweetsButtonView.alpha = 1
                            self.sweetsButtonView.isUserInteractionEnabled = true
                        
                            self.productsReverseButtonView.alpha = 1
                            self.productsReverseButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockSweetsLevelUnlock")
        } else {
            self.arrowProductsImage.alpha = 0.2
            self.sweetsButtonView.alpha = 0.4
            self.sweetsButtonView.isUserInteractionEnabled = false
            
            self.productsReverseButtonView.alpha = 0.4
            self.productsReverseButtonView.isUserInteractionEnabled = false
        }
        
        //unlockCookedFood
        if buttonSweetsProgress >= 11 {
            UserDefaults.standard.set(true, forKey: "isCookedFoodLevelUnlock")
        }

        if UserDefaults.standard.bool(forKey: "isCookedFoodLevelUnlock") {
            if !UserDefaults.standard.bool(forKey: "isFirstUnlockCookedFoodLevelUnlock") {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.totalSize.height >= 920 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2020.0), animated: false)
                    } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2005.0), animated: false)
                    } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1982.0), animated: false)
                    } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2166.0), animated: false)
                    } else if self.totalSize.height <= 670 {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2111.0), animated: false)
                    } else {
                        self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1967.0), animated: false)
                    }
                })

                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                    UIView.animate(withDuration: 1.0, animations: {
                            self.arrowSweetsImage.alpha = 1
                            self.cookedFoodButtonView.alpha = 1
                            self.cookedFoodButtonView.isUserInteractionEnabled = true
                        })
                }
            }
            UserDefaults.standard.set(true, forKey: "isFirstUnlockCookedFoodLevelUnlock")
        } else {
            self.arrowSweetsImage.alpha = 0.2
            self.cookedFoodButtonView.alpha = 0.4
            self.cookedFoodButtonView.isUserInteractionEnabled = false
        }
    }
//MARK: - scrollWhenOpening
    func scrollWhenOpening() {
        
        //aboutFood
        UIView.animate(withDuration: 0.5, animations: {
            if self.totalSize.height >= 920 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 50.0), animated: false)
            } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 100.0), animated: false)
            } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 200.0), animated: false)
            } else if self.totalSize.height <= 670 {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 270.0), animated: false)
            } else {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 180.0), animated: false)
            }
        })
        
        //drink
        if UserDefaults.standard.bool(forKey: "isDrinkLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 400.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 420.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 500.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 520.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 450.0), animated: false)
                }
            })
        }
        //milk
        if UserDefaults.standard.bool(forKey: "isMilkLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 650.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 650.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 690.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 780.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 750.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 710.0), animated: false)
                }
            })
        }
        //vegetable
        if UserDefaults.standard.bool(forKey: "isVegetableLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 950.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 950.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 980.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1080.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1060.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 990.0), animated: false)
                }
            })
        }

        //fruit
        if UserDefaults.standard.bool(forKey: "isFruitLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1150.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1150.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1160.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1250.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1270.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1170.0), animated: false)
                }
            })
        }
        
        //meat
        if UserDefaults.standard.bool(forKey: "isMeatLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1530.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1530.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1550.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1600.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1610.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1560.0), animated: false)
                }
            })
        }
        
        //products
        if UserDefaults.standard.bool(forKey: "isProductsLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1700.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1700.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1720.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1810.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1800.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1720.0), animated: false)
                }
            })
        }
        
        //sweets
        if UserDefaults.standard.bool(forKey: "isSweetsLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1900.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1900.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1920.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2060.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2070.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1920.0), animated: false)
                }
            })
        }
        
        //cookedFood
        if UserDefaults.standard.bool(forKey: "isCookedFoodLevelUnlock") {
            UIView.animate(withDuration: 0.5, animations: {
                if self.totalSize.height >= 920 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2020.0), animated: false)
                } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2005.0), animated: false)
                } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1982.0), animated: false)
                } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2166.0), animated: false)
                } else if self.totalSize.height <= 670 {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 2111.0), animated: false)
                } else {
                    self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 1967.0), animated: false)
                }
            })
        }
    }
//MARK: PlayProgress
    func playProgress() {
        
        //aboutFood
        aboutFoodAnimation.fromValue = aboutFoodAnimation.toValue
        aboutFoodAnimation.isRemovedOnCompletion = false
        aboutFoodAnimation.duration = 0.5
        aboutFoodAnimation.fillMode = CAMediaTimingFillMode.both
        
            if CGFloat(buttonAboutFoodProgress) > 27 || CGFloat(buttonAboutFoodProgress) < 0 {
                return
            }
        aboutFoodAnimation.toValue = CGFloat(buttonAboutFoodProgress)/27
        shapeLAyerAboutFood.add(aboutFoodAnimation, forKey: "urSoBasic")
        
        //drink
        drinkAnimation.fromValue = drinkAnimation.toValue
        drinkAnimation.isRemovedOnCompletion = false
        drinkAnimation.duration = 0.5
        drinkAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonDrinkProgress) > 18 || CGFloat(buttonDrinkProgress) < 0 {
                return
            }
        drinkAnimation.toValue = CGFloat(buttonDrinkProgress)/18
        shapeLAyerDrink.add(drinkAnimation, forKey: "urSoBasic")

        //drinkReverse
        drinkReverseAnimation.fromValue = drinkReverseAnimation.toValue
        drinkReverseAnimation.isRemovedOnCompletion = false
        drinkReverseAnimation.duration = 0.5
        drinkReverseAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonDrinkReverseProgress) > 36 || CGFloat(buttonDrinkReverseProgress) < 0 {
                return
            }
        drinkReverseAnimation.toValue = CGFloat(buttonDrinkReverseProgress)/36
        shapeLAyerDrinkReverse.add(drinkReverseAnimation, forKey: "urSoBasic")
        
        //milk
        milkAnimation.fromValue = milkAnimation.toValue
        milkAnimation.isRemovedOnCompletion = false
        milkAnimation.duration = 0.5
        milkAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonMilkProgress) > 14 || CGFloat(buttonMilkProgress) < 0 {
                return
            }
        milkAnimation.toValue = CGFloat(buttonMilkProgress)/14
        shapeLAyerMilk.add(milkAnimation, forKey: "urSoBasic")

        //milkReverse
        milkReverseAnimation.fromValue = milkReverseAnimation.toValue
        milkReverseAnimation.isRemovedOnCompletion = false
        milkReverseAnimation.duration = 0.5
        milkReverseAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonMilkReverseProgress) > 28 || CGFloat(buttonMilkReverseProgress) < 0 {
                return
            }
        milkReverseAnimation.toValue = CGFloat(buttonMilkReverseProgress)/28
        shapeLAyerMilkReverse.add(milkReverseAnimation, forKey: "urSoBasic")
        
        //vegetable
        vegetableAnimation.fromValue = vegetableAnimation.toValue
        vegetableAnimation.isRemovedOnCompletion = false
        vegetableAnimation.duration = 0.5
        vegetableAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonVegetableProgress) > 19 || CGFloat(buttonVegetableProgress) < 0 {
                return
            }
        vegetableAnimation.toValue = CGFloat(buttonVegetableProgress)/19
        shapeLAyerVegetable.add(vegetableAnimation, forKey: "urSoBasic")
        
        //fruit
        fruitAnimation.fromValue = fruitAnimation.toValue
        fruitAnimation.isRemovedOnCompletion = false
        fruitAnimation.duration = 0.5
        fruitAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonFruitProgress) > 33 || CGFloat(buttonFruitProgress) < 0 {
                return
            }
        fruitAnimation.toValue = CGFloat(buttonFruitProgress)/33
        shapeLAyerFruit.add(fruitAnimation, forKey: "urSoBasic")
        
        //nut
        nutAnimation.fromValue = nutAnimation.toValue
        nutAnimation.isRemovedOnCompletion = false
        nutAnimation.duration = 0.5
        nutAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonNutProgress) > 13 || CGFloat(buttonNutProgress) < 0 {
                return
            }
        nutAnimation.toValue = CGFloat(buttonNutProgress)/13
        shapeLAyerNut.add(nutAnimation, forKey: "urSoBasic")
        
        //meat
        meatAnimation.fromValue = meatAnimation.toValue
        meatAnimation.isRemovedOnCompletion = false
        meatAnimation.duration = 0.5
        meatAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonMeatProgress) > 17 || CGFloat(buttonMeatProgress) < 0 {
                return
            }
        meatAnimation.toValue = CGFloat(buttonMeatProgress)/17
        shapeLAyerMeat.add(meatAnimation, forKey: "urSoBasic")
        
        //products
        productsAnimation.fromValue = productsAnimation.toValue
        productsAnimation.isRemovedOnCompletion = false
        productsAnimation.duration = 0.5
        productsAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonProductsProgress) > 19 || CGFloat(buttonProductsProgress) < 0 {
                return
            }
        productsAnimation.toValue = CGFloat(buttonProductsProgress)/19
        shapeLAyerProducts.add(productsAnimation, forKey: "urSoBasic")
        
        //productsReverse
        productsReverseAnimation.fromValue = productsReverseAnimation.toValue
        productsReverseAnimation.isRemovedOnCompletion = false
        productsReverseAnimation.duration = 0.5
        productsReverseAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonProductsReverseProgress) > 38 || CGFloat(buttonProductsReverseProgress) < 0 {
                return
            }
        productsReverseAnimation.toValue = CGFloat(buttonProductsReverseProgress)/38
        shapeLAyerProductsReverse.add(productsReverseAnimation, forKey: "urSoBasic")
        
        //sweets
        sweetsAnimation.fromValue = sweetsAnimation.toValue
        sweetsAnimation.isRemovedOnCompletion = false
        sweetsAnimation.duration = 0.5
        sweetsAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonSweetsProgress) > 16 || CGFloat(buttonSweetsProgress) < 0 {
                return
            }
        sweetsAnimation.toValue = CGFloat(buttonSweetsProgress)/16
        shapeLAyerSweets.add(sweetsAnimation, forKey: "urSoBasic")
        
        //cookedFood
        cookedFoodAnimation.fromValue = cookedFoodAnimation.toValue
        cookedFoodAnimation.isRemovedOnCompletion = false
        cookedFoodAnimation.duration = 0.5
        cookedFoodAnimation.fillMode = CAMediaTimingFillMode.both

            if CGFloat(buttonCookedFoodProgress) > 17 || CGFloat(buttonCookedFoodProgress) < 0 {
                return
            }
        cookedFoodAnimation.toValue = CGFloat(buttonCookedFoodProgress)/17
        shapeLAyerCookedFood.add(cookedFoodAnimation, forKey: "urSoBasic")
        
//        
//        UserDefaults.standard.set(14, forKey: "buttonMilkProgress")
//        UserDefaults.standard.set(19, forKey: "buttonVegetableProgress")
//        UserDefaults.standard.set(33, forKey: "buttonFruitProgress")
//        UserDefaults.standard.set(17, forKey: "buttonMeatProgress")
//        UserDefaults.standard.set(19, forKey: "buttonProductsProgress")
//        UserDefaults.standard.set(16, forKey: "buttonSweetsProgress")
//        UserDefaults.standard.set(17, forKey: "buttonCookedFoodProgress")
        
        //saveProgress
        buttonFoodProgress = buttonAboutFoodProgress + buttonDrinkProgress + buttonMilkProgress + buttonVegetableProgress + buttonFruitProgress + buttonMeatProgress + buttonProductsProgress + buttonSweetsProgress + buttonCookedFoodProgress
        
        UserDefaults.standard.set(buttonFoodProgress, forKey: "buttonFoodProgress")
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
        lbl.text = "Еда".localized()
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
            positY = -350
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -410
        } else if totalSize.height <= 670 {
            positY = -320
        } else {
            positY = -330
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
        lbl.text = "__".localized()
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
            positY = -345
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -405
        } else if totalSize.height <= 670 {
            positY = -315
        } else {
            positY = -325
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
            positY = -550
            positX = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -440
            positX = -10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 0
        } else if totalSize.height <= 670 {
            positY = -398
            positX = -20
        } else {
            positY = -397
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
            positY = -550
            positX = 40
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 40
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -440
            positX = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 40
        } else if totalSize.height <= 670 {
            positY = -398
            positX = 20
        } else {
            positY = -397
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
            positY = -550
            positX = 80
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 80
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -440
            positX = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 80
        } else if totalSize.height <= 670 {
            positY = -398
            positX = 60
        } else {
            positY = -397
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
            positY = -550
            positX = 120
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 120
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -440
            positX = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 120
        } else if totalSize.height <= 670 {
            positY = -398
            positX = 100
        } else {
            positY = -397
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
            positY = -550
            positX = 160
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -513
            positX = 160
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -440
            positX = 150
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -518
            positX = 160
        } else if totalSize.height <= 670 {
            positY = -398
            positX = 140
        } else {
            positY = -397
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
        if buttonFoodProgress >= 35 {
            starImage1.image = UIImage(named: "starFull1")
        } else {
            starImage1.image = UIImage(named: "star1")
        }
        if buttonFoodProgress >= 70 {
            starImage2.image = UIImage(named: "starFull2")
        } else {
            starImage2.image = UIImage(named: "star2")
        }
        if buttonFoodProgress >= 105 {
            starImage3.image = UIImage(named: "starFull3")
        } else {
            starImage3.image = UIImage(named: "star3")
        }
        if buttonFoodProgress >= 140 {
            starImage4.image = UIImage(named: "starFull1")
        } else {
            starImage4.image = UIImage(named: "star1")
        }
        if buttonFoodProgress >= 175 {
            starImage5.image = UIImage(named: "starFull2")
        } else {
            starImage5.image = UIImage(named: "star2")
        }
    }
//MARK: - AboutFoodButton
    lazy var aboutFoodButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)
        
        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = -163
            lead = 61
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -163
            lead = 50
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -107
            lead = 6
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -163
            lead = 50
        } else if totalSize.height <= 670 {
            positY = -107
            lead = 0
        } else {
            positY = -107
            lead = 0
        }
        
        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var aboutFoodButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "aboutFoodButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        aboutFoodButtonView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(85)
        }
        
        return btn
    }()
    @objc func aboutFoodButtonAction(sender: UIButton) {
        UserDefaults.standard.set("aboutFood", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.aboutFood.count, forKey: "numberOfQuestionPerRound")

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
    
    func buttonAboutFoodCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        
        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -421
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -405
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -379
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -326
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -291
            positX = -88
        } else {
            positY = -363
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
        aboutFoodButtonView.layer.addSublayer(progressLayer)

        
        shapeLAyerAboutFood.path = circularPath.cgPath
        shapeLAyerAboutFood.position = CGPoint(x: positX, y: positY)
        shapeLAyerAboutFood.fillColor = UIColor.clear.cgColor
        shapeLAyerAboutFood.lineWidth = 7
        shapeLAyerAboutFood.lineCap = .round
        shapeLAyerAboutFood.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerAboutFood)
        aboutFoodButtonView.layer.addSublayer(shapeLAyerAboutFood)
        
    }
    //crown
    lazy var crownAboutFoodImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.35))
        aboutFoodButtonView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-38)
            make.centerYWithinMargins.equalTo(-110)
        }
        
        return img
    }()
    
    //Arrow
    lazy var arrowAboutFoodImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowAboutFoodImage"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        self.view.addSubview(img)
        aboutFoodButtonView.addSubview(img)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 130
            positX = 71
            positY = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 130
            positX = 71
            positY = 60
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 110
            positX = 82
            positY = 31
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 130
            positX = 71
            positY = 60
        } else if totalSize.height <= 670 {
            wdth = 110
            positX = 82
            positY = 31
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
        } else {
            wdth = 110
            positX = 82
            positY = 31
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return img
    }()
    //Label
    lazy var aboutFoodLabel: UILabel = {
        
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
        lbl.text = "Про еду и вкус".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        self.view.addSubview(lbl)
        aboutFoodButtonView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(50)
            make.centerYWithinMargins.equalTo(-140)
        }
        return lbl
    }()
//MARK: - DrinkButton
    lazy var drinkButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 60
            trail = 20
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 60
            trail = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 60
            trail = 20
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 60
            trail = 20
        } else if totalSize.height <= 670 {
            positY = 60
            trail = 10
        } else {
            positY = 60
            trail = 10
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var drinkButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "drinkButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        drinkButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
        }

        return btn
    }()
    @objc func drinkButtonAction(sender: UIButton) {
        UserDefaults.standard.set("drink", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.drink.count, forKey: "numberOfQuestionPerRound")

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

    func buttonDrinkCircleProgress() {
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
        drinkButtonView.layer.addSublayer(progressLayer)


        shapeLAyerDrink.path = circularPath.cgPath
        shapeLAyerDrink.position = CGPoint(x: positX, y: positY)
        shapeLAyerDrink.fillColor = UIColor.clear.cgColor
        shapeLAyerDrink.lineWidth = 7
        shapeLAyerDrink.lineCap = .round
        shapeLAyerDrink.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerDrink)
        drinkButtonView.layer.addSublayer(shapeLAyerDrink)

    }
    //crown
    lazy var crownDrinkImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.25))
        drinkButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(35)
            make.centerYWithinMargins.equalTo(-122)
        }

        return img
    }()

    //Arrow
    lazy var arrowDrinkImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowDrinkImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        drinkButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 190
            positX = -57
            positY = 87
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 190
            positX = -57
            positY = 87
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 180
            positX = -42
            positY = 87
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 190
            positX = -57
            positY = 87
        } else if totalSize.height <= 670 {
            wdth = 180
            positX = -42
            positY = 87
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        } else {
            wdth = 180
            positX = -42
            positY = 87
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    //Label
    lazy var drinkLabel: UILabel = {

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
        lbl.text = "Напитки".localized()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        drinkButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(-170)
        }
        return lbl
    }()
//MARK: - DrinkReverse
    lazy var drinkReverseButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 120
            lead = 27
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 120
            lead = 20
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 130
            lead = 3
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 120
            lead = 15
        } else if totalSize.height <= 670 {
            positY = 130
            lead = -1
        } else {
            positY = 130
            lead = -1
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var drinkReverseButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "drinkReverseButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        drinkReverseButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(76)
        }

        return btn
    }()
    @objc func drinkReverseButtonAction(sender: UIButton) {
        UserDefaults.standard.set("drinkReverse", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.drinkReverse.count, forKey: "numberOfQuestionPerRound")

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

    func buttonDrinkReverseCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -424
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -411
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -385
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -330
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -297
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
        drinkReverseButtonView.layer.addSublayer(progressLayer)


        shapeLAyerDrinkReverse.path = circularPath.cgPath
        shapeLAyerDrinkReverse.position = CGPoint(x: positX, y: positY)
        shapeLAyerDrinkReverse.fillColor = UIColor.clear.cgColor
        shapeLAyerDrinkReverse.lineWidth = 7
        shapeLAyerDrinkReverse.lineCap = .round
        shapeLAyerDrinkReverse.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerDrinkReverse)
        drinkReverseButtonView.layer.addSublayer(shapeLAyerDrinkReverse)

    }
    //crown
    lazy var crownDrinkReverseImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.05))
        drinkReverseButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(10)
            make.centerYWithinMargins.equalTo(-130)
        }

        return img
    }()
//MARK: - MilkButton
    lazy var milkButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 310
            trail = 65
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 310
            trail = 65
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 303
            trail = 45
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 310
            trail = 65
        } else if totalSize.height <= 670 {
            positY = 303
            trail = 33
        } else {
            positY = 303
            trail = 33
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var milkButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "milkButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        milkButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
        }

        return btn
    }()
    @objc func milkButtonAction(sender: UIButton) {
        UserDefaults.standard.set("milk", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.milk.count, forKey: "numberOfQuestionPerRound")

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

    func buttonMilkCircleProgress() {
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
        milkButtonView.layer.addSublayer(progressLayer)


        shapeLAyerMilk.path = circularPath.cgPath
        shapeLAyerMilk.position = CGPoint(x: positX, y: positY)
        shapeLAyerMilk.fillColor = UIColor.clear.cgColor
        shapeLAyerMilk.lineWidth = 7
        shapeLAyerMilk.lineCap = .round
        shapeLAyerMilk.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerMilk)
        milkButtonView.layer.addSublayer(shapeLAyerMilk)

    }
    //crown
    lazy var crownMilkImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.22))
        milkButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-5)
            make.centerYWithinMargins.equalTo(-125)
        }

        return img
    }()

    //Arrow
    lazy var arrowMilkImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowMilkImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        milkButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 148
            positX = -57
            positY = 70
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 148
            positX = -57
            positY = 70
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 148
            positX = -48
            positY = 70
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 148
            positX = -57
            positY = 70
        } else if totalSize.height <= 670 {
            wdth = 148
            positX = -48
            positY = 70
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        } else {
            wdth = 148
            positX = -48
            positY = 70
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    //Label
    lazy var milkLabel: UILabel = {

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
        lbl.text = "Молочные \n \nпродукты".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        self.view.addSubview(lbl)
        milkButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-120)
            make.centerYWithinMargins.equalTo(-90)
        }
        return lbl
    }()
//MARK: - MilkReverseButton
    lazy var milkReverseButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 400
            lead = 12
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 400
            lead = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 400
            lead = 2
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 400
            lead = 0
        } else if totalSize.height <= 670 {
            positY = 400
            lead = 0
        } else {
            positY = 400
            lead = 0
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var milkReverseButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "milkReverseButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        milkReverseButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
        }

        return btn
    }()
    @objc func milkReverseButtonAction(sender: UIButton) {
        UserDefaults.standard.set("milkReverse", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.milkReverse.count, forKey: "numberOfQuestionPerRound")

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

    func buttonMilkReverseCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -426
            positX = -117
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -413
            positX = -109
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -387
            positX = -98
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -332
            positX = -110
        } else if totalSize.height <= 670 {
            positY = -299
            positX = -91
        } else {
            positY = -371
            positX = -91
        }

        let progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.position = CGPoint(x: positX, y: positY)
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 12.0
        view.layer.addSublayer(progressLayer)
        milkReverseButtonView.layer.addSublayer(progressLayer)


        shapeLAyerMilkReverse.path = circularPath.cgPath
        shapeLAyerMilkReverse.position = CGPoint(x: positX, y: positY)
        shapeLAyerMilkReverse.fillColor = UIColor.clear.cgColor
        shapeLAyerMilkReverse.lineWidth = 7
        shapeLAyerMilkReverse.lineCap = .round
        shapeLAyerMilkReverse.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerMilkReverse)
        milkReverseButtonView.layer.addSublayer(shapeLAyerMilkReverse)

    }
    //crown
    lazy var crownMilkReverseImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        milkReverseButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-35)
            make.centerYWithinMargins.equalTo(-125)
        }

        return img
    }()
//MARK: - VegetableButton
    lazy var vegetableButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 587
            trail = 85
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 580
            trail = 85
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 583
            trail = 60
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 586
            trail = 89
        } else if totalSize.height <= 670 {
            positY = 583
            trail = 48
        } else {
            positY = 583
            trail = 48
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var vegetableButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "vegetableButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        vegetableButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
        }

        return btn
    }()
    @objc func vegetableButtonAction(sender: UIButton) {
        UserDefaults.standard.set("vegetable", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.vegetable.count, forKey: "numberOfQuestionPerRound")

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

    func buttonVegetableCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -420
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -407
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -381
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -326
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -293
            positX = -88
        } else {
            positY = -365
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
        vegetableButtonView.layer.addSublayer(progressLayer)


        shapeLAyerVegetable.path = circularPath.cgPath
        shapeLAyerVegetable.position = CGPoint(x: positX, y: positY)
        shapeLAyerVegetable.fillColor = UIColor.clear.cgColor
        shapeLAyerVegetable.lineWidth = 7
        shapeLAyerVegetable.lineCap = .round
        shapeLAyerVegetable.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerVegetable)
        vegetableButtonView.layer.addSublayer(shapeLAyerVegetable)

    }
    //crown
    lazy var crownVegetableImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.8))
        vegetableButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-35)
            make.centerYWithinMargins.equalTo(-117)
        }

        return img
    }()

    //Arrow
    lazy var arrowVegetableImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowVegetableImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        vegetableButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 120
            positX = -14
            positY = 77
            img.transform = CGAffineTransform(rotationAngle: CGFloat(0.07))
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 120
            positX = -10
            positY = 78
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 120
            positX = -10
            positY = 78
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 120
            positX = -8
            positY = 78
            img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.01))
        } else if totalSize.height <= 670 {
            wdth = 110
            positX = -8
            positY = 71
        } else {
            wdth = 110
            positX = -8
            positY = 71
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    //Label
    lazy var vegetableLabel: UILabel = {

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
        lbl.text = "Овощи".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.2))
        self.view.addSubview(lbl)
        vegetableButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(45)
            make.centerYWithinMargins.equalTo(-130)
        }
        return lbl
    }()
//MARK: - FruitButton
    lazy var fruitButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 790
            lead = 30
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 790
            lead = 30
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 790
            lead = 30
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 790
            lead = 30
        } else if totalSize.height <= 670 {
            positY = 777
            lead = 33
        } else {
            positY = 777
            lead = 33
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var fruitButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "fruitButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        fruitButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(75)
        }

        return btn
    }()
    @objc func fruitButtonAction(sender: UIButton) {
        UserDefaults.standard.set("fruit", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.fruit.count, forKey: "numberOfQuestionPerRound")

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

    func buttonFruitCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -424
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -411
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -385
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -330
            positX = -107
        } else if totalSize.height <= 670 {
            positY = -297
            positX = -88
        } else {
            positY = -369
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
        fruitButtonView.layer.addSublayer(progressLayer)


        shapeLAyerFruit.path = circularPath.cgPath
        shapeLAyerFruit.position = CGPoint(x: positX, y: positY)
        shapeLAyerFruit.fillColor = UIColor.clear.cgColor
        shapeLAyerFruit.lineWidth = 7
        shapeLAyerFruit.lineCap = .round
        shapeLAyerFruit.strokeEnd = 0

        view.layer.addSublayer(shapeLAyerFruit)
        fruitButtonView.layer.addSublayer(shapeLAyerFruit)

    }
    //crown
    lazy var crownFruitImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.8))
        fruitButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(35)
            make.centerYWithinMargins.equalTo(-117)
        }

        return img
    }()

    //Arrow
    lazy var arrowFruitImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowFruitImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        fruitButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 280
            positX = 64
            positY = 110
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 280
            positX = 64
            positY = 110
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 280
            positX = 64
            positY = 110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 280
            positX = 64
            positY = 110
        } else if totalSize.height <= 670 {
            wdth = 270
            positX = 61
            positY = 107
        } else {
            wdth = 270
            positX = 61
            positY = 107
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    //Label
    lazy var fruitLabel: UILabel = {

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
        lbl.text = "Фрукты".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        self.view.addSubview(lbl)
        fruitButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-30)
            make.centerYWithinMargins.equalTo(-140)
        }
        return lbl
    }()
    
//MARK: - NutButton
    lazy var nutButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 955
            trail = 19
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 961
            trail = 15
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 964
            trail = 2
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 961
            trail = 15
        } else if totalSize.height <= 670 {
            positY = 950
            trail = 0
        } else {
            positY = 950
            trail = 0
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var nutButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "nutButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        nutButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(85)
        }

        return btn
    }()
    @objc func nutButtonAction(sender: UIButton) {
        UserDefaults.standard.set("nut", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.nut.count, forKey: "numberOfQuestionPerRound")

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

    func buttonNutCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -421
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -408
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -382
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -327
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
        nutButtonView.layer.addSublayer(progressLayer)


        shapeLAyerNut.path = circularPath.cgPath
        shapeLAyerNut.position = CGPoint(x: positX, y: positY)
        shapeLAyerNut.fillColor = UIColor.clear.cgColor
        shapeLAyerNut.lineWidth = 7
        shapeLAyerNut.lineCap = .round
        shapeLAyerNut.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerNut)
        nutButtonView.layer.addSublayer(shapeLAyerNut)

    }
    //crown
    lazy var crownNutImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.5))
        nutButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(15)
            make.centerYWithinMargins.equalTo(-125)
        }

        return img
    }()
    //Label
    lazy var nutLabel: UILabel = {

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
        lbl.text = "Орехи и \n \nсухофрукты".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        nutButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-180)
        }
        return lbl
    }()
    
//MARK: - MeatButton
    lazy var meatButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 1150
            trail = 100
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1150
            trail = 100
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1153
            trail = 70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 1150
            trail = 100
        } else if totalSize.height <= 670 {
            positY = 1132
            trail = 61
        } else {
            positY = 1132
            trail = 61
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var meatButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "meatButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        meatButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(85)
        }

        return btn
    }()
    @objc func meatButtonAction(sender: UIButton) {
        UserDefaults.standard.set("meat", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.meat.count, forKey: "numberOfQuestionPerRound")

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

    func buttonMeatCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -421
            positX = -114
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -408
            positX = -107
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -382
            positX = -95
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -327
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
        meatButtonView.layer.addSublayer(progressLayer)


        shapeLAyerMeat.path = circularPath.cgPath
        shapeLAyerMeat.position = CGPoint(x: positX, y: positY)
        shapeLAyerMeat.fillColor = UIColor.clear.cgColor
        shapeLAyerMeat.lineWidth = 7
        shapeLAyerMeat.lineCap = .round
        shapeLAyerMeat.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerMeat)
        meatButtonView.layer.addSublayer(shapeLAyerMeat)

    }
    //crown
    lazy var crownMeatImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        meatButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(30)
            make.centerYWithinMargins.equalTo(-120)
        }

        return img
    }()
    
    //Arrow
    lazy var arrowMeatImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowMeatImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        meatButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 150
            positX = -33
            positY = 43
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 150
            positX = -33
            positY = 43
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 145
            positX = -33
            positY = 40
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 150
            positX = -33
            positY = 43
        } else if totalSize.height <= 670 {
            wdth = 150
            positX = -33
            positY = 43
        } else {
            wdth = 150
            positX = -33
            positY = 43
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    
    //Label
    lazy var meatLabel: UILabel = {

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
        lbl.text = "Мясо, рыба и \n \nморепродукты".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(-0.3))
        self.view.addSubview(lbl)
        meatButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(-105)
            make.centerYWithinMargins.equalTo(-130)
        }
        return lbl
    }()
    
//MARK: - ProductsButton
    lazy var productsButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 1350
            lead = 10
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1350
            lead = 10
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1350
            lead = 10
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 1350
            lead = 10
        } else if totalSize.height <= 670 {
            positY = 1334
            lead = 10
        } else {
            positY = 1334
            lead = 10
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var productsButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "productsButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        productsButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }

        return btn
    }()
    @objc func productsButtonAction(sender: UIButton) {
        UserDefaults.standard.set("products", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.products.count, forKey: "numberOfQuestionPerRound")

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

    func buttonProductsCircleProgress() {
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
        productsButtonView.layer.addSublayer(progressLayer)


        shapeLAyerProducts.path = circularPath.cgPath
        shapeLAyerProducts.position = CGPoint(x: positX, y: positY)
        shapeLAyerProducts.fillColor = UIColor.clear.cgColor
        shapeLAyerProducts.lineWidth = 7
        shapeLAyerProducts.lineCap = .round
        shapeLAyerProducts.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerProducts)
        productsButtonView.layer.addSublayer(shapeLAyerProducts)

    }
    //crown
    lazy var crownProductsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.22))
        productsButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-5)
            make.centerYWithinMargins.equalTo(-130)
        }

        return img
    }()
    
    //Arrow
    lazy var arrowProductsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowProductsImage"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        productsButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 200
            positX = 80
            positY = 99
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 200
            positX = 80
            positY = 99
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 180
            positX = 70
            positY = 85
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 200
            positX = 80
            positY = 99
        } else if totalSize.height <= 670 {
            wdth = 180
            positX = 70
            positY = 85
        } else {
            wdth = 180
            positX = 70
            positY = 85
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    
    //Label
    lazy var productsLabel: UILabel = {

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
        lbl.text = "Прочие \n \nпродукты".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        self.view.addSubview(lbl)
        productsButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(130)
            make.centerYWithinMargins.equalTo(-60)
        }
        return lbl
    }()
    
//MARK: - ProductsReverseButton
    lazy var productsReverseButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 1450
            trail = 25
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1450
            trail = 10
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1450
            trail = 5
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 1450
            trail = 10
        } else if totalSize.height <= 670 {
            positY = 1430
            trail = -10
        } else {
            positY = 1430
            trail = -10
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var productsReverseButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "productsReverseButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        productsReverseButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }

        return btn
    }()
    @objc func productsReverseButtonAction(sender: UIButton) {
        UserDefaults.standard.set("productsReverse", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.productsReverse.count, forKey: "numberOfQuestionPerRound")

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

    func buttonProductsReverseCircleProgress() {
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
        productsReverseButtonView.layer.addSublayer(progressLayer)


        shapeLAyerProductsReverse.path = circularPath.cgPath
        shapeLAyerProductsReverse.position = CGPoint(x: positX, y: positY)
        shapeLAyerProductsReverse.fillColor = UIColor.clear.cgColor
        shapeLAyerProductsReverse.lineWidth = 7
        shapeLAyerProductsReverse.lineCap = .round
        shapeLAyerProductsReverse.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerProductsReverse)
        productsReverseButtonView.layer.addSublayer(shapeLAyerProductsReverse)

    }
    //crown
    lazy var crownProductsReverseImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.6))
        productsReverseButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(20)
            make.centerYWithinMargins.equalTo(-128)
        }

        return img
    }()
    
//MARK: - SweetsButton
    lazy var sweetsButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var lead: CGFloat!
        if totalSize.height >= 920 {
            positY = 1650
            lead = 65
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1650
            lead = 65
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1623
            lead = 62
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 1650
            lead = 65
        } else if totalSize.height <= 670 {
            positY = 1608
            lead = 61
        } else {
            positY = 1608
            lead = 61
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.leading.equalToSuperview().inset(lead)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var sweetsButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "sweetsButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        sweetsButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
        }

        return btn
    }()
    @objc func sweetsButtonAction(sender: UIButton) {
        UserDefaults.standard.set("sweets", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.sweets.count, forKey: "numberOfQuestionPerRound")

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

    func buttonSweetsCircleProgress() {
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
        sweetsButtonView.layer.addSublayer(progressLayer)


        shapeLAyerSweets.path = circularPath.cgPath
        shapeLAyerSweets.position = CGPoint(x: positX, y: positY)
        shapeLAyerSweets.fillColor = UIColor.clear.cgColor
        shapeLAyerSweets.lineWidth = 7
        shapeLAyerSweets.lineCap = .round
        shapeLAyerSweets.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerSweets)
        sweetsButtonView.layer.addSublayer(shapeLAyerSweets)

    }
    //crown
    lazy var crownSweetsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull1"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.5))
        sweetsButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-15)
            make.centerYWithinMargins.equalTo(-130)
        }

        return img
    }()
    
    //Arrow
    lazy var arrowSweetsImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "arrowSweetsImage"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1))
        self.view.addSubview(img)
        sweetsButtonView.addSubview(img)

        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 205
            positX = 35
            positY = 60
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 205
            positX = 35
            positY = 60
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 205
            positX = 35
            positY = 60
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 205
            positX = 35
            positY = 60
        } else if totalSize.height <= 670 {
            wdth = 195
            positX = 35
            positY = 56
        } else {
            wdth = 195
            positX = 35
            positY = 56
        }

        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }

        return img
    }()
    
    //Label
    lazy var sweetsLabel: UILabel = {

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
        lbl.text = "Сладости".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.3))
        self.view.addSubview(lbl)
        sweetsButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(40)
            make.centerYWithinMargins.equalTo(-160)
        }
        return lbl
    }()
    
//MARK: - CookedFoodButton
    lazy var cookedFoodButtonView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        backgroundView.addSubview(vi)

        var positY: CGFloat!
        var trail: CGFloat!
        if totalSize.height >= 920 {
            positY = 1893
            trail = 82
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1893
            trail = 68
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1860
            trail = 47
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 1893
            trail = 68
        } else if totalSize.height <= 670 {
            positY = 1842
            trail = 34
        } else {
            positY = 1842
            trail = 34
        }

        vi.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.trailing.equalToSuperview().inset(trail)
            make.width.height.equalTo(200)
        }

        return vi
    }()

    lazy var cookedFoodButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "cookedFoodButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(.white, for: .normal)
        self.view.addSubview(btn)
        cookedFoodButtonView.addSubview(btn)

        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }

        return btn
    }()
    @objc func cookedFoodButtonAction(sender: UIButton) {
        UserDefaults.standard.set("cookedFood", forKey: "dictionaryName")
        UserDefaults.standard.set(questionsModel.cookedFood.count, forKey: "numberOfQuestionPerRound")

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

    func buttonCookedFoodCircleProgress() {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 48, startAngle: -CGFloat.pi/2, endAngle: 3*CGFloat.pi / 2, clockwise: true)

        var positY: CGFloat!
        var positX: CGFloat!
        if totalSize.height >= 920 {
            positY = -437
            positX = -119
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -424
            positX = -112
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -398
            positX = -100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -343
            positX = -112
        } else if totalSize.height <= 670 {
            positY = -310
            positX = -93
        } else {
            positY = -382
            positX = -93
        }

        let progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.position = CGPoint(x: positX, y: positY)
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 12.0
        view.layer.addSublayer(progressLayer)
        cookedFoodButtonView.layer.addSublayer(progressLayer)


        shapeLAyerCookedFood.path = circularPath.cgPath
        shapeLAyerCookedFood.position = CGPoint(x: positX, y: positY)
        shapeLAyerCookedFood.fillColor = UIColor.clear.cgColor
        shapeLAyerCookedFood.lineWidth = 7
        shapeLAyerCookedFood.lineCap = .round
        shapeLAyerCookedFood.strokeEnd = 0
        view.layer.addSublayer(shapeLAyerCookedFood)
        cookedFoodButtonView.layer.addSublayer(shapeLAyerCookedFood)

    }
    //crown
    lazy var crownCookedFoodImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "crownFull2"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        cookedFoodButtonView.addSubview(img)

        img.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerXWithinMargins.equalTo(-20)
            make.centerYWithinMargins.equalTo(-140)
        }

        return img
    }()
    
    //Label
    lazy var cookedFoodLabel: UILabel = {

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
        lbl.text = "Готовая еда".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.6
        lbl.transform = CGAffineTransform(rotationAngle: CGFloat(0.15))
        self.view.addSubview(lbl)
        cookedFoodButtonView.addSubview(lbl)

        lbl.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(40)
            make.centerYWithinMargins.equalTo(-180)
        }
        return lbl
    }()
    
//MARK: - ColorProgress
    func colorProgress() {
        //aboutFood
        if buttonAboutFoodProgress >= 19 {
            shapeLAyerAboutFood.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonAboutFoodProgress >= 14 {
            shapeLAyerAboutFood.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonAboutFoodProgress >= 9 {
            shapeLAyerAboutFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonAboutFoodProgress >= 5 {
            shapeLAyerAboutFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonAboutFoodProgress >= 0 {
            shapeLAyerAboutFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //drink
        if buttonDrinkProgress >= 13 {
            shapeLAyerDrink.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonDrinkProgress >= 10 {
            shapeLAyerDrink.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonDrinkProgress >= 6 {
            shapeLAyerDrink.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonDrinkProgress >= 3 {
            shapeLAyerDrink.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonDrinkProgress >= 0 {
            shapeLAyerDrink.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //drinkReverse
        if buttonDrinkReverseProgress >= 28 {
            shapeLAyerDrinkReverse.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonDrinkReverseProgress >= 21 {
            shapeLAyerDrinkReverse.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonDrinkReverseProgress >= 14 {
            shapeLAyerDrinkReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonDrinkReverseProgress >= 7 {
            shapeLAyerDrinkReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonDrinkReverseProgress >= 0 {
            shapeLAyerDrinkReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //milk
        if buttonMilkProgress >= 11 {
            shapeLAyerMilk.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonMilkProgress >= 8 {
            shapeLAyerMilk.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonMilkProgress >= 5 {
            shapeLAyerMilk.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonMilkProgress >= 3 {
            shapeLAyerMilk.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonMilkProgress >= 0 {
            shapeLAyerMilk.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //milkReverse
        if buttonMilkReverseProgress >= 20 {
            shapeLAyerMilkReverse.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonMilkReverseProgress >= 15 {
            shapeLAyerMilkReverse.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonMilkReverseProgress >= 10 {
            shapeLAyerMilkReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonMilkReverseProgress >= 5 {
            shapeLAyerMilkReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonMilkReverseProgress >= 0 {
            shapeLAyerMilkReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }

        //vegetable
        if buttonVegetableProgress >= 13 {
            shapeLAyerVegetable.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonVegetableProgress >= 10 {
            shapeLAyerVegetable.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonVegetableProgress >= 6 {
            shapeLAyerVegetable.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonVegetableProgress >= 3 {
            shapeLAyerVegetable.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonVegetableProgress >= 0 {
            shapeLAyerVegetable.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //fruit
        if buttonFruitProgress >= 23 {
            shapeLAyerFruit.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonFruitProgress >= 17 {
            shapeLAyerFruit.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonFruitProgress >= 11 {
            shapeLAyerFruit.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonFruitProgress >= 6 {
            shapeLAyerFruit.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonFruitProgress >= 0 {
            shapeLAyerFruit.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //nut
        if buttonNutProgress >= 9 {
            shapeLAyerNut.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonNutProgress >= 7 {
            shapeLAyerNut.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonNutProgress >= 5 {
            shapeLAyerNut.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonNutProgress >= 3 {
            shapeLAyerNut.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonNutProgress >= 0 {
            shapeLAyerNut.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //meat
        if buttonMeatProgress >= 12 {
            shapeLAyerMeat.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonMeatProgress >= 9 {
            shapeLAyerMeat.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonMeatProgress >= 6 {
            shapeLAyerMeat.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonMeatProgress >= 3 {
            shapeLAyerMeat.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonMeatProgress >= 0 {
            shapeLAyerMeat.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //products
        if buttonProductsProgress >= 14 {
            shapeLAyerProducts.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonProductsProgress >= 10 {
            shapeLAyerProducts.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonProductsProgress >= 7 {
            shapeLAyerProducts.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonProductsProgress >= 3 {
            shapeLAyerProducts.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonProductsProgress >= 0 {
            shapeLAyerProducts.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //productsReverse
        if buttonProductsReverseProgress >= 28 {
            shapeLAyerProductsReverse.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonProductsReverseProgress >= 23 {
            shapeLAyerProductsReverse.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonProductsReverseProgress >= 14 {
            shapeLAyerProductsReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonProductsReverseProgress >= 7 {
            shapeLAyerProductsReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonProductsReverseProgress >= 0 {
            shapeLAyerProductsReverse.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //sweets
        if buttonSweetsProgress >= 11 {
            shapeLAyerSweets.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonSweetsProgress >= 8 {
            shapeLAyerSweets.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonSweetsProgress >= 5 {
            shapeLAyerSweets.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonSweetsProgress >= 3 {
            shapeLAyerSweets.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonSweetsProgress >= 0 {
            shapeLAyerSweets.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
        }
        
        //cookedFood
        if buttonCookedFoodProgress >= 12 {
            shapeLAyerCookedFood.strokeColor = #colorLiteral(red: 0.04639814071, green: 1, blue: 0, alpha: 1)
        } else if buttonCookedFoodProgress >= 9 {
            shapeLAyerCookedFood.strokeColor = #colorLiteral(red: 0.7074999418, green: 1, blue: 0, alpha: 1)
        } else if buttonCookedFoodProgress >= 6 {
            shapeLAyerCookedFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.9127543679, blue: 0, alpha: 1)
        } else if buttonCookedFoodProgress >= 3 {
            shapeLAyerCookedFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.6792030525, blue: 0.000164011516, alpha: 1)
        } else if buttonCookedFoodProgress >= 0 {
            shapeLAyerCookedFood.strokeColor = #colorLiteral(red: 0.997764051, green: 0.38737463, blue: 0, alpha: 1)
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
        view.heightAnchor.constraint(equalToConstant: 4000).isActive = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "blackboardFoodMenu"))
        img.contentMode = .scaleAspectFit
        self.view.addSubview(img)
        backgroundView.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(745)
            make.leading.trailing.equalTo(0)
        }
        
        return img
    }()
    //chalkBurger
    lazy var chalkBurgerImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "chalkBurger"))
        img.contentMode = .scaleAspectFit
        img.transform = CGAffineTransform(rotationAngle: CGFloat(0.1))
        backgroundView.addSubview(img)
        
        var positY: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 920 {
            positY = 1990
            wdth = 140
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 1950
            wdth = 140
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 1890
            wdth = 120
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 1960
            wdth = 130
        } else if totalSize.height <= 670 {
            positY = 1850
            wdth = 110
        } else {
            positY = 1845
            wdth = 115
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(-100)
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
            positBttm = -62
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positBttm = -18
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positBttm = 58
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positBttm = -52
        } else if totalSize.height <= 670 {
            positBttm = 71
        } else {
            positBttm = 105
        }
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -1150).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: positBttm).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

//MARK: RewardCrown
    func updateCrown() {
        //saveProgress
        //aboutFood
        if buttonAboutFoodProgress == 27 {
            UserDefaults.standard.set(true, forKey: "crownAboutFoodBool")
        }
        //drink
        if buttonDrinkProgress == 18 {
            UserDefaults.standard.set(true, forKey: "crownDrinkBool")
        }
        //drinkReverse
        if buttonDrinkReverseProgress == 36 {
            UserDefaults.standard.set(true, forKey: "crownDrinkReverseBool")
        }
        //milk
        if buttonMilkProgress == 14 {
            UserDefaults.standard.set(true, forKey: "crownMilkBool")
        }
        //milkReverse
        if buttonMilkReverseProgress == 28 {
            UserDefaults.standard.set(true, forKey: "crownMilkReverseBool")
        }
        //vegetable
        if buttonVegetableProgress == 19 {
            UserDefaults.standard.set(true, forKey: "crownVegetableBool")
        }
        //fruit
        if buttonFruitProgress == 33 {
            UserDefaults.standard.set(true, forKey: "crownFruitBool")
        }
        //nut
        if buttonNutProgress == 13 {
            UserDefaults.standard.set(true, forKey: "crownNutBool")
        }
        //meat
        if buttonMeatProgress == 17 {
            UserDefaults.standard.set(true, forKey: "crownMeatBool")
        }
        //products
        if buttonProductsProgress == 19 {
            UserDefaults.standard.set(true, forKey: "crownProductsBool")
        }
        //productsReverse
        if buttonProductsReverseProgress == 38 {
            UserDefaults.standard.set(true, forKey: "crownProductsReverseBool")
        }
        //sweets
        if buttonSweetsProgress == 16 {
            UserDefaults.standard.set(true, forKey: "crownSweetsBool")
        }
        //cookedFood
        if buttonCookedFoodProgress == 17 {
            UserDefaults.standard.set(true, forKey: "crownCookedFoodBool")
        }
        
        
        
        
        //spawn
        //aboutFood
        if UserDefaults.standard.bool(forKey: "crownAboutFoodBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownAboutFood") {
                animationReward()
                playConfirmationSound()
                crownAboutFoodImage.isHidden = false
                crownAboutFoodImage.pulsate()
            } else {
                crownAboutFoodImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownAboutFood")
        }
        //drink
        if UserDefaults.standard.bool(forKey: "crownDrinkBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownDrink") {
                animationReward()
                playConfirmationSound()
                crownDrinkImage.isHidden = false
                crownDrinkImage.pulsate()
            } else {
                crownDrinkImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownDrink")
        }
        //drinkReverse
        if UserDefaults.standard.bool(forKey: "crownDrinkReverseBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownDrinkReverse") {
                animationReward()
                playConfirmationSound()
                crownDrinkReverseImage.isHidden = false
                crownDrinkReverseImage.pulsate()
            } else {
                crownDrinkReverseImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownDrinkReverse")
        }
        //milk
        if UserDefaults.standard.bool(forKey: "crownMilkBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownMilk") {
                animationReward()
                playConfirmationSound()
                crownMilkImage.isHidden = false
                crownMilkImage.pulsate()
            } else {
                crownMilkImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownMilk")
        }
        //milkReverse
        if UserDefaults.standard.bool(forKey: "crownMilkReverseBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownMilkReverse") {
                animationReward()
                playConfirmationSound()
                crownMilkReverseImage.isHidden = false
                crownMilkReverseImage.pulsate()
            } else {
                crownMilkReverseImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownMilkReverse")
        }
        //vegetable
        if UserDefaults.standard.bool(forKey: "crownVegetableBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownVegetable") {
                animationReward()
                playConfirmationSound()
                crownVegetableImage.isHidden = false
                crownVegetableImage.pulsate()
            } else {
                crownVegetableImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownVegetable")
        }
        //fruit
        if UserDefaults.standard.bool(forKey: "crownFruitBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownFruit") {
                animationReward()
                playConfirmationSound()
                crownFruitImage.isHidden = false
                crownFruitImage.pulsate()
            } else {
                crownFruitImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownFruit")
        }
        //nut
        if UserDefaults.standard.bool(forKey: "crownNutBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownNut") {
                animationReward()
                playConfirmationSound()
                crownNutImage.isHidden = false
                crownNutImage.pulsate()
            } else {
                crownNutImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownNut")
        }
        //meat
        if UserDefaults.standard.bool(forKey: "crownMeatBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownMeat") {
                animationReward()
                playConfirmationSound()
                crownMeatImage.isHidden = false
                crownMeatImage.pulsate()
            } else {
                crownMeatImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownMeat")
        }
        //products
        if UserDefaults.standard.bool(forKey: "crownProductsBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownProducts") {
                animationReward()
                playConfirmationSound()
                crownProductsImage.isHidden = false
                crownProductsImage.pulsate()
            } else {
                crownProductsImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownProducts")
        }
        //productsReverse
        if UserDefaults.standard.bool(forKey: "crownProductsReverseBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownProductsReverse") {
                animationReward()
                playConfirmationSound()
                crownProductsReverseImage.isHidden = false
                crownProductsReverseImage.pulsate()
            } else {
                crownProductsReverseImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownProductsReverse")
        }
        //sweets
        if UserDefaults.standard.bool(forKey: "crownSweetsBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownSweets") {
                animationReward()
                playConfirmationSound()
                crownSweetsImage.isHidden = false
                crownSweetsImage.pulsate()
            } else {
                crownSweetsImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownSweets")
        }
        //cookedFood
        if UserDefaults.standard.bool(forKey: "crownCookedFoodBool") {
            if !UserDefaults.standard.bool(forKey: "isFirstSpawnCrownCookedFood") {
                animationReward()
                playConfirmationSound()
                crownCookedFoodImage.isHidden = false
                crownCookedFoodImage.pulsate()
            } else {
                crownCookedFoodImage.isHidden = false
            }
            UserDefaults.standard.set(true, forKey: "isFirstSpawnCrownCookedFood")
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
            positY = -540
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -503
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -440
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -500
        } else if totalSize.height <= 670 {
            positY = -398
        } else {
            positY = -395
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
