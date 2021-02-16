//
//  WidgetBuilder.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import Foundation
import WidgetKit

struct WidgetBuilder {
    private var store = PhotoWidgetStore()
    private var widget: [WidgetFamily: PhotoWidgetData]
    private(set) var currentFamily: WidgetFamily {
        didSet {
            store.save(family: currentFamily)
        }
    }
    private(set) var layoutOptions: [WidgetLayout]
    private(set) var widgetData: PhotoWidgetData {
        didSet {
            saveChanges()
        }
    }
    
    init() {
        // TODO Load persisted settings
        self.currentFamily = store.loadCurrentWidgetFamily() ?? .systemSmall
        self.layoutOptions = PhotoWidgetSettings.layouts(for: currentFamily)
        self.widget = store.loadWidget()

        if let data = widget[currentFamily] {
            self.widgetData = data
        } else {
            self.widgetData = PhotoWidgetData(layout: self.layoutOptions[0])
        }
        
    }
    
    mutating func updateWidgetLayout(with layout: WidgetLayout) {
//        let previousLayout = widgetData.layout
        
        widgetData.layout = layout
        
        // TODO transition photo for layouts
    }
    
    mutating func updateWidgetPhoto(position: Int, url: URL) {
        widgetData.photos[position] = url
    }
    
    mutating func removeWidgetPhoto(position: Int) {
        
        if let url = widgetData.photos[position] {
            widgetData.photos[position] = nil
            
            // TODO clean up data of url
        }
    }
    
    private mutating func saveChanges() {
        widget[currentFamily] = widgetData
        store.save(configuration: widget)
        WidgetCenter.shared.reloadTimelines(ofKind: "photo-widget")
    }
    
    mutating func changeWidgetFamily() {
        currentFamily = WidgetFamily(rawValue: (currentFamily.rawValue + 1)%3 )!

        if let data = widget[currentFamily] {
            widgetData = data
        } else {
            initWidgetWithDefaultData()
        }
        
        layoutOptions = PhotoWidgetSettings.layouts(for: currentFamily)
    }
    

    private mutating func initWidgetWithDefaultData() {
        self.widgetData = PhotoWidgetData(layout: PhotoWidgetSettings.layouts(for: currentFamily)[0])
    }
}
