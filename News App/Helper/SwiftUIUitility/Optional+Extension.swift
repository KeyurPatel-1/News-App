//
//  Optional+Extension.swift
//  News App
//
//  Created by Keyur Patel on 02/04/25.
//

import SwiftUI

extension Optional {

    @ViewBuilder
    func convertToView(@ViewBuilder block: (Wrapped) -> some View) -> some View {
        if let unwrapped = self {
            block(unwrapped)
        }
    }
}
