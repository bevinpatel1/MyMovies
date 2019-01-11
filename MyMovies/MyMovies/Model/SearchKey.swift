//
//  SearchKey.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit

class SearchKey : NSObject,NSCoding {
    var title : String?
    init(title: String?){
        self.title = title
    }
    required init?(coder aDecoder: NSCoder) {
        self.title   = aDecoder.decodeObject(forKey:  "SELF.TITLE")  as? String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title,   forKey: "SELF.TITLE")
    }
}
