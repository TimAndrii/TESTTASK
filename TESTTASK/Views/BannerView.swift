//
//  BannerView.swift
//  TESTTASK
//
//  Created by Andrii Tymoshchuk on 27.05.2025.
//

import SwiftUI

struct BannerView: View {
    let title: String

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.YellowAppColor)
            .padding(.top, 1)
    }
}
