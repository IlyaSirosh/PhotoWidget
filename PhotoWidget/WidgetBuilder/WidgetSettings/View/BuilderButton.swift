//
//  BuilderButton.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI

struct BuilderButton<Content: View>: View {
    @Environment(\.buttonWidth) var buttonWidth
    @Environment(\.buttonCornerRadius) var buttonCornerRadius
    
    var title: String?
    let content: () -> Content
    let action: () -> Void
    
    init(title: String? = nil, action: @escaping () -> Void, content: @escaping () -> Content) {
        self.title = title
        self.content = content
        self.action = action
    }

    var body: some View {
        Button(action: action)  {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: buttonCornerRadius)
                        .frame(width: buttonWidth, height: buttonWidth)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(Color.white.opacity(0.1))
                    content()
                        .frame(width: contentSize, height: contentSize, alignment: .center)
                        .foregroundColor(.white)
                        .font(.system(size: contentSize, weight: .semibold, design: .rounded))
                }
                if let text = title {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
            }
        }
    }
    
    let contentSize: CGFloat = 30
}

struct BuilderButton_Previews: PreviewProvider {
    static var previews: some View {
        BuilderButton(
            title: "Photos", action: {}) {
            Image("photo")
                .resizable()
        }
    }
}
