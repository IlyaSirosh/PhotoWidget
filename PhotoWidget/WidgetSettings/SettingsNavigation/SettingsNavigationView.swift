//
//  SettingsNavigationView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 14.02.2021.
//

import SwiftUI

struct SettingsNavigationView<Content: View>: View {
    @ObservedObject var controller: SettingsNavigationController = SettingsNavigationController()
    let content: (@escaping (String, AnyView) -> Void, @escaping () -> Void) -> Content
    
    init(content: @escaping (@escaping (String, AnyView) -> Void, @escaping () -> Void) -> Content ) {
        self.content = content
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            if let subview = controller.currentView {
                subview.view
            } else {
                content(controller.push(title:view:), controller.pop)
            }
           
            VStack{
                Divider()
                HStack {
                    Spacer()
                    Text(controller.currentView?.title ?? "")
                        .font(.headline)
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
            .padding(.top, 10)
            .opacity(controller.currentView != nil ? 1 : 0)
        }
    }
}

//struct SettingsNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsNavigationView()
//    }
//}
