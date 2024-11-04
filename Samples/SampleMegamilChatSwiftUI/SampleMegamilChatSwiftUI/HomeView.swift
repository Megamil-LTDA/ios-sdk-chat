    //
    //  HomeView.swift
    //  Megamil
    //
    //  Created by Eduardo dos Santos on 30/10/24.
    //  Copyright © 2024 Megamil. All rights reserved.
    //
import SwiftUI
import MegamilChat

struct HomeView: View {
    @State private var presentationStyle: PresentationStyle = .fullscreen
    @State private var isChatViewActive = false
    
    var body: some View {
        NavigationView { // Adicionando NavigationView aqui
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
                        
                        NavigationLink(destination: createChatView(presentationStyle: .fullscreen, showReturnButton: false)
                            .navigationBarBackButtonHidden(false)) {
                                Text("Abrir chat tela cheia via push")
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .onTapGesture {
                                presentationStyle = .fullscreen
                            }
                    }
                    .padding()
                }
            }
        }
//        .fullScreenCover(isPresented: $isChatViewActive) {
            //                    createChatView(presentationStyle: presentationStyle)
            //                }
        .fullScreenModal(isPresented: $isChatViewActive) {
            createChatView(presentationStyle: presentationStyle)
        }
    }
    
    func createChatView(presentationStyle: PresentationStyle = .fullscreen, showReturnButton: Bool = true) -> some View {
        
        //Exemplo rápido: Usando os outros valores como default, passando o bearer token para Megamil Chat.
//        MegamilChatView(bearerToken: "..." /* Token de autenticação para requisições OBRIGATÓRIO*/)
        
        //Exemplo completo, customizando todos os campos
        MegamilChatView(
            backgroundColor: .white, /* Cor do background da view principal */
            canDragging: true, /* Permitir arrastar a view (modo Bottom sheet) */
            showBorder: true, /* Exibir bordas coloridas ao redor da view */
            showInputBorder: true, /* Exibir bordas coloridas ao redor do input de mensagem */
            showReturnButton: showReturnButton, /* Exibir botão para voltar/fechar a view */
            themName: "[Megamil AI]", /* Nome ou prefixo para as respostas da IA */
            presentationStyle: presentationStyle, /* Tipo de apresentação: fullscreen | largeBottomSheet | mediumBottomSheet | smallBottomSheet | floating */
            onClose: { /* Executado ao fechar a view */
                isChatViewActive = false
            },
            messages: [], /* Histórico inicial de mensagens a ser exibido */
            suggestions: [ /* Sugestões iniciais de perguntas (exibidas apenas quando não há histórico de mensagens) */
                "🕢 Qual horário de funcionamento?",
                "💲 Qual o valor da mensalidade?",
                "🗺️ Qual o endereço da loja?",
                "📆 Qual o prazo de orçamento?"
            ],
            
            placeholder: "Digite uma mensagem...", /* Placeholder do campo de mensagem */
            sendButtonIcon: "paperplane.fill", /* Ícone do botão de enviar mensagem */
            recordButtonIcon: "mic.fill", /* Ícone do botão de gravação de áudio */
            buttonColor: Color.blue, /* Cor dos botões de enviar e gravar */
            borderColor: [Color.green, Color.blue, Color.red], /* Cores das bordas externas da view */
            borderInputColor: [Color.orange, Color.pink, Color.gray], /* Cores das bordas do campo de input */
            
            ref: "", /* Referência adicional para o usuário (opcional) */
            name: "", /* Nome do usuário (opcional) */
            contact: "", /* Contato do usuário (opcional) */
            baseUrl: "", /* URL base para o serviço de mensagens (Somente para chamadas customizadas) */
            endpoint: "", /* Endpoint específico para a API de mensagens (Somente para chamadas customizadas) */
            bearerToken: "...", /* Token de autenticação para requisições OBRIGATÓRIO*/
            
            allowAudioRecording: false, /* Permitir gravação de áudio pelo usuário [Atualmente desativado]*/
            typeEndPoints: .MegamilChat, /* Tipo de serviço de endpoints: OpenAI | MegamilChat | CustomURL */
            
            meBubbleColor: Color.blue, /* Cor do balão de mensagens enviadas pelo usuário */
            meBubbleTextColor: Color.white, /* Cor do texto das mensagens enviadas pelo usuário */
            themBubbleColor: Color.green, /* Cor do balão de mensagens recebidas (IA) */
            themBubbleTextColor: Color.white /* Cor do texto das mensagens recebidas (IA) */
        )
    }
}

#Preview {
    HomeView()
}
