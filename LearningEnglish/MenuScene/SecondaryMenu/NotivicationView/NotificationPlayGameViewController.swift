//
//  NotificationPlayGameViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 15.01.2022.
//

import UIKit
import AVFoundation

class NotificationPlayGameViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    
    let labelName = UserDefaults.standard.string(forKey: "dictionaryName")
    var labelText: String!
    
    var reverseBool: Bool = false
    var gameScene: String!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabelText()
        
        spawnNotification()
        
        //notification
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationPlayGameViewController.refresh), name: NSNotification.Name(rawValue: "gameTheEnd"), object: nil)
    }
    
    @objc func refresh() {
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func spawnNotification() {
        notificationBackgroundImage.isHidden = false
        mainLabel.isHidden = false
        playGameButton.addTarget(self, action: #selector(playGameButtonAction(sender:)), for: .touchUpInside)
        
        if !reverseBool {
            gameScene = "GameViewController"
            playTrainingGameButton.addTarget(self, action: #selector(playTrainingGameButtonAction(sender:)), for: .touchUpInside)
        } else {
            gameScene = "GameReverseViewController"
            reverseImage.isHidden = false
        }
        
        closeNotificationButton.addTarget(self, action: #selector(closeNotificationButtonAction(sender:)), for: .touchUpInside)
    }
    
    func updateLabelText() {
        if labelName == "iYou" {
            labelText = "Местоимения".localized()
        } else if labelName == "iYouComplex" {
            labelText = "Местоимения".localized()
        } else if labelName == "hello" {
            labelText = "Этикет".localized()
        } else if labelName == "question" {
            labelText = "Вопросы".localized()
        } else if labelName == "color" {
            labelText = "Цвета".localized()
        } else if labelName == "geometricShape" {
            labelText = "Геометрические \n\nФигуры".localized()
        } else if labelName == "number" {
            labelText = "Числа".localized()
        } else if labelName == "numberComplex" {
            labelText = "Числа".localized()
        } else if labelName == "unitsOfTime" {
            labelText = "Единицы \n \nвремени".localized()
        } else if labelName == "monthSeason" {
            labelText = "Месяцы \n \nи сезоны".localized()
        } else if labelName == "day" {
            labelText = "День".localized()
        } else if labelName == "timePeriods" {
            labelText = "Интервалы \n \nвремени".localized()
        } else if labelName == "person" {
            labelText = "Общее".localized()
        } else if labelName == "family" {
            labelText = "Семья".localized()
        } else if labelName == "body" {
            labelText = "Тело".localized()
        } else if labelName == "feelings" {
            labelText = "Чувства и \n \nэмоции".localized()
        } else if labelName == "appearance" {
            labelText = "Внешность".localized()
        } else if labelName == "aboutFood" {
            labelText = "Про еду \n \nи вкус".localized()
        } else if labelName == "drink" {
            labelText = "Напитки".localized()
        } else if labelName == "drinkReverse" {
            labelText = "Напитки".localized()
            reverseBool = true
        } else if labelName == "milk" {
            labelText = "Молочные \n \nпродукты".localized()
        } else if labelName == "milkReverse" {
            labelText = "Молочные \n \nпродукты".localized()
            reverseBool = true
        } else if labelName == "vegetable" {
            labelText = "Овощи".localized()
        } else if labelName == "fruit" {
            labelText = "Фрукты".localized()
        } else if labelName == "nut" {
            labelText = "Орехи и \n \nCухофрукты".localized()
        } else if labelName == "meat" {
            labelText = "Мясо, рыба и \n \nморепродукты".localized()
        } else if labelName == "products" {
            labelText = "Прочие \n \nпродукты".localized()
        } else if labelName == "productsReverse" {
            labelText = "Прочие \n \nпродукты".localized()
            reverseBool = true
        } else if labelName == "sweets" {
            labelText = "Сладости".localized()
        } else if labelName == "cookedFood" {
            labelText = "Готовая еда".localized()
        }
    }
//MARK: - Notification
    lazy var notificationView: UIView = {
        let vi = UIView()
        self.view.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
        
        return vi
    }()
//MARK: Background
    lazy var notificationBackgroundImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "notificationBackground"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        notificationView.addSubview(img)
        
        let wdth: CGFloat!
        if totalSize.height >= 830  {
            wdth = 340
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 340
        } else if totalSize.height <= 670 {
            wdth = 310
        } else {
            wdth = 320
        }
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(wdth)
        }
        
        return img
    }()
    
    lazy var reverseImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "reverse"))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 5
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.3
//        img.alpha = 0.6
        self.view.addSubview(img)
        notificationView.addSubview(img)
        
        var positY: CGFloat!
        var positX: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 830  {
            positY = 95
            positX = 135
            wdth = 55
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 95
            positX = 135
            wdth = 55
        } else if totalSize.height <= 670 {
            positY = 87
            positX = 122
            wdth = 47
        } else {
            positY = 87
            positX = 125
            wdth = 47
        }

        img.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(wdth)
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
            fontSize = 17
        case "tr":
            fontName = "hodgepodgery"
            fontSize = 28
        case "es":
            fontName = "hodgepodgery"
            fontSize = 28
        default:
            fontName = "dsEraserCyr"
            fontSize = 17
        }
        
        let lbl = UILabel()
        lbl.text = labelText
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.shadowRadius = 6
        lbl.layer.shadowOffset = CGSize(width: 0, height: 0)
        lbl.layer.shadowOpacity = 0.3
        notificationView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-45)
        }
        
        return lbl
    }()
