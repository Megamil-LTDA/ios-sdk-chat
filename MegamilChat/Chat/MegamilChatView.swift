    //
    //  ContentView.swift
    //  sample_megamil_chat_ios
    //
    //  Created by Eduardo dos santos on 01/11/24.
    //
import SwiftUI

struct MegamilChatView: View {
    @State private var animate = true
    @State private var dragOffsetY: CGFloat = 0
    @GestureState private var isDragging = false
    @State private var messageText: String = ""
    @State private var messages: [String] = []
    
    private var safeAreaHeight: CGFloat { (hasNotch() && !presentationStyle.isFullScreen) ? 34.0 : 0 }
    private var cornerRadius: CGFloat { hasNotch() ? (presentationStyle == .floating ? 32 : 60) : 0 }
    
    var backgroundColor: Color = .white
    var canDragging: Bool = true
    var showBorder: Bool = true
    var showReturnButton: Bool = true
    var themName: String = ""
    var presentationStyle: PresentationStyle = .fullscreen
    var onClose: (() -> Void)?
    
    var body: some View {
        ZStack {
            contentView()
        }
        .padding(.all, presentationStyle == .floating ? 32 : 0)
        .padding(.bottom, -safeAreaHeight)
        .onTapGesture {}
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
                            MessageBubble(text: messages[index], backgroundColor: .blue, textColor: .white, isFromMe: true, timestamp: "Agora")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .scaleEffect(y: -1)
                            
                                // MessageBubble(text: "\(themName): \(messages[index])", backgroundColor: .green, textColor: .white, isFromMe: false, timestamp: "02/11/2024 15:00")
                                //     .frame(maxWidth: .infinity, alignment: .leading)
                                //     .scaleEffect(y: -1)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 4)
                    }
                }
                .scaleEffect(y: -1)
                .padding(.top, 10)
                .onChange(of: messages) { newMessages, oldMessages in
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
                if !messageText.isEmpty {
                    messages.append(messageText)
                    messageText = ""
                }
            },
            onRecord: {
                print("Iniciar gravação de áudio")
            },
            onKeyboardOpen: { isOpen in
                    // Placeholder for keyboard open logic
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
}

struct MegamilChatViewPreviews: PreviewProvider {
    static var previews: some View {
        MegamilChatView(
            backgroundColor: .white,
            canDragging: false,
            showBorder: true,
            presentationStyle: .largeBottomSheet,
            onClose: {}
        )
    }
}
