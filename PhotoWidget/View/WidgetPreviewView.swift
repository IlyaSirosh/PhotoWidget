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
    let content: () -> Content
    
    private let aspectRatio: CGFloat
    
    init(family: WidgetFamily, content: @escaping () -> Content) {
        self.family = family
        self.content = content
        self.aspectRatio = WidgetUtil.aspectRatio(for: family)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                content()
                    .cornerRadius(20)
                    .frame(width: WidgetUtil.size(for: family, in: geometry.size).width)
                    .aspectRatio(aspectRatio, contentMode: .fit)
                    .shadow(color: Color.gray, radius: 20, x: -5, y: 10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
    
}