//MARK: PlayButton
    lazy var playGameButton: UIButton = {
        
        var imgName = "tabletPassLevel"
        switch Locale.current.languageCode {
        case "ru":
            imgName = "tabletPassLevel"
        case "tr":
            imgName = "tabletPassLevelTR"
        case "es":
            imgName = "tabletPassLevelES"
        default:
            imgName = "tabletPassLevel"
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
            
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(20)
            make.height.equalTo(43)
        }
        
        return btn
    }()
    @objc func playGameButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                sender.zoomOutClose()
            }
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = mainStoryboard.instantiateViewController(withIdentifier: self.gameScene)

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
//MARK: TrainingButton
    lazy var playTrainingGameButton: UIButton = {
        
        var imgName = "tabletTrainingGame"
        switch Locale.current.languageCode {
        case "ru":
            imgName = "tabletTrainingGame"
        case "tr":
            imgName = "tabletTrainingGameTR"
        case "es":
            imgName = "tabletTrainingGameES"
        default:
            imgName = "tabletTrainingGame"
        }
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.adjustsImageWhenHighlighted = false
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.alpha = 0.9
        self.view.addSubview(btn)
        notificationView.addSubview(btn)
        
        let positY: CGFloat!
        if totalSize.height <= 670 {
            positY = 77
        } else {
            if !reverseBool {
                positY = 85
            } else {
                positY = 140
            }
            
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(0)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(40)
        }
        
        return btn
    }()
    @objc func playTrainingGameButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                sender.zoomOutClose()
            }
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "TrainingViewController")

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
//MARK: CloseButton
    lazy var closeNotificationButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeWhiteButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0, height: 0)
        btn.layer.shadowOpacity = 0.3
        btn.alpha = 0.8
        self.view.addSubview(btn)
        notificationView.addSubview(btn)
        
        let positX: CGFloat!
        let positY: CGFloat!
        if totalSize.height >= 830  {
            positX = 145
            positY = -70
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positX = 145
            positY = -70
        } else if totalSize.height <= 670 {
            positX = 135
            positY = -60
        } else {
            positX = 138
            positY = -63
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        return btn
    }()
    @objc func closeNotificationButtonAction(sender: UIButton) {
        sender.zoomOut()
        playPressSound()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
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
}
