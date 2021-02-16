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
                    WidgetPreviewView(family: model.family, cornerRadius: cornerRadius + 3) {
                        PhotoWidgetView(config: model.widgetData, photoShape: RoundedRectangle(cornerRadius: cornerRadius))
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
                        .cornerRadius(cornerRadius)
                }
            }

            .navigationBarTitle("Widget", displayMode: .inline)
            .navigationBarItems(trailing: DotsButton(action: model.toggleWidgetFamily))
        }
    }

    let cornerRadius: CGFloat = 25
}

struct WidgetBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetBuilderView()
    }
}
