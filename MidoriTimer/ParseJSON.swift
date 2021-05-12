//
//  ParseJSON.swift
//  MidoriTimer
//
//  Created by Andrew Cheberyako on 07.05.2021.
//

import Foundation


class ParseJSON {
    
    static let shared = ParseJSON()
    var test = [TestElement]()
    
    func loadJson()  {
        guard let url = Bundle.main.url(forResource: "textJSON" , withExtension: "json") else {return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([TestElement].self, from: data)
            //                print(jsonData)
            test = jsonData
//                            print(test)
        } catch {
            print("error:\(error)")
        }
    }
    private init() {}
}
