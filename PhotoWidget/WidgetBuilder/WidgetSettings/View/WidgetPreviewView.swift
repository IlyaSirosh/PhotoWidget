//
//  WidgetPreviewView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit

struct WidgetPreviewView<Content: View>: View {
    let family: WidgetFamily
    let cornerRadius: CGFloat
    let content: () -> Content
    
    private let aspectRatio: CGFloat
    
    init(family: WidgetFamily, cornerRadius: CGFloat, content: @escaping () -> Content) {
        self.family = family
        self.content = content
        self.cornerRadius = cornerRadius
        self.aspectRatio = WidgetUtil.aspectRatio(for: family)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                content()
                    .cornerRadius(cornerRadius)
                    .frame(width: WidgetUtil.size(for: family, in: geometry.size).width)
                    .aspectRatio(aspectRatio, contentMode: .fit)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
    
}
