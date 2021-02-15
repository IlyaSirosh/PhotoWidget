//
//  WidgetLayout.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import Foundation

enum WidgetLayout: Equatable {
    case item(Int)
    indirect case columns(WidgetLayout, WidgetLayout)
    indirect case rows(WidgetLayout, WidgetLayout)
    
    var count: Int {
        WidgetLayout.itemCount(for: self)
    }
    
    static func itemCount(for layout: WidgetLayout) -> Int {
        switch layout {
        case .item(_):
            return 1
        case .columns(let l1, let l2):
            return itemCount(for: l1) + itemCount(for: l2)
        case .rows(let l1, let l2):
            return itemCount(for: l1) + itemCount(for: l2)
        }
    }
}

