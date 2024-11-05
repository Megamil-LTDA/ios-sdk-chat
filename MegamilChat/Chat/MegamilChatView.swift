//
//  ContentView.swift
//
//  Created by Eduardo dos santos on 01/11/24.
//
import SwiftUI
import Combine

public struct MegamilChatView: View {
    @State internal var animate = true
    @State internal var dragOffsetY: CGFloat = 0
    @GestureState internal var isDragging = false
    @State internal var messageText: String = ""
    @State internal var messages: [ChatMessage] = []
    @State internal var suggestions: [String] = []
    @State internal var keyboardHeight: CGFloat = 0
    var onClose: (() -> Void)?
    private var safeAreaHeight: CGFloat { (hasNotch() && !config.presentationStyle.isFullScreen) ? 34.0 : 0 }
    private var cornerRadius: CGFloat { hasNotch() ? (config.presentationStyle == .floating ? 32 : 60) : 0 }
    
    var config: MegamilChatConfig
    var viewModel: ChatViewModel
    
    public init(config: MegamilChatConfig, onClose: (() -> Void)?) {
        self.config = config
        self.onClose = onClose
        self._messages = State(initialValue: config.messages)
        self._suggestions = State(initialValue: config.suggestions)
        self.viewModel = ChatViewModel(baseUrl: config.baseUrl, endpoint: config.endpoint, ref: config.ref, name: config.name, contact: config.contact, bearerToken: config.bearerToken, typeEndPoints: config.typeEndPoints)
    }
    
    public var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                ZStack(alignment: .top) {
                    ZStack {
                        backgroundContentView()
                            .overlay(contentOverlay())
                    }
                    .offset(y: dragOffsetY)
                    if config.showBorder {
                        borderView()
                    }
                }
                .gesture(
                    config.presentationStyle.isBottomSheet && config.canDragging ?
                    createDragGesture(onClose: onClose ?? {}, dragOffsetY: $dragOffsetY, isDragging: $isDragging)
                    : nil
                )
                .edgesIgnoringSafeArea(config.presentationStyle == .fullscreen ? .all : .bottom)
            }
        }
        .padding(.all, config.presentationStyle == .floating ? 32 : 0)
        .padding(.bottom, keyboardHeight > 0 ? keyboardHeight : -safeAreaHeight)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear() {
            self.setupKeyboardObservers()
        }
        .onDisappear() {
            self.removeKeyboardObservers()
        }
    }
    
    private func backgroundContentView() -> some View {
        config.backgroundColor
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .frame(height: config.presentationStyle.sheetHeight())
    }
    
    private func contentOverlay() -> some View {
        VStack(spacing: 0) {
            if config.presentationStyle.isBottomSheet && config.canDragging {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(.gray)
                    .padding(.top, 32)
            }
            
            if config.showReturnButton {
                returnButton()
            } else {
                emptyView()
            }
            
            messageScrollView()
            
            Spacer()
            
            chatInput()
        }
    }
    
    private func returnButton() -> some View {
        HStack {
            Button(action: {
                onClose?()
            }) {
                Image(systemName: config.presentationStyle == .fullscreen ? "arrow.left" : "xmark")
                    .foregroundColor(.gray)
                    .padding()
            }
            Spacer()
        }
        .padding(.top, config.presentationStyle.isBottomSheet && config.canDragging ? -8 : config.presentationStyle.isFullScreen ? 42 : 16)
        .padding(.leading, 12)
    }
    
    private func emptyView(height: CGFloat = 100) -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: height)
    }
    
    private func borderView() -> some View {
        BorderedColorsView(
            cornerRadius: cornerRadius,
            borderWidth: 6,
            colors: config.borderColor
        )
        .frame(width: config.presentationStyle == .floating ? UIScreen.main.bounds.width * 0.9 : UIScreen.main.bounds.width, height: config.presentationStyle.sheetHeight())
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .offset(y: dragOffsetY)
    }
    
}
