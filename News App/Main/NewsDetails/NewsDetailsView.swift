//
//  NewsDetailsView.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import SwiftUI

struct NewsDetailsView: View {

    @ObservedObject var viewModel: NewsDetailsViewModel
    @State private var isShowingSafari = false

    init(viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        bodyWithoutModifier()
    }

    @ViewBuilder
    func bodyWithoutModifier() -> some View {
        let news = viewModel.newsDetails

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                AsyncImageView(urlString: news.urlToImage, failedImage: "news-placeholder")
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .roundedCornerWithBorder()

                HStack {
                    news.author.convertToView {
                        Text("🖊️ \($0)")
                            .font(.caption)
                            .bold()
                    }

                    Spacer()
                    DateFormatterService.shared.format(news.publishedAt).convertToView {
                        Text("📅 \($0)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.gray)
                    }

                }

                Divider()

                Group {
                    self.newsDetails()
                }
                .multilineTextAlignment(.leading)


            }
            .padding()
        }

        actionButtons(for: news.url)

    }

    @ViewBuilder
    func newsDetails() -> some View {
        let news = viewModel.newsDetails

        news.title.convertToView {
            Text($0)
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
        }

        news.description.convertToView {
            Text($0)
                .font(.body)
                .foregroundColor(.secondary)
        }

        news.content.convertToView {
            Text($0)
                .font(.caption)
                .foregroundColor(.gray)
        }

    }

    @ViewBuilder
    private func actionButtons(for urlString: String?) -> some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            VStack(spacing: 16) {

                Divider()

                HStack(spacing: 16) {
                    Button {
                        isShowingSafari = true
                    } label: {
                        Text("Read Full Article")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .roundedCornerWithBorder(color: .clear)
                    }

                    Button(action: {
                        shareArticle(url)
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $isShowingSafari) {
                    SafariWebView(url: url)
                }
            }
        }

    }

    private func shareArticle(_ url: URL) {
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            topVC.present(activityController, animated: true, completion: nil)
        }
    }
}

#Preview {
    NewsDetailsView(viewModel: .init(newsDetails: .init(author: "test", content: "test", description: "test", publishedAt: "", source: .init(id: "1", name: "qw"), title: "", url: "", urlToImage: "")))
}

