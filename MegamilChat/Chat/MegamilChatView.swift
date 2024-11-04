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
    
    private var safeAreaHeight: CGFloat { (hasNotch() && !presentationStyle.isFullScreen) ? 34.0 : 0 }
    private var cornerRadius: CGFloat { hasNotch() ? (presentationStyle == .floating ? 32 : 60) : 0 }
    
    var backgroundColor: Color
    var canDragging: Bool
    var showBorder: Bool
    var showInputBorder: Bool
    var showReturnButton: Bool
    var themName: String
    var presentationStyle: PresentationStyle
    var onClose: (() -> Void)?
    var viewModel: ChatViewModel
    
    var placeholder: String
    var sendButtonIcon: String
    var recordButtonIcon: String
    var buttonColor: Color
    var borderColor: [Color]
    var borderInputColor: [Color]
    
    var allowAudioRecording: Bool
    var meBubbleColor: Color
    var meBubbleTextColor: Color
    var themBubbleColor: Color
    var themBubbleTextColor: Color
    
    
    public init(
        backgroundColor: Color = .white,
        canDragging: Bool = true,
        showBorder: Bool = true,
        showInputBorder: Bool = true,
        showReturnButton: Bool = true,
        themName: String = "",
        presentationStyle: PresentationStyle = .fullscreen,
        onClose: (() -> Void)? = nil,
        messages: [ChatMessage] = [],
        suggestions: [String] = [],
        
        placeholder: String = "Digite uma mensagem...",
        sendButtonIcon: String = "paperplane.fill",
        recordButtonIcon: String = "mic.fill",
        buttonColor: Color = Color.blue,
        borderColor: [Color] = [Color.green, Color.blue, Color.red],
        borderInputColor: [Color] = [Color.orange, Color.pink, Color.gray],
        
        ref: String = "",
        name: String = "",
        contact: String = "",
        baseUrl: String = "",
        endpoint: String = "",
        bearerToken: String,
        allowAudioRecording: Bool = false,
        typeEndPoints: TypeEndPoints = .MegamilChat,
        meBubbleColor: Color = .blue,
        meBubbleTextColor: Color = .white,
        themBubbleColor: Color = .green,
        themBubbleTextColor: Color = .white
    ) {
        self.backgroundColor = backgroundColor
        self.canDragging = canDragging
        self.showBorder = showBorder
        self.showInputBorder = showInputBorder
        self.showReturnButton = showReturnButton
        self.themName = themName
        self.presentationStyle = presentationStyle
        self.onClose = onClose
        self.allowAudioRecording = allowAudioRecording
        self.meBubbleColor = meBubbleColor
        self.meBubbleTextColor = meBubbleTextColor
        self.themBubbleColor = themBubbleColor
        self.themBubbleTextColor = themBubbleTextColor
        self.placeholder = placeholder
        self.sendButtonIcon = sendButtonIcon
        self.recordButtonIcon = recordButtonIcon
        self.buttonColor = buttonColor
        self.borderColor = borderColor
        self.borderInputColor = borderInputColor
        
        _suggestions = State(initialValue: suggestions)
        _messages = State(initialValue: messages)
        viewModel = ChatViewModel(baseUrl: baseUrl, endpoint: endpoint, ref: ref, name: name, contact: contact, bearerToken: bearerToken, typeEndPoints: typeEndPoints)
        
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
                    if showBorder {
                        borderView()
                    }
                }
                .gesture(
                    presentationStyle.isBottomSheet && canDragging ?
                    createDragGesture(onClose: onClose ?? {}, dragOffsetY: $dragOffsetY, isDragging: $isDragging)
                    : nil
                )
                .edgesIgnoringSafeArea(presentationStyle == .fullscreen ? .all : .bottom)
            }
        }
        .padding(.all, presentationStyle == .floating ? 32 : 0)
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
        backgroundColor
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .frame(height: presentationStyle.sheetHeight())
    }
    
    private func contentOverlay() -> some View {
        VStack(spacing: 0) {
            if presentationStyle.isBottomSheet && canDragging {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(.gray)
                    .padding(.top, 32)
            }
            
            if showReturnButton {
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
                Image(systemName: presentationStyle == .fullscreen ? "arrow.left" : "xmark")
                    .foregroundColor(.gray)
                    .padding()
            }
            Spacer()
        }
        .padding(.top, presentationStyle.isBottomSheet && canDragging ? -8 : presentationStyle.isFullScreen ? 42 : 16)
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
            colors: borderColor
        )
        .frame(width: presentationStyle == .floating ? UIScreen.main.bounds.width * 0.9 : UIScreen.main.bounds.width, height: presentationStyle.sheetHeight())
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .offset(y: dragOffsetY)
    }
    
}
