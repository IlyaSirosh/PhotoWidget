//
//  WidgetBuilderViewModel.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import Foundation
import WidgetKit


class WidgetBuilderViewModel: ObservableObject {
    @Published var builder: WidgetBuilder
    
    convenience init() {
        self.init(builder: WidgetBuilder())
    }
    
    init(builder: WidgetBuilder) {
        self.builder = builder
    }
    
    var family: WidgetFamily {
        builder.currentFamily
    }
    
    var widgetData: PhotoWidgetData {
        builder.widgetData
    }
    
    var layoutOptions: [WidgetLayout] {
        builder.layoutOptions
    }
    
    
    // Intents
    
    func toggleWidgetFamily() {
        builder.changeWidgetFamily()
    }
    
    func select(layout: WidgetLayout) {
        builder.updateWidgetLayout(with: layout)
    }
    
    func select(photo url: URL, in position: Int) {
        builder.updateWidgetPhoto(position: position, url: url)
    }
    
    func removePhoto(position: Int) {
        builder.removeWidgetPhoto(position: position)
    }
}
