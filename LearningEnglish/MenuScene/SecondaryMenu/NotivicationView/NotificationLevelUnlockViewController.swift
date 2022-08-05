//
//  NotificationLevelUnlockViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 12.03.2022.
//

import UIKit
import AVFoundation
import Lottie

class NotificationLevelUnlockViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    var playerTwo: AVAudioPlayer?
    var playerThree: AVAudioPlayer?
    
    let labelName = UserDefaults.standard.string(forKey: "whichLevelUnlocked")
    var labelText: String!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playConfirmationTwoSound()
        
        updateLabelText()
        spawnNotification()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.animationConfetti()
            self.animationBalloons()
            self.animationPerson()
        }
    }
    
    func updateLabelText() {
        if labelName == "timeLvl" {
            labelText = "“Время“".localized()
        } else if labelName == "personLvl" {
            labelText = "“Человек“".localized()
        } else if labelName == "foodLvl" {
            labelText = "“Еда“".localized()
        }
    }
//MARK: - Notification
    lazy var notificationView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(-100)
            make.width.height.equalTo(500)
        }
        
        return vi
    }()
    
//MARK: - Background
    lazy var notificationBackgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "notificationBackgroundHoliday"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0.4052956403, blue: 0.5570840737, alpha: 1)
        img.layer.shadowRadius = 20
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.6
        self.view.addSubview(img)
        notificationView.addSubview(img)
        
        let wdth: CGFloat!
        if totalSize.height >= 830  {
            wdth = 550
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 550
        } else if totalSize.height <= 670 {
            wdth = 520
        } else {
            wdth = 530
        }
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(wdth)
        }
        
        return img
    }()
    
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
//MARK: Label
    lazy var mainLabel: UILabel = {
        
        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 14
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 23
        case "es":
            fontName = "hodgepodgery"
            fontSize = 23
        default:
            fontName = "dsEraserCyr"
            fontSize = 14
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "раздел открыт".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        notificationView.addSubview(lbl)
        
        var positY: CGFloat!
        if totalSize.height <= 670 {
            positY = -5
        } else {
            positY = -7
        }
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    
    lazy var subLabel: UILabel = {
        
        var fontName = "dsEraserCyr"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "ru":
            fontName = "dsEraserCyr"
            fontSize = 24
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 35
        case "es":
            fontName = "hodgepodgery"
            fontSize = 35
        default:
            fontName = "dsEraserCyr"
            fontSize = 24
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = labelText
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        notificationView.addSubview(lbl)
        
        var positY: CGFloat!
        if totalSize.height <= 670 {
            positY = -31
        } else {
            positY = -33
        }
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(positY)
        }
        
        return lbl
    }()
    
//MARK: - LookButton
    lazy var lookButton: UIButton = {
        
        var imgName = "tabletLook"
        switch Locale.current.languageCode {
        case "ru":
            imgName = "tabletLook"
        case "tr":
            imgName = "tabletLookTR"
        case "es":
            imgName = "tabletLookES"
        default:
            imgName = "tabletLook"
        }
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.4
        self.view.addSubview(btn)
        notificationView.addSubview(btn)

        var positY: CGFloat!
        if totalSize.height <= 670 {
            positY = 39
        } else {
            positY = 42
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(44)
        }

        return btn
    }()
    @objc func lookButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundShadowImage.alpha = 0
        })

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lookNewLevel"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//MARK: - CloseButton
    lazy var closeButton: UIButton = {
        
        var imgName = "tabletClose"
        switch Locale.current.languageCode {
        case "ru":
            imgName = "tabletClose"
        case "tr":
            imgName = "tabletCloseTR"
        case "es":
            imgName = "tabletCloseES"
        default:
            imgName = "tabletClose"
        }
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        self.view.addSubview(btn)
        notificationView.addSubview(btn)

        var positY: CGFloat!
        if totalSize.height <= 670 {
            positY = 92
        } else {
            positY = 96
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(30)
        }

        return btn
    }()
    @objc func closeButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func spawnNotification() {
        backgroundShadowImage.isHidden = false
        notificationBackgroundImage.isHidden = false
        mainLabel.isHidden = false
        subLabel.isHidden = false
        closeButton.addTarget(self, action: #selector(closeButtonAction(sender:)), for: .touchUpInside)
        lookButton.addTarget(self, action: #selector(lookButtonAction(sender:)), for: .touchUpInside)
        
    }
    
//MARK: - AnimationConfetti
    func animationConfetti() {
        let animationView = AnimationView(name: "confettiNotification")
        animationView.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        self.view.addSubview(animationView)
        notificationView.addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(550)
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(-50)
        }
        
        animationView.play { (finished) in
            animationView.isHidden = true
        }
        
        //Two
        let animationViewTwo = AnimationView(name: "confettiNotificationTwo")
        animationViewTwo.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationViewTwo.contentMode = .scaleAspectFit
        animationViewTwo.loopMode = .playOnce
        self.view.addSubview(animationViewTwo)
        notificationView.addSubview(animationViewTwo)
        
        animationViewTwo.snp.makeConstraints { make in
            make.width.height.equalTo(130)
            make.centerXWithinMargins.equalTo(180)
            make.centerYWithinMargins.equalTo(90)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
            self.playConfettiSound()
            animationViewTwo.play { (finished) in
                animationViewTwo.isHidden = true
            }
        }
        
        //Three
        let animationViewThree = AnimationView(name: "confettiNotificationTwo")
        animationViewThree.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationViewThree.contentMode = .scaleAspectFit
        animationViewThree.loopMode = .playOnce
        animationViewThree.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.view.addSubview(animationViewThree)
        notificationView.addSubview(animationViewThree)
        
        animationViewThree.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.centerXWithinMargins.equalTo(-160)
            make.centerYWithinMargins.equalTo(70)
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
                self.playConfettiSound()
            }
            animationViewThree.play { (finished) in
                animationViewThree.isHidden = true
            }
        }
    }
