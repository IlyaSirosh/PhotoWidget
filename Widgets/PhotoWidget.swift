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
            PhotoWidgetView(config: entry.widgetData, photoShape: ContainerRelativeShape())
        }
        .configurationDisplayName("Photo Widget")
        .description("Customize photos and layout")
    }
}


struct PhotoProvider: TimelineProvider {
    private let store = PhotoWidgetStore()
    
    func placeholder(in context: Context) -> PhotoEntry {
        simplePhotoEntry(in: context)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PhotoEntry) -> Void) {
        completion(photoEntry(for: Date(), in: context))
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
        let family = context.family
        let configuration = store.loadWidget()

        if let data = configuration[family] {
            return PhotoEntry(date: date, widgetData: data)
        } else {
            return simplePhotoEntry(in: context)
        }
        
    }
    
    func simplePhotoEntry(for date: Date = Date(), in context: Context) -> PhotoEntry {

        return PhotoEntry(date: date, widgetData: PhotoWidgetData(layout: PhotoWidgetSettings.layouts(for: context.family)[0]))
    }
}

struct PhotoEntry: TimelineEntry {
    var date: Date
    var widgetData: PhotoWidgetData
}
