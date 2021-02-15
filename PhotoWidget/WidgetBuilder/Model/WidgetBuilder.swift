//
//  WidgetBuilder.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import Foundation
import WidgetKit

struct WidgetBuilder {
    private var widget: [WidgetFamily: PhotoWidgetData] = [:]
    private(set) var currentFamily: WidgetFamily
    private(set) var widgetData: PhotoWidgetData {
        didSet {
            saveChanges()
        }
    }
    
    init() {
        // Load persisted settings
        self.currentFamily = .systemSmall
        self.widgetData = PhotoWidgetData(layout: PhotoWidgetSettings.layouts(for: currentFamily)[0])
    }
    
    
    func layoutOptions() -> [WidgetLayout] {
        PhotoWidgetSettings.layouts(for: currentFamily)
    }
    
    mutating func updateWidgetLayout(with layout: WidgetLayout) {
//        let previousLayout = widgetData.layout
        
        widgetData.layout = layout
        
        // TODO transition photo for layouts
    }
    
    mutating func updateWidgetPhoto(position: Int, url: URL?) {
        widgetData.photos[position] = url
    }
    
    private mutating func saveChanges() {
        widget[currentFamily] = widgetData
        // save widget
    }
    
    mutating func changeWidgetFamily() {
        currentFamily = WidgetFamily(rawValue: (currentFamily.rawValue + 1)%3 )!
        
        if let data = widget[currentFamily] {
            widgetData = data
        } else {
            initWidgetWithDefaultData()
        }
    }
    

    private mutating func initWidgetWithDefaultData() {
        self.widgetData = PhotoWidgetData(layout: PhotoWidgetSettings.layouts(for: currentFamily)[0])
    }
}
