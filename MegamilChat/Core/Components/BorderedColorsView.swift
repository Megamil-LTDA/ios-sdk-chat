//
//  BorderedColorsView.swift
//  sample_megamil_chat_ios
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

struct BorderedColorsView: View {
    var cornerRadius: CGFloat
    var borderWidth: CGFloat
    @State private var startAnimation = false
    var colors: [Color] = [
        Color.red.opacity(0.5),
        Color.orange.opacity(0.5),
        Color.yellow.opacity(0.5),
        Color.green.opacity(0.5),
        Color.blue.opacity(0.5),
        Color.purple.opacity(0.5),
        Color.pink.opacity(0.5),
        Color.red.opacity(0.5)
    ]
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: colors),
                            center: .center,
                            angle: .degrees(startAnimation ? 360 : 0)
                        ),
                        lineWidth: borderWidth
                    )
                    .blur(radius: 3)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 8)
                    .repeatForever(autoreverses: false)) {
                        startAnimation = true
                    }
            }
    }
}
