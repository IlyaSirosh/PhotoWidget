//
//  PhotoWidgetView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 12.02.2021.
//

import SwiftUI
import URLImage

struct PhotoWidgetView: View {
    let config: PhotoWidgetData
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .opacity(0.90)
                .ignoresSafeArea()
            layoutViews(for: config.layout)
                .padding(Const.padding)
        }
    }
    
    @ViewBuilder
    func layoutViews(for viewLayout: WidgetLayout) -> some View {
        switch viewLayout {
        case .item(let index):
            AnyView(imageView(for: index))
        case .columns(let leftColumn, let rightColumn):
            HStack {
                leafViews(for: leftColumn)
                leafViews(for: rightColumn)
            }
        case .rows(let topRow, let bottomRow):
            VStack {
                leafViews(for: topRow)
                leafViews(for: bottomRow)
            }
        }
    }
    
    @ViewBuilder
    func leafViews(for viewLayout: WidgetLayout) -> some View {
        switch viewLayout {
        case .item(let index):
            AnyView(imageView(for: index))
        case .columns(.item(let index1), .item(let index2)):
            HStack {
                imageView(for: index1)
                imageView(for: index2)
            }
        case .rows(.item(let index1), .item(let index2)):
            VStack {
                imageView(for: index1)
                imageView(for: index2)
            }
        default:
            EmptyView()
        }
    }
 
    func imageView(for index: Int) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: Const.cornerRadius)
                    .foregroundColor(Color.white.opacity(0.1))
                if let photos = config.photos, let url = photos[index] {
                    URLImage(url: url) { (image: Image) in
                        image
                            .resizable()
                            .scaledToFill()
                            
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .cornerRadius(Const.cornerRadius)
                }
                Text(String(index))
                    .foregroundColor(.white)
            }
        }
        

    }
    
    struct Const {
        static var padding: CGFloat = 10
        static var cornerRadius: CGFloat = 15
    }
}

struct PhotoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
              RoundedRectangle(cornerRadius: 24, style: .continuous)
                  .fill(Color(.systemBackground))
            PhotoWidgetView(config: PhotoWidgetData(
                                layout: .columns(.rows(.item(0), .item(3)), .rows(.item(1), .item(2)))))
        }
        .preferredColorScheme(.light)
        .frame(width: 162*2, height: 162)
        .shadow(color: Color.gray, radius: 20, x: -5, y: 10)
    }
}
