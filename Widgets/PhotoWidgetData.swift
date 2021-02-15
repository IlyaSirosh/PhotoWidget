//
//  PhotoWidgetData.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 12.02.2021.
//

import Foundation

struct PhotoWidgetData {
    var layout: WidgetLayout
    var photos: [Int: URL] = [:]
    
    static let example = PhotoWidgetData(layout: .columns(.rows(.item(0), .item(1)), .rows(.item(3), .item(2))))
}

extension PhotoWidgetData: Codable  {}
