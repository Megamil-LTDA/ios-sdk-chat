//
//  HomeViewController.swift
//  Megamil
//
//  Created by Eduardo dos santos on 30/10/24.
//  Copyright © 2024 Megamil. All rights reserved.
//
import UIKit
import SwiftUI
import MegamilChat

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openFullScreenChat(_ sender: UIButton) {
        presentChatViewController(presentationStyle: .fullscreen)
    }
    
    @IBAction func openLargeBottomSheetChat(_ sender: UIButton) {
        presentChatViewController(presentationStyle: .largeBottomSheet)
    }
    
    @IBAction func openMediumBottomSheetChat(_ sender: UIButton) {
        presentChatViewController(presentationStyle: .mediumBottomSheet)
    }
    
    @IBAction func openSmallBottomSheetChat(_ sender: UIButton) {
        presentChatViewController(presentationStyle: .smallBottomSheet)
    }
    
    @IBAction func openFloatingChat(_ sender: UIButton) {
        presentChatViewController(presentationStyle: .floating)
    }
    
    @IBAction func pushToChatView(_ sender: UIButton) {
        presentChatViewController(presentationStyle: .fullscreen, forcePush: true)
    }
    
    private func presentChatViewController(presentationStyle: PresentationStyle, forcePush: Bool = false) {
        
// Exemplo rápido: Usando os outros valores como default, passando o bearer token para Megamil Chat.
//            let config = MegamilChatConfig(
//                bearerToken: "..." /* Token de autenticação para requisições OBRIGATÓRIO*/
//            )
        
        //Exemplo completo, customizando todos os campos
        // Cria a configuração com os dados necessários
        let config = MegamilChatConfig(
            backgroundColor: "#FFFFFF", /* Cor do background da view principal */
            canDragging: true, /* Permitir arrastar a view (modo Bottom sheet) */
            showBorder: true, /* Exibir bordas coloridas ao redor da view */
            showInputBorder: true, /* Exibir bordas coloridas ao redor do input de mensagem */
            showReturnButton: !forcePush, /* Exibir botão para voltar/fechar a view */
            themName: "[Megamil AI]", /* Nome ou prefixo para as respostas da IA */
            presentationStyle: presentationStyle.rawValue, /* Tipo de apresentação: fullscreen | largeBottomSheet | mediumBottomSheet | smallBottomSheet | floating */
            typeEndpoints: TypeEndpoints.MegamilChat.rawValue, /* Tipo de serviço de endpoints: OpenAI | MegamilChat | CustomURL */
            messages: [ /* Histórico inicial de mensagens a ser exibido */
                ChatMessage(text: "Olá, sou o Megamil Chat!", timestamp: "05/11/2024 00:00", isFromMe: true)
            ],
            listSuggestions: [ /* Sugestões iniciais de perguntas (exibidas apenas quando não há histórico de mensagens) */
                "🕢 Qual horário de funcionamento?",
                "💲 Qual o valor da mensalidade?",
                "🗺️ Qual o endereço da loja?",
                "📆 Qual o prazo de orçamento?"
             ],
            placeholder: "Digite uma mensagem...", /* Placeholder do campo de mensagem */
            sendButtonIcon: "paperplane.fill", /* Ícone do botão de enviar mensagem */
            recordButtonIcon: "mic.fill", /* Ícone do botão de gravação de áudio */
            buttonColor: "#0000FF", /* Cor dos botões de enviar e gravar */
            listBorderColors: ["#008000", "#0000FF", "#FF0000"], /* Cores das bordas externas da view */
            listInputBorderColors: ["#FFA500", "#FFC0CB", "#808080"], /* Cores das bordas do campo de input */
            ref: "", /* Referência adicional para o usuário (opcional) */
            name: "", /* Nome do usuário (opcional) */
            contact: "", /* Contato do usuário (opcional) */
            baseUrl: "", /* URL base para o serviço de mensagens (Somente para chamadas customizadas) */
            endpoint: "", /* Endpoint específico para a API de mensagens (Somente para chamadas customizadas) */
            bearerToken: "...", /* Token de autenticação para requisições OBRIGATÓRIO*/
            allowAudioRecording: false, /* Permitir gravação de áudio pelo usuário [Atualmente desativado]*/
            meBubbleColor: "#0000FF", /* Cor do balão de mensagens enviadas pelo usuário */
            meBubbleTextColor: "#FFFFFF", /* Cor do texto das mensagens enviadas pelo usuário */
            themBubbleColor: "#008000", /* Cor do balão de mensagens recebidas (IA) */
            themBubbleTextColor: "#FFFFFF" /* Cor do texto das mensagens recebidas (IA) */
        )
        
        let chatViewController = MegamilChatView(config: config, onClose: { /* Executado ao fechar a view */
            self.dismiss(animated: true, completion: nil)
        })
        
        let chatView = UIHostingController(rootView: chatViewController)
        if(forcePush) {
            self.navigationController?.pushViewController(chatView, animated: true)
        } else {
            chatView.view.backgroundColor = .clear
            chatView.modalPresentationStyle = .overFullScreen
            present(chatView, animated: true)
        }
    }
    
}
