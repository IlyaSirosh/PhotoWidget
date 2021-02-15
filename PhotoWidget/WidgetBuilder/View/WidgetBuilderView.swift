//
//  WidgetBuilderView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 13.02.2021.
//

import SwiftUI
import WidgetKit


struct WidgetBuilderView: View {
    @EnvironmentObject var model: WidgetBuilderViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    WidgetPreviewView(family: model.family) {
                        PhotoWidgetView(config: model.widgetData)
                    }
                    .shadow(color: Color.gray, radius: 20, x: -5, y: 10)
                    .aspectRatio(1, contentMode: .fit)
                    Spacer()
                }
                VStack{
                    Spacer()
                    WidgetSettingsView(size: geometry.size)
                        .padding(.top, 25)
                        .background(Color("settingsBackground"))
                        .cornerRadius(25)
                }
            }

            .navigationBarTitle("Widget", displayMode: .inline)
            .navigationBarItems(trailing: DotsButton(action: model.toggleWidgetFamily))
        }
    }

    
}

struct WidgetBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetBuilderView()
    }
}
