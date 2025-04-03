//
//  News_AppApp.swift
//  News App
//
//  Created by Keyur Patel on 01/04/25.
//

import SwiftUI

@main
struct News_AppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NewsListView(viewModel: .init())
            }
        }
    }
}
