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
}

extension PhotoWidgetData: Codable  {}
