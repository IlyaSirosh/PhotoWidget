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
    
    var body: some View {
        HStack(spacing: padding) {
            ForEach(0..<widgetBuilder.widgetData.layout.count, id: \.self) { index in
       
                PhotoButton(
                    url: widgetBuilder.widgetData.photos[index],
                    onAdd: {
                        
                    },
                    onRemove: {
                        widgetBuilder.removePhoto(position: index)
                    })
                        .frame(width: width(for: size), height: width(for: size))
                
            }
        }.onAppear {
            print(widgetBuilder.widgetData)
        }
    }
    
    func width(for size: CGSize) -> CGFloat {
        (size.width - 5*padding) / 4
    }
    
    let padding: CGFloat = 20
}
