//
//  OffsetModifier.swift
//  HeaderCollapsable
//
//  Created by Eduardo Martin Lorenzo on 16/6/22.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Task {
                        self.offset = minY
                    }
                    
                    return Color.clear
                }
                , alignment: .top
            )
    }
}
