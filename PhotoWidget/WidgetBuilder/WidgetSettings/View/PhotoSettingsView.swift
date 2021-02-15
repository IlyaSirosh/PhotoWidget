//
//  PhotoSettingsView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import SwiftUI

struct PhotoSettingsView: View {
    @EnvironmentObject var widgetBuilder: WidgetBuilderViewModel
    var size: CGSize
    @State var isPickerPresented = false
    @State var photoIndexToSet: Int? {
        didSet {
            isPickerPresented = photoIndexToSet != nil
        }
    }
    @State var photoURL: URL?
    
    var body: some View {
        HStack(spacing: padding) {
            ForEach(0..<widgetBuilder.widgetData.layout.count, id: \.self) { index in
       
                PhotoButton(
                    url: widgetBuilder.widgetData.photos[index],
                    onAdd: {
                        photoIndexToSet = index
                    },
                    onRemove: {
                        widgetBuilder.removePhoto(position: index)
                    })
                        .frame(width: width(for: size), height: width(for: size))
                
            }
        }.sheet(isPresented: $isPickerPresented, content: {
            UpsplashImagePicker(url: $photoURL)
        }).onChange(of: photoURL) { _ in
            if let url = photoURL, let position = photoIndexToSet {
                widgetBuilder.select(photo: url, in: position)
            }
        }
    }
    
    func width(for size: CGSize) -> CGFloat {
        (size.width - 5*padding) / 4
    }
    
    let padding: CGFloat = 20
}
