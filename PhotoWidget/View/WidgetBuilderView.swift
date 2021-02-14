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
    var data: PhotoWidgetData =  PhotoWidgetData(layout: PhotoWidgetSettings.mediumLayouts[0], photos: [0: URL(string: "https://images.unsplash.com/photo-1613141276543-74107d388095?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1001&q=80")!, 2: URL(string: "https://images.unsplash.com/photo-1612541831162-96d8fe7558f9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80")!])
    @State var layout: WidgetLayout = PhotoWidgetSettings.mediumLayouts[0]
    
    init() {
        self.layout = data.layout
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    WidgetPreviewView(family: family) {
                        PhotoWidgetView(config: data)
                    }
                    .shadow(color: Color.gray, radius: 20, x: -5, y: 10)
                    .aspectRatio(1, contentMode: .fit)
                    Spacer()
                }
                VStack{
                    Spacer()
                    WidgetSettingsView(family: family, layout: $layout, size: geometry.size)
                        .padding(.top, 25)
                        .background(Color("settingsBackground"))
                        .cornerRadius(25)
                }
            }

            .navigationBarTitle("Widget", displayMode: .inline)
            .navigationBarItems(trailing: WidgetFamilySelector(family: $family))
        }
    }

    
}

struct WidgetBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetBuilderView()
    }
}
