//
//  PhotoWidgetSettings.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import Foundation
import WidgetKit

struct PhotoWidgetSettings {
    
    static let largeLayouts: [WidgetLayout] = [
        .rows(.item(0), .columns(.item(2), .item(1))),
        .rows(.columns(.item(0), .item(1)), .columns(.item(3), .item(2))),
        .rows(.columns(.item(0), .item(1)), .item(2)),
        .columns(.item(0), .rows(.item(1), .item(2)))
    ]
    
    static let mediumLayouts: [WidgetLayout] = [
        .rows(.columns(.item(0), .item(1)), .columns(.item(3), .item(2))),
        .columns(.item(0), .rows(.item(1), .item(2))),
        .columns(.rows(.item(0), .item(2)), .item(1)),
        .columns(.item(0), .item(1))
    ]
    
    static let smallLayouts: [WidgetLayout] = [
        .rows(.item(0), .columns(.item(2), .item(1))),
        .columns(.item(0), .item(1)),
        .rows(.item(0), .item(1)),
        .rows(.columns(.item(0), .item(1)), .columns(.item(3), .item(2)))
    ]
    
    static func layouts(for family: WidgetFamily) -> [WidgetLayout] {
        switch family {
        case .systemSmall:
            return smallLayouts
        case .systemMedium:
            return mediumLayouts
        case .systemLarge:
            return largeLayouts
        @unknown default:
            return smallLayouts
        }
    }
}
