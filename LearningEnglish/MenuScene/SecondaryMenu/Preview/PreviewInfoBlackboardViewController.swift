//
//  PreviewInfoBlackboardViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 14.04.2022.
//

import UIKit
import SnapKit
import Lottie
import AVFoundation

class PreviewInfoBlackboardViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    let animationGirlViewOne = AnimationView(name: "basicGirlWait2")
    let animationGirlViewTwo = AnimationView(name: "basicGirlPreviewFour")
    
    var player: AVAudioPlayer?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "isSecondPressButtonNextEngLvlv")
        UserDefaults.standard.set(false, forKey: "isFirstPressButtonNextEngLvl")

        backgroundShadowImage.isHidden = false
        
        labelPreviewOne.isHidden = false
        labelPreviewTwo.isHidden = false
        beginnerLabel.isHidden = false
        beginnerNumberLabel.isHidden = false
        
        beginnerInfoButton.addTarget(self, action: #selector(beginnerInfoButtonAction(sender:)), for: .touchUpInside)
        
        animationGirlOne()
        animationGirlTwo()
        
        nextButton.addTarget(self, action: #selector(nextButtonAction(sender:)), for: .touchUpInside)
        
        
        var positY: CGFloat!
        if self.totalSize.height >= 920 {
            positY = 920
        } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
            positY = 920
        } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
            positY = 920
        } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
            positY = 920
        } else if self.totalSize.height <= 670 {
            positY = 940
        } else {
            positY = 920
        }
        mainView.transform = CGAffineTransform(translationX: 0, y: positY)
        
        
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
    lazy var labelPreviewOne: UIImageView = {
        
        var nameImg = "labelPreviewEngLvl"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewEngLvl"
        case "tr":
            nameImg = "labelPreviewEngLvlTR"
        case "es":
            nameImg = "labelPreviewEngLvlES"
        default:
            nameImg = "labelPreviewEngLvl"
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
            positX = -80
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
    
    lazy var labelPreviewTwo: UIImageView = {
        
        var nameImg = "labelPreviewTwoEngLvl"
        switch Locale.current.languageCode {
        case "ru":
            nameImg = "labelPreviewTwoEngLvl"
        case "tr":
            nameImg = "labelPreviewTwoEngLvlTR"
        case "es":
            nameImg = "labelPreviewTwoEngLvlES"
        default:
            nameImg = "labelPreviewTwoEngLvl"
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
            positX = 50
            positY = 110
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 230
            positX = 50
            positY = 100
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 230
            positX = 60
            positY = 100
        } else if totalSize.height <= 670 {
            wdth = 210
            positX = 60
            positY = 100
        } else {
            wdth = 230
            positX = 50
            positY = 110
        }
        
        img.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        return img
    }()
    
//MARK: - LabelBeginner
    lazy var mainView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.width.height.equalTo(900)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-900)
        }
        
        return vi
    }()
    
    lazy var beginnerLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.0
        self.view.addSubview(vi)
        mainView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(500)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-300)
        }
        
        return vi
    }()
    
    lazy var beginnerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: 30)
        lbl.text = "A1 - Beginner"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        beginnerLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(0)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var beginnerNumberLabel: UILabel = {
        var fontName = "Lorjuk"
        var fontSize: CGFloat!
        
        switch Locale.current.languageCode {
        case "es":
            fontName = "Lorjuk"
            fontSize = 26
        default:
            fontName = "lcChalk"
            fontSize = 18
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "до 1500 слов".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        beginnerLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var beginnerInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrowDownButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        beginnerLabelView.addSubview(btn)
        
        var positX: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            positX = 115
        case "tr":
            positX = 130
        case "es":
            positX = 130
        default:
            positX = 115
        }
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(positX)
        }
        
        return btn
    }()
    
    @objc func beginnerInfoButtonAction(sender: UIButton) {
       
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
        
        if !UserDefaults.standard.bool(forKey: "isFirstPressButtonNextEngLvl") {
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
                        self.beginnerLabelView.alpha = 1
                        self.animationGirlViewTwo.alpha = 1
                    })
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.labelPreviewTwo.alpha = 1
                            self.playConfirmationSound()
                        })
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                            UIView.animate(withDuration: 0.4, animations: {
                                self.nextButton.alpha = 1
                            })
                        }
                    }
                }
                
            }
        } else {
            if !UserDefaults.standard.bool(forKey: "isSecondPressButtonNextEngLvlv") {
                sender.zoomOut()
                UIView.animate(withDuration: 0.4, animations: {
                    self.nextButton.alpha = 0
                    self.labelPreviewTwo.alpha = 0
                })
                
    
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                    UIView.animate(withDuration: 0.4, animations: {
                        self.animationGirlViewTwo.alpha = 0
                    })
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                        sender.zoomIn()
                        self.animationGirlViewTwo.isHidden = true
                        
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                                self.dismiss(animated: true, completion: nil)
                            }
//                        }
                    }
                }
            }
            UserDefaults.standard.set(true, forKey: "isSecondPressButtonNextEngLvlv")
        }
        UserDefaults.standard.set(true, forKey: "isFirstPressButtonNextEngLvl")
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
        if totalSize.height >= 920 {
            wdth = 310
            positX = 0
            positY = -110
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 310
            positX = 0
            positY = -110
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 300
            positX = 10
            positY = -110
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 300
            positX = 10
            positY = -110
        } else if totalSize.height <= 670 {
            wdth = 280
            positX = 10
            positY = -100
        } else {
            wdth = 280
            positX = 20
            positY = -110
        }
        
        animationGirlViewTwo.snp.makeConstraints { make in
            make.width.height.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        animationGirlViewTwo.play()
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
