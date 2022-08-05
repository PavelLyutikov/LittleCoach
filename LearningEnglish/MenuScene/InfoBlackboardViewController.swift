//
//  InfoBlackboardViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 12.04.2022.
//

import UIKit
import SnapKit
import AVFoundation

class InfoBlackboardViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    
    var totalWordsLearned = UserDefaults.standard.integer(forKey: "totalWordsLearned")
    
    var meaningAlphaBeginner = 0.4
    var meaningAlphaElementary = 0.4
    var meaningAlphaIntermediate = 0.4
    var meaningAlphaUpIntermediate = 0.4
    var meaningAlphaAdvanced = 0.4
    var meaningAlphaProficiency = 0.4
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "firstPressButton")
        
        backgroundShadowImage.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.3, animations: {
                self.backgroundShadowImage.alpha = 0.7
            })
        }
        
        blackboardInfo.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
            
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
            UIView.animate(withDuration: 0.6, animations: {
                self.mainView.transform = CGAffineTransform(translationX: 0, y: positY)
            })
        }
        
        
        beginnerLabel.isHidden = false
        beginnerNumberLabel.isHidden = false
        beginnerInfoLabel.isHidden = false
        beginnerInfoButton.addTarget(self, action: #selector(beginnerInfoButtonAction(sender:)), for: .touchUpInside)
        
        elementaryLabel.isHidden = false
        elementaryNumberLabel.isHidden = false
        elementaryInfoLabel.isHidden = false
        elementaryInfoButton.addTarget(self, action: #selector(elementaryInfoButtonAction(sender:)), for: .touchUpInside)
        
        intermediateLabel.isHidden = false
        intermediateNumberLabel.isHidden = false
        intermediateInfoLabel.isHidden = false
        intermediateInfoButton.addTarget(self, action: #selector(intermediateInfoButtonAction(sender:)), for: .touchUpInside)
        
        upIntermediateLabel.isHidden = false
        upIntermediateNumberLabel.isHidden = false
        upIntermediateInfoLabel.isHidden = false
        upIntermediateInfoButton.addTarget(self, action: #selector(upIntermediateInfoButtonAction(sender:)), for: .touchUpInside)
        
        advancedLabel.isHidden = false
        advancedNumberLabel.isHidden = false
        advancedInfoLabel.isHidden = false
        advancedInfoButton.addTarget(self, action: #selector(advancedInfoButtonAction(sender:)), for: .touchUpInside)
        
        proficiencyLabel.isHidden = false
        proficiencyNumberLabel.isHidden = false
        proficiencyInfoLabel.isHidden = false
        proficiencyInfoButton.addTarget(self, action: #selector(proficiencyInfoButtonAction(sender:)), for: .touchUpInside)
        
        
        dismissButton.addTarget(self, action: #selector(dismissButtonAction(sender:)), for: .touchUpInside)
        
        chekingNumberOfWords()
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            if !UserDefaults.standard.bool(forKey: "isFirstOpeningEnglishLevelViewController") {
                
                let vc = PreviewInfoBlackboardViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                let transition = CATransition()
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.present(vc, animated: true, completion: nil)
                
                UserDefaults.standard.set(true, forKey: "isFirstOpeningEnglishLevelViewController")
            }
        }
    }
//MARK: BackgroundShadow
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
//MARK: - ChekWords
    func chekingNumberOfWords() {
        
        var fontName = "lcChalk"
        var fontSize: CGFloat!
        
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
            fontSize = 18
        case "tr":
            fontName = "lcChalk"
            fontSize = 18
        case "es":
            fontName = "Lorjuk"
            fontSize = 26
        default:
            fontName = "lcChalk"
            fontSize = 18
        }
        
        if totalWordsLearned <= 1500 {
            beginnerLabelView.alpha = 1
            
            beginnerLabel.font = UIFont(name: "appleberry", size: 30)
            beginnerNumberLabel.font = UIFont(name: fontName, size: fontSize)
            
            meaningAlphaBeginner = 1
        } else if totalWordsLearned >= 1501 && totalWordsLearned <= 2500 {
            elementaryLabelView.alpha = 1
            
            elementaryLabel.font = UIFont(name: "appleberry", size: 30)
            elementaryNumberLabel.font = UIFont(name: fontName, size: fontSize)
            
            meaningAlphaElementary = 1
        } else if totalWordsLearned >= 2501 && totalWordsLearned <= 3200 {
            intermediateLabelView.alpha = 1
            
            intermediateLabel.font = UIFont(name: "appleberry", size: 30)
            intermediateNumberLabel.font = UIFont(name: fontName, size: fontSize)
            
            meaningAlphaIntermediate = 1
        } else if totalWordsLearned >= 3201 && totalWordsLearned <= 3700 {
            upIntermediateLabelView.alpha = 1
            
            upIntermediateLabel.font = UIFont(name: "appleberry", size: 30)
            upIntermediateNumberLabel.font = UIFont(name: fontName, size: fontSize)
            
            meaningAlphaUpIntermediate = 1
        } else if totalWordsLearned >= 3701 && totalWordsLearned <= 4500 {
            advancedLabelView.alpha = 1
            
            advancedLabel.font = UIFont(name: "appleberry", size: 30)
            advancedNumberLabel.font = UIFont(name: fontName, size: fontSize)
            
            meaningAlphaAdvanced = 1
        } else if totalWordsLearned >= 4500 {
            proficiencyLabelView.alpha = 1
            
            proficiencyLabel.font = UIFont(name: "appleberry", size: 30)
            proficiencyNumberLabel.font = UIFont(name: fontName, size: fontSize)
            
            meaningAlphaProficiency = 1
        }
    }
    
//MARK: - Blackboard
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
    
    lazy var blackboardInfo: UIImageView = {
        let txt: String!
        if totalSize.height >= 671 && totalSize.height <= 800 {
            txt = "blackboardInfoIP8"
        } else if totalSize.height <= 670 {
            txt = "blackboardInfoIP8"
        } else {
            txt = "blackboardInfo"
        }
        
        let img = UIImageView(image: UIImage(named: txt))
        img.contentMode = .scaleAspectFit
        img.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.shadowRadius = 8
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.shadowOpacity = 0.5
        self.view.addSubview(img)
        mainView.addSubview(img)
        
        let wdth = totalSize.width - 5
        
        var positY: CGFloat!
        if totalSize.height >= 920 {
            positY = 0
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = 0
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = 0
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = 0
        } else  if totalSize.height <= 670 {
            positY = -20
        } else {
            positY = 0
        }
        
        img.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(positY)
            make.centerX.equalToSuperview()
            make.width.equalTo(wdth)
        }
        
        return img
    }()
    
//MARK: - LabelBeginner
    lazy var beginnerLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.4
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
        lbl.font = UIFont(name: "appleberry", size: 25)
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
            fontSize = 23
        default:
            fontName = "lcChalk"
            fontSize = 15
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
    
    lazy var beginnerInfoLabel: UILabel = {
        
        var txtSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            txtSz = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height <= 670 {
            wdth = 330
            txtSz = 14
        } else {
            wdth = 330
            txtSz = 15
        }
        
    //Locate
        var fontName = "lcChalk"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
        case "tr":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        case "es":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        default:
            fontName = "lcChalk"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: txtSz)
        lbl.text = "Breakthrough or beginner. \n\n Начальный уровень английского языка. Вы можете: \n\n   -понимать основные фразы и использовать повседневные выражения; \n\n   -самостоятельно представляться на английском и представить других; \n\n   -задавать элементарные вопросы на личные темы и отвечать на них; \n\n   -взаимодействовать на базовом уровне английского языка; \n\n   -понимать очень короткие надписи.".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.alpha = 0
        self.view.addSubview(lbl)
        beginnerLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(320)
            make.centerXWithinMargins.equalTo(0)
            make.width.equalTo(wdth)
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
        
        playPressSound()
        
        if !UserDefaults.standard.bool(forKey: "firstPressButton") {
            beginnerInfoButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.elementaryLabelView.alpha = 0
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.intermediateLabelView.alpha = 0
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.upIntermediateLabelView.alpha = 0
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.advancedLabelView.alpha = 0
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.proficiencyLabelView.alpha = 0
                
                self.beginnerLabelView.alpha = 1
                self.beginnerInfoLabel.alpha = 1
                self.dismissButton.alpha = 0
            })
            UserDefaults.standard.set(true, forKey: "firstPressButton")
        } else {
            beginnerInfoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                
                self.beginnerLabelView.alpha = self.meaningAlphaBeginner
                self.beginnerInfoLabel.alpha = 0
                self.dismissButton.alpha = 1
            })
            UserDefaults.standard.set(false, forKey: "firstPressButton")
        }
    }
    
