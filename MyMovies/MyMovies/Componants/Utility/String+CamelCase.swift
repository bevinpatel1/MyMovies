//
//  String+CamelCase.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var underscoreToCamelCase: String {
        var items = self.components(separatedBy: "_")
        var camelCase = ""
        let first = items.first?.lowercased() ?? ""
        items.remove(at: 0)
        camelCase = items.reduce(first, {$0 + $1.capitalizingFirstLetter()})
        return camelCase
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
