//
//  PreloadMenuViewController.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 18.04.2022.
//

import UIKit
import SnapKit
import Lottie
import AVFoundation

class PreloadMenuViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    
    var player: AVAudioPlayer?
    
    let sponge = AnimationView(name: "sponge")
    
    var totalWordsLearned = UserDefaults.standard.integer(forKey: "totalWordsLearned")
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackboard.isHidden = false
        totalWordsLearnedLabel.isHidden = false
        englishLevelLabel.isHidden = false
        davidingLineImage.isHidden = false
        
        spawnPreview()
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
        img.alpha = 0
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
        lbl.text = txtLvlEng
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
    
//MARK: - Preview
    func spawnPreview() {
        backgroundPreview.isHidden = false
        blackboardPreviewUnder.isHidden = false
        blackboardPreview.isHidden = false
        
        
        UIView.animate(withDuration: 1.1, animations: {
            self.blackboardPreview.alpha = 0
        })
        
        spongeAnimation()
        
        
        UIView.animate(withDuration: 0.4, delay: 1.4, animations: {
            self.blackboard.alpha = 1
        })
        
        
        var positY: CGFloat!
        if self.totalSize.height >= 920 {
            positY = -355
        } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
            positY = -340
        } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
            positY = -327
        } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
            positY = -298
        } else  if self.totalSize.height <= 670 {
            positY = -270
        } else {
            positY = -313
        }
        
        var scl: CGFloat!
        if self.totalSize.height >= 920 {
            scl = 1.09
        } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
            scl = 1.09
        } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
            scl = 1.1
        } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
            scl = 1.09
        } else if self.totalSize.height <= 670 {
            scl = 1.1
        } else {
            scl = 1.1
        }

        let scale = CGAffineTransform(scaleX: scl, y: scl);
        let trans = CGAffineTransform(translationX: 0, y: positY)

        UIView.animate(withDuration: 0.4, delay: 1.2, animations: {
            self.blackboardPreviewUnder.transform = scale.concatenating(trans)
        })
        
        
        UIView.animate(withDuration: 0.4, delay: 1.5, animations: {
            self.blackboardPreviewUnder.alpha = 0
        })
        Timer.scheduledTimer(withTimeInterval: 1.9, repeats: false) { (timer) in
            self.blackboardPreviewUnder.isHidden = true
        }
        
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            let vc = MenuViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.fade
//            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(vc, animated: true, completion: nil)
        }
    }
    //spongeAnimation
    func spongeAnimation() {
        sponge.contentMode = .scaleAspectFit
        sponge.loopMode = .playOnce
        sponge.layer.zPosition = 24
        self.view.addSubview(sponge)
        
        var positY: CGFloat!
        var positX: CGFloat!
        var wdth: CGFloat!
        if self.totalSize.height >= 920 {
            positX = -20
            positY = -60
            wdth = 370
        } else if self.totalSize.height >= 890 && self.totalSize.height <= 919 {
            positX = -20
            positY = -60
            wdth = 380
        } else if self.totalSize.height >= 830 && self.totalSize.height <= 889 {
            positX = -10
            positY = -55
            wdth = 360
        } else if self.totalSize.height >= 671 && self.totalSize.height <= 800 {
            positX = -10
            positY = -55
            wdth = 360
        } else if self.totalSize.height <= 670 {
            positX = -10
            positY = -57
            wdth = 340
        } else {
            positX = -10
            positY = -55
            wdth = 340
        }
        sponge.snp.makeConstraints { make in
            make.width.equalTo(wdth)
            make.centerXWithinMargins.equalTo(positX)
            make.centerYWithinMargins.equalTo(positY)
        }
        
        sponge.play { (finished) in
            self.sponge.isHidden = true
        }
    }
    //blackboard
    lazy var blackboardPreview: UIImageView = {
        let img = UIImageView(image: UIImage(named: "blackboardPreview"))
        img.contentMode = .scaleAspectFit
        img.layer.zPosition = 23
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(200)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        return img
    }()
    //blackboardUnder
    lazy var blackboardPreviewUnder: UIImageView = {
        let img = UIImageView(image: UIImage(named: "mainMenuBlackboard"))
        img.contentMode = .scaleAspectFit
        img.layer.zPosition = 22
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(200)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        return img
    }()
    //background
    lazy var backgroundPreview: UIImageView = {
        let img = UIImageView(image: UIImage(named: "backgroundMenu"))
        img.contentMode = .scaleAspectFill
        img.layer.zPosition = 21
        self.view.addSubview(img)
        
        img.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(0)
        }
        
        return img
    }()
}