//MARK: - LabelElementary
    lazy var elementaryLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.4
        self.view.addSubview(vi)
        mainView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(500)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-200)
        }
        
        return vi
    }()
    
    lazy var elementaryLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: 25)
        lbl.text = "A2 - Elementary"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        elementaryLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(0)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var elementaryNumberLabel: UILabel = {
        var fontName = "Lorjuk"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "es":
            fontName = "Lorjuk"
            fontSize = 23
        default:
            fontName = "lcChalk"
            fontSize = 15
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "1500-2500 слов".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        elementaryLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var elementaryInfoLabel: UILabel = {
        
        var txtSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            txtSz = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height <= 670 {
            wdth = 330
            txtSz = 14
        } else {
            wdth = 330
            txtSz = 15
        }
        
    //Locate
        var fontName = "lcChalk"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
        case "tr":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        case "es":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        default:
            fontName = "lcChalk"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: txtSz)
        lbl.text = "Way stage or elementary. \n\n Элементарный уровень английского языка. Вы можете: \n\n -понимать фразы, относящиеся к насущным аспектам жизни; \n\n -спросить дорогу и понять ответ; \n\n -рассказать о себе, выразить свои базовые потребности; \n\n -понять суть  видео на английском; \n\n -прочесть и понять элементарный текст на английском языке.".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.alpha = 0
        self.view.addSubview(lbl)
        elementaryLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(320)
            make.centerXWithinMargins.equalTo(0)
            make.width.equalTo(wdth)
        }
        
        return lbl
    }()
    
    lazy var elementaryInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrowDownButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        elementaryLabelView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(140)
        }
        
        return btn
    }()
    
    @objc func elementaryInfoButtonAction(sender: UIButton) {
        
        playPressSound()
        
        if !UserDefaults.standard.bool(forKey: "firstPressButton") {
            elementaryInfoButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.beginnerLabelView.alpha = 0
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.intermediateLabelView.alpha = 0
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.upIntermediateLabelView.alpha = 0
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.advancedLabelView.alpha = 0
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.proficiencyLabelView.alpha = 0
                
                self.elementaryLabelView.alpha = 1
                self.elementaryInfoLabel.alpha = 1
                self.dismissButton.alpha = 0
            })
            UserDefaults.standard.set(true, forKey: "firstPressButton")
        } else {
            elementaryInfoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.beginnerLabelView.alpha = self.meaningAlphaBeginner
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.elementaryInfoLabel.alpha = 0
                self.dismissButton.alpha = 1
            })
            UserDefaults.standard.set(false, forKey: "firstPressButton")
        }
    }
    
