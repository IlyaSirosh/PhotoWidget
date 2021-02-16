//
//  SettingsNavigationView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import SwiftUI

struct SettingsNavigationView<Content: View>: View {
    @StateObject var controller: SettingsNavigationController = SettingsNavigationController()
    let content: (@escaping (String, AnyView) -> Void, @escaping () -> Void) -> Content
    
    init(content: @escaping (@escaping (String, AnyView) -> Void, @escaping () -> Void) -> Content ) {
        self.content = content
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            Group {
                if let subview = controller.currentView {
                    subview.view
                } else {
                    content(controller.push(title:view:), controller.pop)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
  
            Group {
                Divider()
                ZStack {
                    
                    Text(controller.currentView?.title ?? "")
                        .font(.headline)
               
                    HStack {
                        Spacer()
                        Button(action: {
                            controller.pop()
                        }, label: {
                            Image(systemName: "multiply")
                                .padding(10)
                                .font(.headline)
                        })
                    }
                    
                }
                .frame(height: 40)
            }
            .opacity(controller.currentView != nil ? 1 : 0)

        }
    }
}
