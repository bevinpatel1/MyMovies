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
enum SearchEvent {
    case onMovieList(search : String)
    case onDismiss
}

class SearchViewModel: BaseViewModel {
    let events = PublishSubject<SearchEvent>()
    var searchTableData: Observable<[SearchKey]>
    var searchString : BehaviorRelay<String>   = BehaviorRelay(value: "")
    private var searchKeys : Variable<[SearchKey]> = Variable([])
    
    override init() {
        self.searchTableData = searchKeys.asObservable()
        super.init()
        self.loadDefault()
    }
    private func loadDefault(){
        searchKeys.value = self.loadRecent()
    }
    func cancelTap(){
        events.onNext(.onDismiss)
    }
    func serchTap(){
        self.setRecent(searhcKey: SearchKey(title: searchString.value))
        events.onNext(.onMovieList(search: searchString.value))
    }
    func onDelete(indexPath : IndexPath){
        self.remove(index: indexPath.row)
    }
    func onSelect(indexPath : IndexPath){
        events.onNext(.onMovieList(search: searchKeys.value[indexPath.row].title ?? ""))
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
            recentArray.removeLast()
        }
        searchKeys.value = recentArray
        
        let recentData = NSKeyedArchiver.archivedData(withRootObject: recentArray)
        UserDefaults.standard.set(recentData, forKey:"SearchHistrory")
        UserDefaults.standard.synchronize()
    }
    private func remove(index : NSInteger){
        searchKeys.value.remove(at: index)
        let recentData = NSKeyedArchiver.archivedData(withRootObject: searchKeys.value)
        UserDefaults.standard.set(recentData, forKey:"SearchHistrory")
        UserDefaults.standard.synchronize()
    }
}