//MARK: - LabelIntermediate
    lazy var intermediateLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.4
        self.view.addSubview(vi)
        mainView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(500)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(-100)
        }
        
        return vi
    }()
    
    lazy var intermediateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: 23)
        lbl.text = "B1 - Intermediate"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        intermediateLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(0)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var intermediateNumberLabel: UILabel = {
        var fontName = "Lorjuk"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "es":
            fontName = "Lorjuk"
            fontSize = 23
        default:
            fontName = "lcChalk"
            fontSize = 15
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "2500-3200 слов".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        intermediateLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var intermediateInfoLabel: UILabel = {
        
        var txtSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            txtSz = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height <= 670 {
            wdth = 330
            txtSz = 14
        } else {
            wdth = 330
            txtSz = 15
        }
        
    //Locate
        var fontName = "lcChalk"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
        case "tr":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        case "es":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        default:
            fontName = "lcChalk"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: txtSz)
        lbl.text = "Threshold or intermediate. \n\n Cредний уровень английского языка. Вы можете: \n\n -правильно понимать суть высказываний на знакомые вам темы; \n\n -описать впечатления, мысли, эмоции, изложить свое мнение; \n\n -смотреть англоязычные фильмы в оригинале, иногда догадываясь о происходящем по изображению; \n\n -прочесть простейшую инструкцию, брошюру, письмо; \n\n -написать связное сообщение, на знакомую или интересную вам тематику.".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.alpha = 0
        self.view.addSubview(lbl)
        intermediateLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(320)
            make.centerXWithinMargins.equalTo(0)
            make.width.equalTo(wdth)
        }
        
        return lbl
    }()
    
    lazy var intermediateInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrowDownButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        intermediateLabelView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(140)
        }
        
        return btn
    }()
    
    @objc func intermediateInfoButtonAction(sender: UIButton) {
        
        playPressSound()
        
        if !UserDefaults.standard.bool(forKey: "firstPressButton") {
            intermediateInfoButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.beginnerLabelView.alpha = 0
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.elementaryLabelView.alpha = 0
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -200)
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.upIntermediateLabelView.alpha = 0
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.advancedLabelView.alpha = 0
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.proficiencyLabelView.alpha = 0
                
                self.intermediateLabelView.alpha = 1
                self.intermediateInfoLabel.alpha = 1
                self.dismissButton.alpha = 0
            })
            UserDefaults.standard.set(true, forKey: "firstPressButton")
        } else {
            intermediateInfoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.beginnerLabelView.alpha = self.meaningAlphaBeginner
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.intermediateInfoLabel.alpha = 0
                self.dismissButton.alpha = 1
            })
            UserDefaults.standard.set(false, forKey: "firstPressButton")
        }
    }
    
