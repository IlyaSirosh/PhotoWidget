//
//  WidgetSettingsView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit

struct WidgetSettingsView: View {  
    var size: CGSize
    
    
    var body: some View {
        VStack {
                SettingsNavigationView { (push, pop) in
                    HStack(spacing: padding) {
                        BuilderButton(title: "Layout", action: {
                            let view = LayoutSettingsView(size: size)
                            push("Layout", AnyView(view))
                        }) {
                            Image(systemName: "uiwindow.split.2x1")
                                .resizable()
                                .rotationEffect(.degrees(90))
                        }

                        BuilderButton(title: "Photos", action: {
                            push("Photos", AnyView(PhotoSettingsView(size: size)))
                        }) {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .foregroundColor(.white)
    
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, idealHeight: heigth(for: size), alignment: .center)
        .environment(\.buttonWidth, buttonWidth(for: size))
        .environment(\.buttonCornerRadius, cornerRadius(for: size))
        .environment(\.buttonSpacing, padding)
    }
    

    let padding:CGFloat = 20
    
    
    private func buttonWidth(for size: CGSize) -> CGFloat {
        let availabelWidth = size.width -  5 * padding
        return availabelWidth / 4
    }
    
    private func heigth(for size: CGSize) -> CGFloat {
        return buttonWidth(for: size) + 3 * padding
    }
    
    private func cornerRadius(for size: CGSize) -> CGFloat {
        buttonWidth(for: size) / 5
    }
}
