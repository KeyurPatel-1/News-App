//
//  AsyncImageView.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import SwiftUI

struct AsyncImageView: View {
    let urlString: String?
    let failedImage: String?

    init(urlString: String?, failedImage: String? = nil) {
        self.urlString = urlString
        self.failedImage = failedImage
    }

    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    VStack(alignment: .center) {
                        Spacer()
                        ProgressView() // Default SwiftUI Loader
                            .frame(width: 50, height: 50)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)

                case .success(let image):
                    image
                        .resizable()

                case .failure:
                    failedImageView


                @unknown default:
                    failedImageView
                }
            }
        } else {
            failedImageView
        }
    }

    var failedImageView: some View {
        Image(failedImage ?? "profile_blank")
            .resizable()
            .scaledToFill()
    }
}

#Preview {
    AsyncImageView(urlString: "")
}
