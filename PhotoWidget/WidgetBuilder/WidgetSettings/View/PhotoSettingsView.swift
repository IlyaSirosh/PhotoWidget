//
//  PhotoSettingsView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import SwiftUI

struct PhotoSettingsView: View {
    @EnvironmentObject var widgetBuilder: WidgetBuilderViewModel
    @Environment(\.buttonSpacing) var buttonSpacing: CGFloat
    
    var size: CGSize
    @State var isPickerPresented = false
    @State var photoIndexToSet: Int? {
        didSet {
            isPickerPresented = photoIndexToSet != nil
        }
    }
    @State var photoURL: URL?
    
    var body: some View {
        HStack(spacing: buttonSpacing) {
            ForEach(0..<widgetBuilder.widgetData.layout.count, id: \.self) { index in
       
                PhotoButton(
                    url: widgetBuilder.widgetData.photos[index],
                    onAdd: {
                        photoURL = nil
                        photoIndexToSet = index
                    },
                    onRemove: {
                        widgetBuilder.removePhoto(position: index)
                    })

            }
        }
        .sheet(isPresented: $isPickerPresented, content: {
            UnsplashImagePicker(url: $photoURL)
        })
        .onChange(of: photoURL) { _ in
            if let url = photoURL, let position = photoIndexToSet {
                widgetBuilder.select(photo: url, in: position)
            }
        }
    }
}
