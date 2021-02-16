//
//  PhotoWidget.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 12.02.2021.
//

import WidgetKit
import SwiftUI

@main
struct PhotoWidget: Widget {
    let kind: String = "photo-widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PhotoProvider()) { entry in
            PhotoWidgetView(config: entry.widgetData )
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


struct PhotoProvider: TimelineProvider {
    private let store = PhotoWidgetStore()
    
    func placeholder(in context: Context) -> PhotoEntry {
        simplePhotoEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PhotoEntry) -> Void) {
        
//        if context.isPreview {
//            completion(simplePhotoEntry())
//        } else {
            completion(photoEntry(for: Date(), in: context))
//        }
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PhotoEntry>) -> Void) {
        let date = Date()
        let entry = photoEntry(for: date, in: context)
        
        let timeline = Timeline(entries: [
            entry
        ], policy: .never )
        
        completion(timeline)
    }
    
    
    func photoEntry(for date: Date, in context: Context) -> PhotoEntry {
        print("get photo entry")
        let family = context.family
        let configuration = store.loadWidget()
        print(configuration)
        if let data = configuration[family] {
            return PhotoEntry(date: date, widgetData: data)
        } else {
            return simplePhotoEntry()
        }
        
    }
    
    func simplePhotoEntry(for date: Date = Date()) -> PhotoEntry {
        print("get simple entry")
        return PhotoEntry(date: date, widgetData: .example)
    }
}

struct PhotoEntry: TimelineEntry {
    var date: Date
    var widgetData: PhotoWidgetData
}
