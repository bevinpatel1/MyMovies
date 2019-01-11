//
//  SearchViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    var searchTableData: Observable<[SearchKey]>
    var searchKeys : Variable<[SearchKey]> = Variable([])
    var searchString : BehaviorRelay<String>   = BehaviorRelay(value: "")
    
    override init() {
        self.searchTableData = searchKeys.asObservable()
        super.init()
        self.loadDefault()
    }
    private func loadDefault(){
        searchKeys.value = self.loadRecent()
    }
    func serchTap(){
        self.setRecent(searhcKey: SearchKey(title: searchString.value))
    }
    private func loadRecent()->[SearchKey]{
        if let addressData = UserDefaults.standard.object(forKey:"SearchHistrory") as? Data{
            let addressArray = NSKeyedUnarchiver.unarchiveObject(with: addressData)
            return addressArray as? [SearchKey] ?? []
        }
        else{
            return []
        }
    }
    private func setRecent(searhcKey: SearchKey){
        var recentArray = self.loadRecent()
        recentArray.insert(searhcKey, at: 0)
        if recentArray.count > 10{
            recentArray.removeLast();
        }
        searchKeys.value = recentArray;
        
        let recentData = NSKeyedArchiver.archivedData(withRootObject: recentArray)
        UserDefaults.standard.set(recentData, forKey:"SearchHistrory")
        UserDefaults.standard.synchronize()
    }
}
