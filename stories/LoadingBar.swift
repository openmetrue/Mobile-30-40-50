//
//  LoadingBar.swift
//  stories
//
//  Created by Mark Khmelnitskii on 05.06.2022.
//

import SwiftUI

struct LoadingBar: View {
    var progress: CGFloat
    var index: Int
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 1)
                    .foregroundColor(Color.white)
                    .opacity(0.1)
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: geometry.size.width * min(max(progress - CGFloat(index), 0), 1),
                           alignment: .leading)
                    .foregroundColor(Color.white)
            }
            .frame(height: 2)
        }
    }
}