//MARK: - LabelUpper-Intermediate
    lazy var upIntermediateLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.4
        self.view.addSubview(vi)
        mainView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(500)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(0)
        }
        
        return vi
    }()
    
    lazy var upIntermediateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: 23)
        lbl.text = "B2 - Upper Intermediate"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        upIntermediateLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(0)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var upIntermediateNumberLabel: UILabel = {
        var fontName = "Lorjuk"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "es":
            fontName = "Lorjuk"
            fontSize = 23
        default:
            fontName = "lcChalk"
            fontSize = 15
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "3200-3700 слов".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        upIntermediateLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var upIntermediateInfoLabel: UILabel = {
        
        var txtSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            txtSz = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height <= 670 {
            wdth = 330
            txtSz = 14
        } else {
            wdth = 330
            txtSz = 15
        }
        
    //Locate
        var fontName = "lcChalk"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
        case "tr":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        case "es":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        default:
            fontName = "lcChalk"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: txtSz)
        lbl.text = "Vantage or upper intermediate. \n\n Cредне-продвинутый уровень английского языка. Вы можете: \n\n -понять суть сложного текста, поддержать беседу на английском языке; \n\n -свободно общаться на английском на отвлеченные темы; \n\n -изложить свой взгляд на проблему, указать на преимущества и недостатки различных вариантов ее решения; \n\n -смотреть большинство англоязычных телепрограмм; \n\n -написать связное сообщение на незнакомую вам тематику.".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.alpha = 0
        self.view.addSubview(lbl)
        upIntermediateLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(320)
            make.centerXWithinMargins.equalTo(0)
            make.width.equalTo(wdth)
        }
        
        return lbl
    }()
    
    lazy var upIntermediateInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrowDownButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        upIntermediateLabelView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(140)
        }
        
        return btn
    }()
    
    @objc func upIntermediateInfoButtonAction(sender: UIButton) {
        
        playPressSound()
        
        if !UserDefaults.standard.bool(forKey: "firstPressButton") {
            upIntermediateInfoButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.beginnerLabelView.alpha = 0
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.elementaryLabelView.alpha = 0
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.intermediateLabelView.alpha = 0
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -300)
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.advancedLabelView.alpha = 0
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.proficiencyLabelView.alpha = 0
                
                self.upIntermediateLabelView.alpha = 1
                self.upIntermediateInfoLabel.alpha = 1
                self.dismissButton.alpha = 0
            })
            UserDefaults.standard.set(true, forKey: "firstPressButton")
        } else {
            upIntermediateInfoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.beginnerLabelView.alpha = self.meaningAlphaBeginner
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.upIntermediateInfoLabel.alpha = 0
                self.dismissButton.alpha = 1
            })
            UserDefaults.standard.set(false, forKey: "firstPressButton")
        }
    }
    
