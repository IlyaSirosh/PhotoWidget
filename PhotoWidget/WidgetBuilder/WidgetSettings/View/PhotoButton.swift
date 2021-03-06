//
//  PhotoButton.swift
//  PhotoWidget
//
//  Created by Illya Sirosh on 15.02.2021.
//

import SwiftUI
import URLImage

struct PhotoButton: View {
    @Environment(\.buttonWidth) var buttonWidth
    @Environment(\.buttonCornerRadius) var buttonCornerRadius
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
        
        if url == nil {
            Button(action: {
                onAdd()
                state = .empty
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: buttonCornerRadius)
                        .stroke()
                        .foregroundColor(.gray)
                        .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
                        .aspectRatio(1, contentMode: .fit)
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
            .aspectRatio(1, contentMode: .fit)
            .frame(width: buttonWidth, height: buttonWidth, alignment: .center)
            .clipped()
            .cornerRadius(buttonCornerRadius)
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
    
    enum PhotoButtonState: String {
        case empty, hasPhoto, canRemove
    }
}

struct PhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotoButton(url: nil, onAdd: {}, onRemove: {})
    }
}
