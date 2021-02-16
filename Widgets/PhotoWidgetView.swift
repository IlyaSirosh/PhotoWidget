//
//  PhotoWidgetView.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 12.02.2021.
//

import SwiftUI

struct PhotoWidgetView<PhotoShape: Shape>: View {
    let config: PhotoWidgetData
    
    let photoShape: PhotoShape
    
    let spacing: CGFloat
    
    init(config: PhotoWidgetData, photoShape: PhotoShape, spacing: CGFloat = 8) {
        self.config = config
        self.photoShape = photoShape
        self.spacing = spacing
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ContainerRelativeShape()
                    .fill(Color("backgroundColor").opacity(0.90))
                    .ignoresSafeArea()
                layoutViews(for: config.layout, size: geo.size)
                    .padding(spacing)
            }
        }
    }
    
    @ViewBuilder
    func layoutViews(for viewLayout: WidgetLayout, size: CGSize) -> some View {
        switch viewLayout {
        case .item(let index):
            AnyView(imageView(for: index, size: size))
        case .columns(let leftColumn, let rightColumn):
            HStack(spacing: spacing) {
                leafViews(for: leftColumn, size: size)
                leafViews(for: rightColumn, size: size)
            }
        case .rows(let topRow, let bottomRow):
            VStack(spacing: spacing) {
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
            HStack(spacing: spacing) {
                imageView(for: index1, size: containerSize)
                imageView(for: index2, size: containerSize)
            }
        case .rows(.item(let index1), .item(let index2)):
            VStack(spacing: spacing) {
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
                photoShape
                    .foregroundColor(Color.white.opacity(0.1))
                if let photos = config.photos,
                   let url = photos[index],
                   let imageData = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(photoShape)
                }
            }
        }
        

    }
}

struct PhotoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
              RoundedRectangle(cornerRadius: 24, style: .continuous)
                  .fill(Color(.systemBackground))
            PhotoWidgetView(config: PhotoWidgetData(
                                layout: .columns(.rows(.item(0), .item(3)), .rows(.item(1), .item(2)))), photoShape: RoundedRectangle(cornerRadius: 25))
        }
        .preferredColorScheme(.light)
        .frame(width: 162*2, height: 162)
        .shadow(color: Color.gray, radius: 20, x: -5, y: 10)
    }
}
