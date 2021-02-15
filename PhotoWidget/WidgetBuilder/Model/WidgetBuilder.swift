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
    private(set) var currentFamily: WidgetFamily {
        willSet {
            saveChanges()
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
        self.currentFamily = .systemSmall
        let layouts = PhotoWidgetSettings.layouts(for: currentFamily)
        self.widgetData = PhotoWidgetData(layout: layouts.randomElement()!, photos: [0: URL(string: "https://images.unsplash.com/photo-1613141276543-74107d388095?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1001&q=80")!, 2: URL(string: "https://images.unsplash.com/photo-1612541831162-96d8fe7558f9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80")!])
        self.layoutOptions = layouts
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
        // TODO persist widget
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


//var data: PhotoWidgetData =  PhotoWidgetData(layout: PhotoWidgetSettings.mediumLayouts[0], photos: [0: URL(string: "https://images.unsplash.com/photo-1613141276543-74107d388095?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1001&q=80")!, 2: URL(string: "https://images.unsplash.com/photo-1612541831162-96d8fe7558f9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80")!])
