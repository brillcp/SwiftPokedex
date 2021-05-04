//
//  ItemsViewModel.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-05-04.
//

import UIKit

extension ItemsViewController {
    
    struct ViewModel {
        let item: ItemData
        
        var title: String { item.title.cleaned }
    }
}
