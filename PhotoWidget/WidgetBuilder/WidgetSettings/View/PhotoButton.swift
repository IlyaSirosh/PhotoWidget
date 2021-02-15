//
//  PhotoButton.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import SwiftUI
import URLImage

struct PhotoButton: View {
    private let onAdd: () -> Void
    private let onRemove: () -> Void
    let url: URL?
    @State var state: PhotoButtonState = .empty
    
    init(url: URL?, onAdd: @escaping () -> Void, onRemove: @escaping () -> Void) {
        self.url = url
        self.onAdd = onAdd
        self.onRemove = onRemove
        self.state = url != nil ? .hasPhoto : .empty
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geo in
            if url == nil {
                Button(action: {
                    onAdd()
                    state = .empty
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke()
                            .foregroundColor(.gray)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: size, height: size)
                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                    }
                }
            } else {
      
                URLImage(url: url!) { (image: Image) in
                    image
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: size, height: size)
                .aspectRatio(1, contentMode: .fit)
                .clipped()
                .cornerRadius(20)
                .overlay( Group {
                    if state == .canRemove {
                        Button(action: onRemove, label: {
                            Image(systemName: "multiply.circle")
                                .font(.title)
                                .background(Color.black)
                                .clipShape(Circle())
                        })
                    }
                }, alignment: .topTrailing)
                .onTapGesture {
                    switch state {
                    case .canRemove:
                        state = .hasPhoto
                    default:
                        state = .canRemove
                    }
                }

            }
        }
    }
    
    let size: CGFloat = 90
    
    enum PhotoButtonState: String {
        case empty, hasPhoto, canRemove
    }
}

struct PhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotoButton(url: nil, onAdd: {}, onRemove: {})
    }
}
