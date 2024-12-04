//
//  BorderedColorsView.swift
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

// TODO: Otimizar desempenho. Testar a animação em iPhones com notch, sem notch e com Dynamic Island para garantir compatibilidade e fluidez.
public struct BorderedColorsView: View {
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat
    public var usingAnimation: Bool = false
    @State private var animationAngle: Double = 0
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
        self.colors = colors.map { $0.opacity(0.8) }
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
                            angle: .degrees(animationAngle)
                        ),
                        lineWidth: borderWidth
                    )
                    .blur(radius: 7)
            )
            .onAppear {
                if usingAnimation {
                    startAnimation()
                }
            }
    }
    
    private func startAnimation() {
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
                animationAngle += 0.5
                if !usingAnimation {
                    timer.invalidate()
                }
            }
        }
    }
}
