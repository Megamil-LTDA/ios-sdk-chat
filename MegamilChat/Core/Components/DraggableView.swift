//
//  DraggableView.swift
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

struct DraggableView<Content: View>: View {
    @Binding var dragOffsetY: CGFloat
    var onClose: (() -> Void)?
    var content: () -> Content
    
    @GestureState private var isDragging = false
    
    var body: some View {
        content()
            .offset(y: dragOffsetY)
            .gesture(
                DragGesture()
                    .updating($isDragging) { value, state, _ in
                        state = true
                        if value.translation.height < 0 {
                            dragOffsetY = value.translation.height * 0.3
                        } else {
                            dragOffsetY = max(value.translation.height, 0)
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 {
                            onClose?()
                        } else {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                dragOffsetY = 0
                            }
                        }
                    }
            )
    }
}
