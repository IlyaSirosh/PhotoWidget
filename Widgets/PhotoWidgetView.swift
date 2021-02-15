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
        GeometryReader { geo in
            ZStack {
                ContainerRelativeShape()
                    .fill(Color("backgroundColor").opacity(0.90))
                    .ignoresSafeArea()
                layoutViews(for: config.layout, size: geo.size)
                    .padding(padding(for: geo.size))
            }
        }
    }
    
    @ViewBuilder
    func layoutViews(for viewLayout: WidgetLayout, size: CGSize) -> some View {
        switch viewLayout {
        case .item(let index):
            AnyView(imageView(for: index, size: size))
        case .columns(let leftColumn, let rightColumn):
            HStack(spacing: padding(for: size)) {
                leafViews(for: leftColumn, size: size)
                leafViews(for: rightColumn, size: size)
            }
        case .rows(let topRow, let bottomRow):
            VStack(spacing: padding(for: size)) {
                leafViews(for: topRow, size: size)
                leafViews(for: bottomRow, size: size)
            }
        }
    }
    
    @ViewBuilder
    func leafViews(for viewLayout: WidgetLayout, size containerSize: CGSize) -> some View {
        switch viewLayout {
        case .item(let index):
            AnyView(imageView(for: index, size: containerSize))
        case .columns(.item(let index1), .item(let index2)):
            HStack(spacing: padding(for: containerSize)) {
                imageView(for: index1, size: containerSize)
                imageView(for: index2, size: containerSize)
            }
        case .rows(.item(let index1), .item(let index2)):
            VStack(spacing: padding(for: containerSize)) {
                imageView(for: index1, size: containerSize)
                imageView(for: index2, size: containerSize)
            }
        default:
            EmptyView()
        }
    }
 
    func imageView(for index: Int, size containerSize: CGSize) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius(for: containerSize))
//                ContainerRelativeShape() ???
                    .foregroundColor(Color.white.opacity(0.1))
                if let photos = config.photos, let url = photos[index] {
                    URLImage(url: url) { (image: Image) in
                        image
                            .resizable()
                            .scaledToFill()
                            
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .cornerRadius(cornerRadius(for: containerSize))
                }
                Text(String(index))
                    .foregroundColor(.white)
            }
        }
        

    }
    
    func cornerRadius(for size: CGSize) -> CGFloat {
        size.height / 10
    }
    
    func padding(for size: CGSize) -> CGFloat {
        7
        // TODO check for thumbnail mode to show with smaller/larger paddings
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
