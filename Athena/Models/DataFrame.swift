//
//  DataFrame.swift
//  Athena
//
//  Created by Alex Henbest on 4/12/24.
//

import UIKit


struct DataFrame {
    var columns: [String]
    var rows: [[String]]

    init(fromCSVFile fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "csv"),
              let csvData = try? String(contentsOf: url) else {
            self.columns = []
            self.rows = []
            return
        }

        let lines = csvData.components(separatedBy: .newlines)
        if let headerLine = lines.first {
            self.columns = headerLine.components(separatedBy: "*")
        } else {
            self.columns = []
        }

        self.rows = lines.dropFirst().compactMap { line in
            line.components(separatedBy: "*")
        }
    }
}
