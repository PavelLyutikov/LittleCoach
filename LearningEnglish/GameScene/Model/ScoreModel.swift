//
//  ScoreModel.swift
//  LearningEnglish
//
//  Created by Pavel Lyutikov on 28.12.2021.
//

import Foundation

class ScoreModel {
    
    fileprivate var correctAnswers: Int = 0
    fileprivate var incorrectAnswers: Int = 0
    
    var percentaile = 0.0
    
    func reset() {
        correctAnswers = 0
        incorrectAnswers = 0
    }

    func incrementCorrectAnswers() {
        correctAnswers += 1
    }
    
    func incrementIncorrectAnswers() {
        incorrectAnswers += 1
    }
    
    func getQuestionsAsked() -> Int {
        return correctAnswers + incorrectAnswers
    }
    
    func saveProgress() {
        let modelName = UserDefaults.standard.string(forKey: "dictionaryName")
        
        if modelName == "iYou" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonIYouProgress")
        } else if modelName == "iYouComplex" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonIYouComplexProgress")
        } else if modelName == "hello" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonHelloProgress")
        } else if modelName == "question" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonQuestionProgress")
        } else if modelName == "color" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonColorProgress")
        } else if modelName == "geometricShape" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonGeometricShapeProgress")
        } else if modelName == "number" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonNumberProgress")
        } else if modelName == "numberComplex" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonNumberComplexProgress")
        } else if modelName == "unitsOfTime" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonUnitsOfTimeProgress")
        } else if modelName == "monthSeason" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonMonthSeasonProgress")
        } else if modelName == "day" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonDayProgress")
        } else if modelName == "timePeriods" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonTimePeriodsProgress")
        } else if modelName == "person" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonGeneralProgress")
        } else if modelName == "family" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonFamilyProgress")
        } else if modelName == "body" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonBodyProgress")
        } else if modelName == "feelings" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonFeelingsProgress")
        } else if modelName == "appearance" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonAppearanceProgress")
        } else if modelName == "aboutFood" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonAboutFoodProgress")
        } else if modelName == "drink" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonDrinkProgress")
        } else if modelName == "drinkReverse" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonDrinkReverseProgress")
        } else if modelName == "milk" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonMilkProgress")
        } else if modelName == "milkReverse" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonMilkReverseProgress")
        } else if modelName == "vegetable" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonVegetableProgress")
        } else if modelName == "fruit" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonFruitProgress")
        } else if modelName == "nut" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonNutProgress")
        } else if modelName == "meat" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonMeatProgress")
        } else if modelName == "products" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonProductsProgress")
        } else if modelName == "productsReverse" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonProductsReverseProgress")
        } else if modelName == "sweets" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonSweetsProgress")
        } else if modelName == "cookedFood" {
            UserDefaults.standard.set(correctAnswers, forKey: "buttonCookedFoodProgress")
        }
    }
    
    func getScore() -> String {
        percentaile = Double(correctAnswers) / Double(getQuestionsAsked())

        if (percentaile >= 0.80) {
            return "Превосходно!".localized() + "\n Вы ответили на ".localized() + "\(correctAnswers)" + " из ".localized() + "\(getQuestionsAsked())" + " вопросов верно!".localized()
        } else if (percentaile >= 0.5) {
            return "Хороший результат!".localized() + "\n Вы ответили на ".localized() + "\(correctAnswers)" + " из ".localized() + "\(getQuestionsAsked())" + " вопросов верно!".localized()
        } else {
            return "Это не лучший результат.".localized() + "\n Вы ответили на ".localized() + "\(correctAnswers)" + " из ".localized() + "\(getQuestionsAsked())" + " вопросов верно!".localized()
        }
    }
    func getScoreInt() -> Int {

        if (percentaile >= 0.80) {
            return 1
        } else if (percentaile >= 0.5) {
            return 2
        } else {
            return 3
        }
    }
}
