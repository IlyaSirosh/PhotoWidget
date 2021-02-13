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
            PhotoWidgetView(config: PhotoWidgetData(layout: .columns(.item(0), .rows(.item(1), .item(2)) )))
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


struct PhotoProvider: TimelineProvider {
    func placeholder(in context: Context) -> PhotoEntry {
        PhotoEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PhotoEntry) -> Void) {
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PhotoEntry>) -> Void) {
        
    }
}

struct PhotoEntry: TimelineEntry {
    var date: Date
    
}
