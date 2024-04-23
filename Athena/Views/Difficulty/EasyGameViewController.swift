//
//  EasyGameViewController.swift
//  Athena
//
//  Created by Alex Henbest on 3/23/24.
//

import UIKit

class EasyGameViewController: UIViewController {
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleAnswer1: UIButton!
    @IBOutlet weak var titleAnswer2: UIButton!
    @IBOutlet weak var titleAnswer3: UIButton!
    @IBOutlet weak var titleAnswer4: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pauseplayImage: UIImageView!
    
    private var dataFrame: DataFrame?
    private var correctAnswer: String?
    private var trivia: [triviaScreen] = []
    
    private var timer: Timer = Timer()
    private var num: Int = 0
    var timerCounting: Bool = false
    
    private var usedIndexes: Set<Int> {
        get {
            if let storedIndexes = UserDefaults.standard.object(forKey: "usedIndexes") as? [Int] {
                return Set(storedIndexes)
            } else {
                return []
            }
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: "usedIndexes")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFrameFromCSV()
        displayRandomTrivia()
        startCounting()
        
    }

    
    func loadDataFrameFromCSV() {
        dataFrame = DataFrame(fromCSVFile: "trivia_mc - Easy")
        if let dataFrame = dataFrame {
            print(dataFrame.columns)
        }
    }

    func displayRandomTrivia() {
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
            
            trivia = [triviaScreen(category: category, question: question, answer1: answer1, answer2: answer2, answer3: answer3, answer4: answer4)]

            categoryLabel.text = trivia.first?.category
            questionText.text = trivia.first?.question
            titleAnswer1.setTitle(trivia.first?.answer1, for: .normal)
            titleAnswer2.setTitle(trivia.first?.answer2, for: .normal)
            titleAnswer3.setTitle(trivia.first?.answer3, for: .normal)
            titleAnswer4.setTitle(trivia.first?.answer4, for: .normal)
        }
    }

    
    @IBAction func aClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer1.titleLabel?.text {
            print("Correct!")
        }
        else {
            print("Incorrect!")
        }
    }
    @IBAction func bClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer2.titleLabel?.text {
            print("Correct!")
        }
        else {
            print("Incorrect!")
        }
    }
    @IBAction func cClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer3.titleLabel?.text {
            print("Correct!")
        }
        else {
            print("Incorrect!")
        }
    }
    @IBAction func dClicked(_ sender: Any) {
        let answer = correctAnswer
        if answer == titleAnswer4.titleLabel?.text {
            print("Correct!")
        }
        else {
            print("Incorrect!")
        }
    }
    
    func startCounting() {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        let pauseImage = UIImage(named: "pause")
        pauseplayImage.image = pauseImage
    }
    
    @IBAction func pauseClicked(_ sender: Any) {
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            let playImage = UIImage(named: "play")
            pauseplayImage.image = playImage
        } else {
            startCounting()
        }
    }
    @objc func timerCounter() -> Void {
        num = num + 1
        let time = secondsToMinutesSeconds(seconds: num)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        self.timerLabel.text = timeString
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return (((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}