//MARK: - LabelAdvanced
    lazy var advancedLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.4
        self.view.addSubview(vi)
        mainView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(500)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(100)
        }
        
        return vi
    }()
    
    lazy var advancedLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: 23)
        lbl.text = "C1 - Advanced"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        advancedLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(0)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var advancedNumberLabel: UILabel = {
        var fontName = "Lorjuk"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "es":
            fontName = "Lorjuk"
            fontSize = 23
        default:
            fontName = "lcChalk"
            fontSize = 15
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "3700-4500 слов".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        advancedLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var advancedInfoLabel: UILabel = {
        
        var txtSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            txtSz = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height <= 670 {
            wdth = 330
            txtSz = 14
        } else {
            wdth = 330
            txtSz = 15
        }
        
    //Locate
        var fontName = "lcChalk"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
        case "tr":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        case "es":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        default:
            fontName = "lcChalk"
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: txtSz)
        lbl.text = "Effective operational proficiency or advanced. \n\n Продвинутый уровень английского языка. Вы можете: \n\n -понять сложные и длинные тексты на самые разные темы; \n\n -изъясняться свободно, без затруднений с подбором слов и выражений; \n\n -понимать фильмы на английском, включая сленг и идиомы; \n\n -писать подробные тексты на сложные темы; \n\n -поддерживать эффективную переписку на английском.".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.alpha = 0
        self.view.addSubview(lbl)
        advancedLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(320)
            make.centerXWithinMargins.equalTo(0)
            make.width.equalTo(wdth)
        }
        
        return lbl
    }()
    
    lazy var advancedInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrowDownButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        advancedLabelView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(140)
        }
        
        return btn
    }()
    
    @objc func advancedInfoButtonAction(sender: UIButton) {
        
        playPressSound()
        
        if !UserDefaults.standard.bool(forKey: "firstPressButton") {
            advancedInfoButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.beginnerLabelView.alpha = 0
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.elementaryLabelView.alpha = 0
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.intermediateLabelView.alpha = 0
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.upIntermediateLabelView.alpha = 0
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: -400)
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 100)
                self.proficiencyLabelView.alpha = 0
                
                self.advancedLabelView.alpha = 1
                self.advancedInfoLabel.alpha = 1
                self.dismissButton.alpha = 0
            })
            UserDefaults.standard.set(true, forKey: "firstPressButton")
        } else {
            advancedInfoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.beginnerLabelView.alpha = self.meaningAlphaBeginner
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.advancedInfoLabel.alpha = 0
                self.dismissButton.alpha = 1
            })
            UserDefaults.standard.set(false, forKey: "firstPressButton")
        }
    }
    
