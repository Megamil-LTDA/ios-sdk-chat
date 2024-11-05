//
//  BorderedColorsView.swift
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

public struct BorderedColorsView: View {
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat
    public var usingAnimation: Bool = false
    @State private var startAnimation = false
    public var colors: [Color] = [
        Color.red.opacity(0.5),
        Color.orange.opacity(0.5),
        Color.yellow.opacity(0.5),
        Color.green.opacity(0.5),
        Color.blue.opacity(0.5),
        Color.purple.opacity(0.5),
        Color.pink.opacity(0.5),
        Color.red.opacity(0.5)
    ]
    
    public init(cornerRadius: CGFloat, borderWidth: CGFloat, usingAnimation: Bool = false, colors: [Color] = [
        Color.red.opacity(0.5),
        Color.orange.opacity(0.5),
        Color.yellow.opacity(0.5),
        Color.green.opacity(0.5),
        Color.blue.opacity(0.5),
        Color.purple.opacity(0.5),
        Color.pink.opacity(0.5),
        Color.red.opacity(0.5)
    ]) {
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.usingAnimation = usingAnimation
        self.colors = colors
    }
    
    public var body: some View {
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
                        if(usingAnimation) {
                            startAnimation = true
                        }
                    }
            }
    }
}
