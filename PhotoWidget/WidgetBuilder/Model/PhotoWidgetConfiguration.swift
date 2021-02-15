//
//  PhotoWidgetConfiguration.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import Foundation
import WidgetKit

struct PhotoWidgetConfiguration {
    
    func loadCurrentWidgetFamily() -> WidgetFamily? {
        return nil
    }
    
    func loadWidget() -> [WidgetFamily: PhotoWidgetData] {
        return [:]
    }
    
    func save(configuration: [WidgetFamily: PhotoWidgetData]) {
        
    }
    
    func save(family: WidgetFamily) {
        
    }
}
