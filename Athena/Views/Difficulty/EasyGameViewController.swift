//
//  EasyGameViewController.swift
//  Athena
//
//  Created by Alex Henbest on 3/23/24.
//

import UIKit

class EasyGameViewController: UIViewController {
    
    private var dataFrame: DataFrame?
    var trivia: [triviaScreen] = []
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleAnswer1: UIButton!
    @IBOutlet weak var titleAnswer2: UIButton!
    @IBOutlet weak var titleAnswer3: UIButton!
    @IBOutlet weak var titleAnswer4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFrameFromCSV()
        
        let category = dataFrame!.rows[1][0]
        let question = dataFrame!.rows[1][2]
        let answer = dataFrame!.rows[1][3]
        let incorrect1 = dataFrame!.rows[1][4]
        let incorrect2 = dataFrame!.rows[1][5]
        let incorrect3 = dataFrame!.rows[1][6]
        
        trivia = [triviaScreen(category: category, question: question, answer: answer, incorrect1: incorrect1, incorrect2: incorrect2, incorrect3: incorrect3)]
        
        categoryLabel.text = trivia.first?.category
        questionText.text = trivia.first?.question
        titleAnswer1.setTitle(trivia.first?.answer, for: .normal)
        titleAnswer2.setTitle(trivia.first?.incorrect1, for: .normal)
        titleAnswer3.setTitle(trivia.first?.incorrect2, for: .normal)
        titleAnswer4.setTitle(trivia.first?.incorrect3, for: .normal)
    }

    private func loadDataFrameFromCSV() {
        dataFrame = DataFrame(fromCSVFile: "trivia_mc - Easy")

        // Use the DataFrame as needed
        if let dataFrame = dataFrame {
            print(dataFrame.columns)
            print(dataFrame.rows)
        }
    }
}
