//
//  LayoutSettingsView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import SwiftUI
import WidgetKit

struct LayoutSettingsView: View {
    @EnvironmentObject var widgetBuilder: WidgetBuilderViewModel
    var size: CGSize
    var layout: WidgetLayout {
        widgetBuilder.widgetData.layout
    }
    var layouts: [WidgetLayout] {
        widgetBuilder.layoutOptions
    }
    var family: WidgetFamily {
        widgetBuilder.family
    }

    
    
    var body: some View {
        widgetContainer {
            ForEach(0..<layouts.count) { index in
                widget(for: layouts[index])
            }
        }
    }
    
    
    @ViewBuilder
    func widgetContainer<Content: View>(@ViewBuilder  content: () -> Content ) -> some View {
        if family == .systemMedium {
            LazyVGrid(columns: [ GridItem(.adaptive(minimum: 100)) , GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: padding) {
                content()
            }
        } else {
            HStack(spacing: padding) {
                content()
            }
        }
    }
    
    func widget(for layout: WidgetLayout) -> some View {
        PhotoWidgetView(config: PhotoWidgetData(layout: layout))
            .background(self.layout == layout ? Color.white : Color.clear)
            .frame(width: width(for: size))
            .cornerRadius(height(for: size) / 5)
            .aspectRatio(WidgetUtil.aspectRatio(for: family), contentMode: .fit)
            .onTapGesture{
                widgetBuilder.select(layout: layout)
            }
    }
    
    func width(for size: CGSize) -> CGFloat {
        if family == .systemMedium {
            return (size.width - 3*padding) / 2
        } else {
            return (size.width - 5*padding) / 4
        }
        
    }
    
    func height(for size: CGSize) -> CGFloat {
        
        return (size.width - 5*padding) / 4
    }
    
    
    let padding: CGFloat = 20
}
