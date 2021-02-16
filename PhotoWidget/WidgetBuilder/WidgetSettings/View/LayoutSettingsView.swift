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

    @Environment(\.buttonWidth) var buttonWidth: CGFloat
    @Environment(\.buttonCornerRadius) var buttonCornerRadius: CGFloat
    @Environment(\.buttonSpacing) var buttonSpacing: CGFloat
    
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
            LazyVGrid(columns: [ GridItem(.adaptive(minimum: 100)) , GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: buttonSpacing) {
                content()
            }
        } else {
            HStack(spacing: buttonSpacing) {
                content()
            }
        }
    }
    
    func widget(for layout: WidgetLayout) -> some View {
        PhotoWidgetView(config: PhotoWidgetData(layout: layout), photoShape: RoundedRectangle(cornerRadius: buttonCornerRadius - 2), spacing: 4)
            .clipShape(RoundedRectangle(cornerRadius: buttonCornerRadius))
            .padding(0.5)
            .frame(width: width(for: size))
            .background(self.layout == layout ? Color.white : Color.white.opacity(0.1))
            .cornerRadius(buttonCornerRadius)
            .aspectRatio(WidgetUtil.aspectRatio(for: family), contentMode: .fit)
            .onTapGesture{
                widgetBuilder.select(layout: layout)
            }
    }
    
    func width(for size: CGSize) -> CGFloat {
        if family == .systemMedium {
            return (size.width - 3*buttonSpacing) / 2
        } else {
            return buttonWidth
        }
        
    }
}
