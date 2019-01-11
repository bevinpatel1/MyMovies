//
//  Constants.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import UIKit

enum InternetConnectionErrorCode: Int {
    case offline = 10101
}
var AppDisplayName: String {return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String}