//MARK: - LabelProficiency
    lazy var proficiencyLabelView: UIView = {
        let vi = UIView()
        vi.alpha = 0.4
        self.view.addSubview(vi)
        mainView.addSubview(vi)
        
        vi.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(500)
            make.centerX.equalToSuperview()
            make.centerYWithinMargins.equalTo(200)
        }
        
        return vi
    }()
    
    lazy var proficiencyLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "appleberry", size: 23)
        lbl.text = "C2 - Proficiency"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        proficiencyLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(0)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var proficiencyNumberLabel: UILabel = {
        var fontName = "Lorjuk"
        var fontSize: CGFloat!
        switch Locale.current.languageCode {
        case "es":
            fontName = "Lorjuk"
            fontSize = 23
        default:
            fontName = "lcChalk"
            fontSize = 15
        }
        
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: fontSize)
        lbl.text = "более 4500".localized()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        self.view.addSubview(lbl)
        proficiencyLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(0)
        }
        
        return lbl
    }()
    
    lazy var proficiencyInfoLabel: UILabel = {
        
        var txtSz: CGFloat!
        let wdth: CGFloat!
        if totalSize.height >= 890 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            wdth = 340
            txtSz = 15
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            wdth = 350
            txtSz = 16
        } else if totalSize.height <= 670 {
            wdth = 330
            txtSz = 14
        } else {
            wdth = 330
            txtSz = 15
        }
        
    //Locate
        var fontName = "lcChalk"
        switch Locale.current.languageCode {
        case "ru":
            fontName = "lcChalk"
        case "tr":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        case "es":
            fontName = "Lorjuk"
            
            if totalSize.height >= 890 {
                txtSz = 24
            } else if totalSize.height >= 830 && totalSize.height <= 889 {
                txtSz = 23
            } else if totalSize.height >= 671 && totalSize.height <= 800 {
                txtSz = 24
            } else if totalSize.height <= 670 {
                txtSz = 22
            } else {
                txtSz = 23
            }
        default:
            fontName = "lcChalk"
        }
    
        let lbl = UILabel()
        lbl.font = UIFont(name: fontName, size: txtSz)
        lbl.text = "Mastery or proficiency. \n\n Владение в совершенстве. Находясь на самом высоком уровне, вы сможете: \n\n -понимать практически все услышанное и прочитанное; \n\n -обобщить информацию из различных устных и письменных источников, оформить доводы и мнения в виде связного текста; \n\n -говорить на любую тему без подготовки, точно и без затруднений выражая свою мысль.".localized()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.alpha = 0
        self.view.addSubview(lbl)
        proficiencyLabelView.addSubview(lbl)
        
        lbl.snp.makeConstraints { make in
            make.centerYWithinMargins.equalTo(320)
            make.centerXWithinMargins.equalTo(0)
            make.width.equalTo(wdth)
        }
        
        return lbl
    }()
    
    lazy var proficiencyInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrowDownButton"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        proficiencyLabelView.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.centerYWithinMargins.equalTo(33)
            make.centerXWithinMargins.equalTo(120)
        }
        
        return btn
    }()
    
    @objc func proficiencyInfoButtonAction(sender: UIButton) {
        
        playPressSound()
        
        if !UserDefaults.standard.bool(forKey: "firstPressButton") {
            proficiencyInfoButton.transform = CGAffineTransform(scaleX: 1, y: -1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.beginnerLabelView.alpha = 0
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.elementaryLabelView.alpha = 0
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.intermediateLabelView.alpha = 0
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.upIntermediateLabelView.alpha = 0
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.advancedLabelView.alpha = 0
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: -500)
                self.proficiencyLabelView.alpha = 0
                
                self.proficiencyLabelView.alpha = 1
                self.proficiencyInfoLabel.alpha = 1
                self.dismissButton.alpha = 0
            })
            UserDefaults.standard.set(true, forKey: "firstPressButton")
        } else {
            proficiencyInfoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.beginnerLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.beginnerLabelView.alpha = self.meaningAlphaBeginner
                self.elementaryLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.elementaryLabelView.alpha = self.meaningAlphaElementary
                self.intermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.intermediateLabelView.alpha = self.meaningAlphaIntermediate
                self.upIntermediateLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.upIntermediateLabelView.alpha = self.meaningAlphaUpIntermediate
                self.advancedLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.advancedLabelView.alpha = self.meaningAlphaAdvanced
                self.proficiencyLabelView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                
                self.proficiencyLabelView.alpha = self.meaningAlphaProficiency
                self.proficiencyInfoLabel.alpha = 0
                self.dismissButton.alpha = 1
            })
            UserDefaults.standard.set(false, forKey: "firstPressButton")
        }
    }
    
//MARK: - DismissButton
    lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeButtonChalk"), for: .normal)
        btn.contentMode = .scaleAspectFit
        self.view.addSubview(btn)
        mainView.addSubview(btn)
        
        var positY: CGFloat!
        var positX: CGFloat!
        var wdth: CGFloat!
        if totalSize.height >= 920 {
            positY = -365
            positX = 160
            wdth = 35
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            positY = -360
            positX = 160
            wdth = 35
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            positY = -345
            positX = 153
            wdth = 35
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            positY = -340
            positX = 160
            wdth = 35
        } else if totalSize.height <= 670 {
            positY = -323
            positX = 145
            wdth = 30
        } else {
            positY = -327
            positX = 143
            wdth = 35
        }
        
        btn.snp.makeConstraints { make in
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        return btn
    }()
    @objc func dismissButtonAction(sender: UIButton) {
        playPressSound()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: -930)
        })
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "infoBlackboardDismiss"), object: nil)
            
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
