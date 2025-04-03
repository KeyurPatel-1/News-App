//
//  UIElement+extension.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import Foundation
import SwiftUI

extension View {

    func roundedCornerWithBorder(color: Color = .clear, radius: CGFloat = 8.0, lineWidth: CGFloat = 1) -> some View {
        self
        .overlay {
            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .stroke(color, lineWidth: lineWidth)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: radius, style: .continuous)
        )
    }

}
