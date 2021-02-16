//
//  WidgetBuilderViewModel.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import Foundation
import WidgetKit


class WidgetBuilderViewModel: ObservableObject {
    private var imageService: ImageService
    @Published private var builder: WidgetBuilder
    
    convenience init() {
        self.init(builder: WidgetBuilder(), imageService: ImageService())
    }
    
    init(builder: WidgetBuilder, imageService: ImageService) {
        self.builder = builder
        self.imageService = imageService
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
        imageService.saveImage(url: url) { [unowned self] result in
            switch result {
            case .success(let newURL):
                print("new file url: \(newURL)")
                self.builder.updateWidgetPhoto(position: position, url: newURL)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removePhoto(position: Int) {
        builder.removeWidgetPhoto(position: position)
        if let url = builder.widgetData.photos[position] {
            imageService.removeImage(url: url)
        }
        
    }
}
