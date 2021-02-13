//
//  WidgetBuilderView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit


struct WidgetBuilderView: View {
    private var selectedFamily: Int {
        family.rawValue
    }
    @State var family: WidgetFamily = .systemMedium
    var data: PhotoWidgetData =  PhotoWidgetData(layout: PhotoWidgetSettings.largeLayouts[0], photos: [0: URL(string: "https://images.unsplash.com/photo-1613141276543-74107d388095?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1001&q=80")!])
    
    init() {

    }
    
    var body: some View {

            VStack {
                WidgetPreviewView(family: family) {
                    PhotoWidgetView(config: data)
                }
                .aspectRatio(1, contentMode: .fit)

                Spacer()
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .ignoresSafeArea(.all, edges: .bottom)
                        .foregroundColor(Color.black.opacity(0.7))
                    WidgetSettingsView()
                }
            }
            .navigationBarTitle("Widget", displayMode: .inline)
            .navigationBarItems(trailing: WidgetFamilySelector(family: $family))
        }

    
}

struct WidgetBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetBuilderView()
    }
}
