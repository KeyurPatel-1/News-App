//
//  NewsListRowView.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import SwiftUI

struct NewsListRowView: View {
    let newsObj: NewsListModel.Article

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AsyncImageView(urlString: newsObj.urlToImage, failedImage: "news-placeholder")
                .scaledToFill()
                .frame(width: 80, height: 80)
                .roundedCornerWithBorder()

            VStack(alignment: .leading, spacing: 8) {
                newsObj.title.convertToView {
                    Text($0)
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }


                newsObj.description.convertToView {
                    Text($0)
                        .foregroundStyle(Color.secondary)
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .padding()
        .roundedCornerWithBorder(color: .secondary)
    }
}

#Preview {
    NewsListRowView(newsObj: .init(author: "test", content: "test", description: "test", publishedAt: "", source: .init(id: "1", name: "qw"), title: "", url: "", urlToImage: ""))
}