//MARK: - Balloons
    func animationBalloons() {
        let animationBalloonsView = AnimationView(name: "balloons")
        animationBalloonsView.contentMode = .scaleAspectFit
        animationBalloonsView.loopMode = .playOnce
        animationBalloonsView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationBalloonsView.layer.shadowRadius = 12
        animationBalloonsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationBalloonsView.layer.shadowOpacity = 0.4
        animationBalloonsView.transform = CGAffineTransform(rotationAngle: CGFloat(0.4))
        self.view.addSubview(animationBalloonsView)
        notificationView.addSubview(animationBalloonsView)
        
            animationBalloonsView.snp.makeConstraints { make in
                make.width.height.equalTo(130)
                make.centerXWithinMargins.equalTo(140)
                make.centerYWithinMargins.equalTo(-70)
            }
        
        animationBalloonsView.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
            animationBalloonsView.isHidden = false
            animationBalloonsView.play()
        }
        //TwoBalloons
        let animationBalloonsViewTwo = AnimationView(name: "balloons")
        animationBalloonsViewTwo.contentMode = .scaleAspectFit
        animationBalloonsViewTwo.loopMode = .playOnce
        animationBalloonsViewTwo.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationBalloonsViewTwo.layer.shadowRadius = 12
        animationBalloonsViewTwo.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationBalloonsViewTwo.layer.shadowOpacity = 0.4
        animationBalloonsViewTwo.transform = CGAffineTransform(rotationAngle: CGFloat(-0.2))
        self.view.addSubview(animationBalloonsViewTwo)
        notificationView.addSubview(animationBalloonsViewTwo)
        
        animationBalloonsViewTwo.snp.makeConstraints { make in
            make.width.height.equalTo(180)
            make.centerXWithinMargins.equalTo(-100)
            make.centerYWithinMargins.equalTo(-110)
        }
        
        animationBalloonsViewTwo.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {_ in
            animationBalloonsViewTwo.isHidden = false
            animationBalloonsViewTwo.play()
        }
    }
    
//MARK: - AnimationPerson
    func animationPerson() {
        let animationView = AnimationView(name: "personWin")
        animationView.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 600)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        animationView.layer.shadowRadius = 7
        animationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animationView.layer.shadowOpacity = 0.3
        self.view.addSubview(animationView)
        
        var wdth: CGFloat!
        var positX: CGFloat!
        var positY: CGFloat!
        if totalSize.height >= 920 {
            wdth = 350
            positX = 100
            positY = 270
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            wdth = 340
            positX = 100
            positY = 260
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            positX = 90
            positY = 250
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 330
            positX = 100
            positY = 230
        } else if totalSize.height <= 670 {
            wdth = 310
            positX = 100
            positY = 210
        } else {
            wdth = 340
            positX = 100
            positY = 240
        }
        
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            animationView.play { (finished) in
                animationView.pause()
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
    
    func playConfirmationTwoSound() {
        guard let path = Bundle.main.path(forResource: "confirmationTwo", ofType:"wav") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            playerTwo = try AVAudioPlayer(contentsOf: url)
            playerTwo?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playConfettiSound() {
        guard let path = Bundle.main.path(forResource: "confettiSound", ofType:"wav") else {
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

