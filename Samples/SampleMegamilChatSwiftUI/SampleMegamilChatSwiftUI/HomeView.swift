//
//  HomeView.swift
//  Megamil
//
//  Created by Eduardo dos santos on 30/10/24.
//  Copyright © 2024 Megamil. All rights reserved.
//
import SwiftUI
import MegamilChat

struct HomeView: View {
    @State private var presentationStyle: PresentationStyle = .fullscreen
    @State private var isChatViewActive = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Button("Abrir chat tela cheia") {
                        presentationStyle = .fullscreen
                        isChatViewActive = true
                    }
                    .padding()
                    
                    Button("Abrir chat - Bottom Sheet Grande") {
                        presentationStyle = .largeBottomSheet
                        isChatViewActive = true
                    }
                    .padding()
                    
                    Button("Abrir chat - Bottom Sheet Médio") {
                        presentationStyle = .mediumBottomSheet
                        isChatViewActive = true
                    }
                    .padding()
                    
                    Button("Abrir chat - Bottom Sheet Pequeno") {
                        presentationStyle = .smallBottomSheet
                        isChatViewActive = true
                    }
                    .padding()
                    
                    Button("Abrir chat - Flutuante") {
                        presentationStyle = .floating
                        isChatViewActive = true
                    }
                    .padding()
                }
                .padding()
//                    .fullScreenCover(isPresented: $isChatViewActive) {
                .fullScreenModal(isPresented: $isChatViewActive) {
                    MegamilChatView(
                        backgroundColor: .white,
                        canDragging: true,
                        showBorder: true,
                        themName: "[Megamil AI]",
                        presentationStyle: presentationStyle,
                        onClose: {
                            isChatViewActive = false
                        },
                        messages: [
                                ChatMessage(text: "Pergunta no histórico interno", timestamp: DateHelper.formatCurrentDateTime(), isFromMe: true),
                                ChatMessage(text: "Resposta no histórico interno", timestamp: DateHelper.formatCurrentDateTime(), isFromMe: false),
                        ],
                        suggestions: [
                            "🕢 Qual horário de funcionamento?",
                            "💲 Qual o valor da mensalidade?",
                            "🗺️ Qual o endereço da loja?",
                            "📆 Qual o prazo de orçamento?"
                        ],
                        typeEndPoints: .OpenAI
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
