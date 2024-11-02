//
//  ExtensionView.swift
//  sample_megamil_chat_ios
//
//  Created by Eduardo dos santos on 01/11/24.
//
import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func hasNotch() -> Bool {
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        let topInset = keyWindow?.safeAreaInsets.top ?? 0
        return topInset > 20
    }
    
    func fullScreenModal<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self // A view de fundo que fica atrás do modal
            
            if isPresented.wrappedValue {
                content()
                    .background(Color.black.opacity(0.4)) // Adiciona um fundo com opacidade ao modal
                    .transition(.opacity.animation(.easeInOut(duration: 0.3))) // Efeito de transição suave
                    .zIndex(1) // Garante que o modal fique acima da view de fundo
                    .onTapGesture {
                            // Fechar o modal ao tocar fora
                        isPresented.wrappedValue = false
                    }
            }
        }
    }

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        padding: EdgeInsets = EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 0),
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
                    .padding(padding)
            }
            self
        }
    }


    func createDragGesture(onClose: @escaping () -> Void, dragOffsetY: Binding<CGFloat>, isDragging: GestureState<Bool>) -> some Gesture {
        DragGesture()
            .updating(isDragging) { value, state, _ in
                state = true
                if value.translation.height < 0 {
                    dragOffsetY.wrappedValue = value.translation.height * 0.3
                } else {
                    dragOffsetY.wrappedValue = max(value.translation.height, 0)
                }
            }
            .onEnded { value in
                if value.translation.height > 100 {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        dragOffsetY.wrappedValue = UIScreen.main.bounds.height
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Espera a animação terminar
                        onClose()
                    }
                } else {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        dragOffsetY.wrappedValue = 0
                    }
                }
            }
    }

    
}
