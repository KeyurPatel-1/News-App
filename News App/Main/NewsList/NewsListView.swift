//
//  NewsListView.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import SwiftUI

struct NewsListView: View {

    @ObservedObject var viewModel: NewsListViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 2)

    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.bodyWithoutModifier()
            .searchable(text: self.$viewModel.searchText, placement: .navigationBarDrawer)
            .navigationTitle("News")
            .task {
                self.viewModel.onAppear()
            }
    }

    @ViewBuilder
    func bodyWithoutModifier() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                Section {
                    if viewModel.isFetchingFromServer && viewModel.isEmptyList {
                        loadingView()
                    } else {
                        switch viewModel.selectedViewType {
                        case .list:
                            listView()
                        case .grid:
                            gridView()
                        }
                    }
                } header: {
                    headerView()
                }
                .padding(.horizontal)
            }
        }
        .refreshable { viewModel.onRefresh() }

    }

    @ViewBuilder
    func headerView() -> some View {
        let selectedViewType = self.viewModel.selectedViewType
        HStack(spacing: 12) {
            Spacer()

            Button {
                self.viewModel.onChangeViewType(.list)
            } label: {
                Image(selectedViewType == .list ? .selectedList : .list)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                    .foregroundStyle(Color.primary)
            }

            Button {
                self.viewModel.onChangeViewType(.grid)
            } label: {
                Image(selectedViewType == .grid ? .selectedMenu : .menu)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                    .foregroundStyle(Color.primary)
            }
        }

    }


    @ViewBuilder
    func loadingView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func listView() -> some View {
        ForEach(viewModel.newsList, id: \.self) { newsObj in
            NavigationLink(
                destination: NewsDetailsView(viewModel: .init(newsDetails: newsObj))
            ) {
                NewsListRowView(newsObj: newsObj)
            }
            .onAppear {
                if newsObj == viewModel.newsList.last {
                    viewModel.loadMoreNews()
                }
            }
        }


    }

    @ViewBuilder
    private func gridView() -> some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.newsList, id: \.self) { newsObj in
                NavigationLink(
                    destination: NewsDetailsView(viewModel: .init(newsDetails: newsObj))
                ) {
                    NewsListGridView(newsObj: newsObj)
                }
                .onAppear {
                    if newsObj == viewModel.newsList.last {
                        viewModel.loadMoreNews()
                    }
                }
            }
        }
    }
}

#Preview {
    NewsListView(viewModel: .init())
}

