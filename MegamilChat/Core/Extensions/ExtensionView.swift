//
//  ExtensionView.swift
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

struct OnChangeCompatModifier<T: Equatable>: ViewModifier {
    let value: T
    let action: (T) -> Void
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content.onChange(of: value) { _, newValue in
                action(newValue)
            }
        } else {
            content.onChange(of: value) { newValue in
                action(newValue)
            }
        }
    }
}

public extension View {
    func onChangeCompat<T: Equatable>(of value: T, perform action: @escaping (T) -> Void) -> some View {
        self.modifier(OnChangeCompatModifier(value: value, action: action))
    }
    
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
        closeOnTap: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                content()
                    .background(Color.black.opacity(0.4))
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                    .zIndex(1)
                    .onTapGesture {
                        if(closeOnTap) {
                            isPresented.wrappedValue = false
                        }
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
