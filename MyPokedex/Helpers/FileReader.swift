//
//  FileReader.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import Foundation

var baseURL: String {
    get {
        // get Info.plist file path
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        
        // get BASE_URL from file Info.plist
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "BASE_URL") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'nfo.plist'.")
        }
        return value
    }
}
