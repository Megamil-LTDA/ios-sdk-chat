//
//  ContentView.swift
//
//  Created by Eduardo dos santos on 01/11/24.
//
import SwiftUI
import Combine

public struct MegamilChatView: View {
    @State private var animate = true
    @State private var dragOffsetY: CGFloat = 0
    @GestureState private var isDragging = false
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []
    @State private var keyboardHeight: CGFloat = 0
    
    private var safeAreaHeight: CGFloat { (hasNotch() && !presentationStyle.isFullScreen) ? 34.0 : 0 }
    private var cornerRadius: CGFloat { hasNotch() ? (presentationStyle == .floating ? 32 : 60) : 0 }
    
    var backgroundColor: Color = .white
    var canDragging: Bool = true
    var showBorder: Bool = true
    var showReturnButton: Bool = true
    var themName: String = ""
    var presentationStyle: PresentationStyle = .fullscreen
    var onClose: (() -> Void)?
    
    public init(
        backgroundColor: Color = .white,
        canDragging: Bool = true,
        showBorder: Bool = true,
        showReturnButton: Bool = true,
        themName: String = "",
        presentationStyle: PresentationStyle = .fullscreen,
        onClose: (() -> Void)? = nil,
        messages: [ChatMessage] = []
    ) {
        self.backgroundColor = backgroundColor
        self.canDragging = canDragging
        self.showBorder = showBorder
        self.showReturnButton = showReturnButton
        self.themName = themName
        self.presentationStyle = presentationStyle
        self.onClose = onClose
        _messages = State(initialValue: messages)
    }
    
    public var body: some View {
        ZStack {
            contentView()
        }
        .padding(.all, presentationStyle == .floating ? 32 : 0)
        .padding(.bottom, keyboardHeight > 0 ? keyboardHeight : -safeAreaHeight)
        .onTapGesture {}
        .onAppear() {
            self.setupKeyboardObservers()
        }
        .onDisappear() {
            self.removeKeyboardObservers()
        }
    }
    
    private func contentView() -> some View {
        VStack {
            Spacer()
            
            ZStack(alignment: .top) {
                innerContentView()
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
    
    private func innerContentView() -> some View {
        ZStack {
            backgroundContentView()
                .overlay(contentOverlay())
        }
        .offset(y: dragOffsetY)
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
    
    private func messageScrollView() -> some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(messages.indices.reversed(), id: \.self) { index in
                        HStack {
                            let message = messages[index]
                            if(message.isFromMe) {
                                MessageBubble(message: message, backgroundColor: .blue, textColor: .white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .scaleEffect(y: -1)
                            } else {
                                MessageBubble(message: message, backgroundColor: .green, textColor: .white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .scaleEffect(y: -1)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 4)
                    }
                }
                .scaleEffect(y: -1)
                .padding(.top, 10)
                .onChange(of: messages) { newMessages in
                    if let lastMessageIndex = newMessages.indices.last {
                        withAnimation {
                            scrollProxy.scrollTo(lastMessageIndex, anchor: .bottom)
                        }
                    }
                }
                .padding(.bottom, 80)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func chatInput() -> some View {
        ChatInput(
            messageText: $messageText,
            placeholder: "Digite uma mensagem...",
            buttonColor: Color.blue,
            borderColor: [Color.red, Color.blue, Color.green],
            showBorder: true,
            borderWidth: 1,
            onSend: {
                if !messageText.isEmpty && messageText != "" {
                    messages.append(ChatMessage(text: messageText, timestamp: DateHelper.formatCurrentDateTime(), isFromMe: true))
                    messageText = ""
                }
            },
            onRecord: {
                SafePrint("Iniciar gravação de áudio")
            },
            onKeyboardOpen: { isOpen in
                SafePrint("Teclado aberto")
            },
            allowAudioRecording: true
        )
        .padding(.bottom, 22)
    }
    
    private func borderView() -> some View {
        BorderedColorsView(
            cornerRadius: cornerRadius,
            borderWidth: 6
        )
        .frame(width: presentationStyle == .floating ? UIScreen.main.bounds.width * 0.9 : UIScreen.main.bounds.width, height: presentationStyle.sheetHeight())
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .offset(y: dragOffsetY)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                var fixHeight = 0.0
                switch presentationStyle {
                    case .fullscreen:
                        fixHeight = 0.0
                        SafePrint("fullscreen")
                    case .floating:
                        fixHeight = 30.0
                        SafePrint("floating")
                    case .largeBottomSheet:
                        fixHeight = 60.0
                        SafePrint("largeBottomSheet")
                    case .mediumBottomSheet:
                        fixHeight = 100.0
                        SafePrint("mediumBottomSheet")
                    case .smallBottomSheet:
                        fixHeight = 240.0
                        SafePrint("smallBottomSheet")
                }
                keyboardHeight = keyboardFrame.height - fixHeight
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
