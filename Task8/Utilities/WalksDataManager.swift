//
//  Data.swift
//  Task8
//
//  Created by Noura Hashem on 17/03/2022.
//

import Foundation

class WalksDataManager {
    
    static func getData() -> [WalkModel] {
        if let path = Bundle.main.path(forResource: "Journey", ofType: "json") {
            do {
                if let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
                    let decodedData = try JSONDecoder().decode(FullDataModel.self, from: jsonData)
                    let walksData: [WalkModel] = decodedData.walks ?? []
                    return walksData
                }
            } catch {
                print(error)
            }
        }
        return []
    }
}
