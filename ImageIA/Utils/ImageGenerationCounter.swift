//
//  ImageGenerationCounter.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 09/03/25.
//

import Foundation

final class ImageGenerationCounter {
    private let key = "imageGenerationCount"
    private let defaultValue = 5
    
    var count: Int {
        get {
            return UserDefaults.standard.integer(forKey: key) == 0 ? defaultValue : UserDefaults.standard.integer(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    func decrement() {
        if count > 0 {
            count -= 1
        }
    }
    
    func reset() {
        count = defaultValue
    }
}
