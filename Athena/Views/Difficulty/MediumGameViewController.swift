//
//  MediumGameViewController.swift
//  Athena
//
//  Created by Alex Henbest on 3/23/24.
//

import UIKit

class MediumGameViewController: UIViewController {
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var pausedLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleAnswer1: UIButton!
    @IBOutlet weak var titleAnswer2: UIButton!
    @IBOutlet weak var titleAnswer3: UIButton!
    @IBOutlet weak var titleAnswer4: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseplayImage: UIImageView!
    @IBOutlet weak var darkerSpace: UILabel!
    @IBOutlet weak var correctPopUp: UIView!
    @IBOutlet weak var incorrectPopUp: UIView!
    
    
    private var dataFrame: DataFrame?
    private var correctAnswer: String?
    private var trivia: [triviaScreen] = []
    private var incorrect: Bool = false
    private var correct: Bool = false
    
    private var date = Date()
    private var currentDate: String?
    let format = DateFormatter()
    
    private var timer: Timer = Timer()
    private var num: Int = 0
    private var timerCounting: Bool = false
    private var timeString: String = ""
    
    private var usedIndexes: Set<Int> {
        get {
            if let storedIndexes = UserDefaults.standard.object(forKey: "mediumUsedIndexes") as? [Int] {
                return Set(storedIndexes)
            } else {
                return []
            }
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: "mediumUsedIndexes")
        }
    }

    private var correctTimes: [String] {
        get {
            if let storedTimes = UserDefaults.standard.object(forKey: "mediumCorrectTimes") as? [String] {
                return storedTimes
            } else {
                return []
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mediumCorrectTimes")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        format.dateFormat = "yyyy-MM-dd"
        currentDate = format.string(from: date)
        
        self.blurEffect.isHidden = false
        self.startButton.isHidden = false
        self.pausedLabel.isHidden = true
        self.correctPopUp.isHidden = true
        self.incorrectPopUp.isHidden = true

        loadDataFrameFromCSV()
        displayRandomTrivia()
        
        correctPopUp.layer.cornerRadius = 25
        correctPopUp.clipsToBounds = true
        incorrectPopUp.layer.cornerRadius = 25
        incorrectPopUp.clipsToBounds = true
    }

    
    private func loadDataFrameFromCSV() {
        dataFrame = DataFrame(fromCSVFile: "trivia_mc - Medium")
        if let dataFrame = dataFrame {
            print(dataFrame.columns)
        }
    }

    private func displayRandomTrivia() {
        let numberOfRows = dataFrame?.rows.count ?? 0
        var availableIndexes = Array(0..<numberOfRows)
        let answerRandomizer = [3, 4, 5, 6]
        
        // Remove the used indexes from the available indexes
        availableIndexes.removeAll(where: { usedIndexes.contains($0) })
        
        // If there are no more available indexes, reset the usedIndexes set
        if availableIndexes.isEmpty {
            usedIndexes.removeAll()
            availableIndexes = Array(0..<numberOfRows)
        }
        
        // Randomly select a row index
        if let i = availableIndexes.randomElement() {
            print("Randomly selected row index: \(i)")
            
            usedIndexes.insert(i)
            usedIndexes.removeAll() //comment out if i want used indexes to save
            
            let j = answerRandomizer.shuffled()
            print(j)
            
            let category = dataFrame!.rows[i][0]
            let question = dataFrame!.rows[i][2]
            correctAnswer = dataFrame!.rows[i][3]
            let answer1 = dataFrame!.rows[i][j[0]]
            let answer2 = dataFrame!.rows[i][j[1]]
            let answer3 = dataFrame!.rows[i][j[2]]
            let answer4 = dataFrame!.rows[i][j[3]]
            
            UserDefaults.standard.set(correctAnswer, forKey: "mediumCorrectAnswer")
            
            trivia = [triviaScreen(category: category, question: question, answer1: answer1, answer2: answer2, answer3: answer3, answer4: answer4)]

            categoryLabel.text = trivia.first?.category
            questionText.text = trivia.first?.question
            titleAnswer1.setTitle(trivia.first?.answer1, for: .normal)
            titleAnswer2.setTitle(trivia.first?.answer2, for: .normal)
            titleAnswer3.setTitle(trivia.first?.answer3, for: .normal)
            titleAnswer4.setTitle(trivia.first?.answer4, for: .normal)
        }
    }

    @IBAction func startClicked(_ sender: Any) {
        startCounting()
        self.startButton.isHidden = true
    }
    
    @IBAction func aClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer1.titleLabel?.text {
            correct = true
            incorrect = false
        } else {
            incorrect = true
            correct = false
        }
        stopCounting()
        
        if incorrect == true {
            answerIncorrect()
        } else if correct == true {
            answerCorrect()
        }
    }
    @IBAction func bClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer2.titleLabel?.text {
            correct = true
            incorrect = false
        } else {
            incorrect = true
            correct = false
        }
        stopCounting()
        
        if incorrect == true {
            answerIncorrect()
        } else if correct == true {
            answerCorrect()
        }
    }
    @IBAction func cClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer3.titleLabel?.text {
            correct = true
            incorrect = false
        } else {
            incorrect = true
            correct = false
        }
        stopCounting()
        
        if incorrect == true {
            answerIncorrect()
        } else if correct == true {
            answerCorrect()
        }
    }
    
    @IBAction func dClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer4.titleLabel?.text {
            correct = true
            incorrect = false
        } else {
            incorrect = true
            correct = false
        }
        stopCounting()
        
        if incorrect == true {
            answerIncorrect()
        } else if correct == true {
            answerCorrect()
        }
    }
        
    
    private func startCounting() {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        let pauseImage = UIImage(named: "pause")
        pauseplayImage.image = pauseImage
        self.blurEffect.isHidden = true
    }
    
    private func stopCounting() {
        timerCounting = false
        timer.invalidate()
        self.blurEffect.isHidden = false
    }
    
    private func resetTimer() {
        self.num = 0
        self.timer.invalidate()
        self.timerLabel.text = self.makeTimeString(minutes: 0, seconds: 0)
    }
    
    @objc func timerCounter() -> Void {
        num = num + 1
        let time = secondsToMinutesSeconds(seconds: num)
        timeString = makeTimeString(minutes: time.0, seconds: time.1)
        if timeString == "60:00" {
            incorrect = true
            print("Incorrect!")
            stopCounting()
            resetTimer()
        } else {
            self.timerLabel.text = timeString
        }
    }
    
    @IBAction func pauseClicked(_ sender: Any) {
        if(timerCounting) {
            stopCounting()
            let playImage = UIImage(named: "play")
            pauseplayImage.image = playImage
            self.pausedLabel.isHidden = false
            view.bringSubviewToFront(pauseplayImage)
            view.bringSubviewToFront(pauseButton)
            view.bringSubviewToFront(timerLabel)
        } else {
            startCounting()
            self.pausedLabel.isHidden = true
            view.sendSubviewToBack(timerLabel)
            view.sendSubviewToBack(pauseButton)
            view.sendSubviewToBack(pauseplayImage)
            view.sendSubviewToBack(darkerSpace)
        }
    }
    
    private func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return (((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    private func makeTimeString(minutes: Int, seconds: Int) -> String {
        timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    private func answerCorrect() {
        print("Correct!")
        correctTimes.append(timeString)
        correctTimes = [] //comment out to make correct times save
        print(correctTimes)
        UserDefaults.standard.set(true, forKey: "mediumCorrectShowing")
        UserDefaults.standard.set(true, forKey: "mediumDone")
        UserDefaults.standard.set(currentDate, forKey: "mediumLastDate")
        self.correctPopUp.isHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func answerIncorrect() {
        print("Incorrect!")
        resetTimer()
        UserDefaults.standard.set(true, forKey: "mediumIncorrectShowing")
        UserDefaults.standard.set(true, forKey: "mediumDone")
        UserDefaults.standard.set(currentDate, forKey: "mediumLastDate")
        self.incorrectPopUp.isHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
}
