//
//  WidgetUtil.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit

struct WidgetUtil {
    static var screenPadding: CGFloat = 20
    
    static func aspectRatio(for family: WidgetFamily) -> CGFloat {
        switch family {
        case .systemSmall:
            return 1.0
        case .systemMedium:
            return 2.0
        case .systemLarge:
            return 1.0
        @unknown default:
            return 1.0
        }
    }
    
    static func size(for family: WidgetFamily, in containerSize: CGSize) -> CGSize {
        let width = containerSize.width - 2*screenPadding
        
        switch family {
        case .systemSmall:
            return CGSize(width: width/2, height: width/2)
        case .systemMedium:
            return CGSize(width: width, height: width/2)
        case .systemLarge:
            return CGSize(width: width, height: width)
        @unknown default:
            return CGSize(width: width/2, height: width/2)
        }
    }
}

