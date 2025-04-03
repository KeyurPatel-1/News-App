//
//  SafariWebView.swift
//  News App
//
//  Created by Keyur Patel on 03/04/25.
//

import SwiftUI
import SafariServices


struct SafariWebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .blue
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
}
