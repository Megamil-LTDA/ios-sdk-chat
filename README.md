# Requests de exemplo:
<!--Exemplo do json da request completo-->
```json
 {
     "background_color": "#FFFFFF",
     "can_dragging": true,
     "show_border": true,
     "show_input_border": true,
     "show_return_button": false,
     "typing_effect": true,
     "them_name": "[Megamil Chat]",
     "presentation_style": "fullscreen",
     "type_endpoints": "MegamilChat",
     "messages": [
         {
             "text": "Olá, sou o Megamil Chat! como posso ajudar?",
             "timestamp": "05/11/2024 00:00",
             "is_from_me": false
         }
     ],
     "list_suggestions": "Sugestão 1...,Sugestão 2...",
     "placeholder": "Digite uma mensagem...",
     "send_button_icon": "paperplane.fill",
     "record_button_icon": "mic.fill",
     "button_color": "#0000FF",
     "list_border_colors": "008000FF,0000FFFF,FF0000FF",
     "list_input_border_colors": ["FFA500FF","FFC0CBFF","808080FF"],
     "ref": "",
     "name": "",
     "contact": "",
     "base_url": "",
     "endpoint": "",
     "bearer_token": "...",
     "allow_audio_recording": false,
     "me_bubble_color": "#0000FF",
     "me_bubble_text_color": "#FFFFFF",
     "them_bubble_color": "#008000",
     "them_bubble_text_color": "#FFFFFF"
 }
```

### Documentação dos campos:

- **`background_color`** *(string)* → Define a cor de fundo do chat em formato hexadecimal.  
- **`can_dragging`** *(boolean)* → Define se o usuário pode arrastar a janela do chat.  
- **`show_border`** *(boolean)* → Exibe uma borda ao redor do chat se `true`.  
- **`show_input_border`** *(boolean)* → Exibe uma borda ao redor da área de entrada de texto.  
- **`show_return_button`** *(boolean)* → Se `true`, exibe um botão de retorno na interface.  
- **`typing_effect`** *(boolean)* → Habilita efeito de digitação nas mensagens enviadas pelo bot.  
- **`them_name`** *(string)* → Nome do chatbot ou do agente da conversa.  
- **`presentation_style`** *(string)* → Define o estilo de apresentação do chat. Exemplo: `"fullscreen"` para tela cheia. `largebottomsheet`, `mediumbottomsheet` e `smallbottomsheet` para Bottom sheets em tamanhos diversos e por fim `floating` para aparecer fluturando 
- **`type_endpoints`** *(string)* → Tipo de endpoint que será utilizado na comunicação, aceitando `OpenAI` para usar API oficial da OpenAI, `MegamilChat` para usar API do nosso serviço e por fim `CustomURL` para usar um API própria, requer informar campos `base_url`, `endpoint` e `bearer_token`.   
- **`messages`** *(array de objetos)* → Lista de mensagens predefinidas no chat.  
  - **`text`** *(string)* → Conteúdo da mensagem.  
  - **`timestamp`** *(string)* → Data e hora no formato `"dd/MM/yyyy HH:mm"`.  
  - **`is_from_me`** *(boolean)* → Define se a mensagem é do usuário (`true`) ou do bot (`false`).  
- **`list_suggestions`** *(string)* → Sugestões de mensagens para o usuário, separadas por vírgulas ou um array de strings.  
- **`placeholder`** *(string)* → Texto de placeholder na área de entrada de mensagens.  
- **`send_button_icon`** *(string)* → Ícone do botão de envio (nome do ícone SF Symbols).  
- **`record_button_icon`** *(string)* → Ícone do botão de gravação de áudio (nome do ícone SF Symbols).  
- **`button_color`** *(string)* → Cor dos botões principais no formato hexadecimal.  
- **`list_border_colors`** *(string)* → Lista de cores adicionais para a borda, separadas por vírgula ou um array de strings.  
- **`list_input_border_colors`** *(string)* → Lista de cores adicionais para a borda do input de texto, separadas por vírgula ou um array de strings.  
- **`ref`** *(string)* → Referência opcional para identificar uma sessão de chat.  
- **`name`** *(string)* → Nome do usuário (caso necessário para personalização).  
- **`contact`** *(string)* → Informação de contato do usuário, se necessário.  
- **`base_url`** *(string)* → URL base da API que será usada para comunicação, obrigatório no caso de usar `type_endpoints:CustomURL`
- **`endpoint`** *(string)* → Endpoint específico para envio de mensagens, obrigatório no caso de usar `type_endpoints:CustomURL`  
- **`bearer_token`** *(string)* → Token de autenticação para requisições à API, OBRIGATÓRIO!  
- **`allow_audio_recording`** *(boolean)* → Define se a gravação de áudio está permitida.  
- **`me_bubble_color`** *(string)* → Cor do balão de mensagens do usuário.  
- **`me_bubble_text_color`** *(string)* → Cor do texto dentro do balão de mensagens do usuário.  
- **`them_bubble_color`** *(string)* → Cor do balão de mensagens do chatbot.  
- **`them_bubble_text_color`** *(string)* → Cor do texto dentro do balão de mensagens do chatbot.  

Alguns atributos só funcionarão quando o chat for chamado dentro da sua aplicação. No `AppClips`, certas funcionalidades, especialmente as relacionadas à apresentação da tela e ao botão de voltar, podem não estar disponíveis.  

### Exemplo de JSON mínimo para uso com API de terceiros  
```json
{
    "base_url": "https://SUA_URL/",
    "type_endpoints": "CustomURL",
    "endpoint": "SEU_ENDPOINT",
    "bearer_token": "SEU_BEARER_TOKEN"
}
```

## Como usar no ClipApps da LLMCHAT gratuitamente  
Para utilizar no ClipApps, o JSON deve ser convertido para **Base64** e passado como parâmetro na URL usando a query `config`:  

```
https://appclip.apple.com/id?p=br.com.megamil.LLMChat.Clip&config=
```

Alternativamente, você pode utilizar nosso endpoint, que no futuro também permitirá o redirecionamento para Android quando disponível:  

```
https://llmchat.megamil.com.br/chatbot/app?config=
```

Ao compartilhar o link, QR Code ou NFC, o ClipApp deve abrir automaticamente. No entanto, há uma limitação: quanto mais campos forem incluídos no JSON e convertidos para **Base64**, maior será o tamanho do hash final.  

Isso pode gerar alguns desafios, como:  
- **Tags NFC:** Podem precisar de maior capacidade de armazenamento.  
- **QR Codes:** Um código muito grande pode se tornar complexo e difícil de escanear.  

Por isso, recomenda-se evitar o uso excessivo de campos, especialmente um grande número de sugestões ou um histórico extenso de conversas, para garantir um carregamento rápido e eficiente.

# SwiftGen
Adicionar strings na pt-BR e en, depois executar:
```bash
swiftgen
```

# TODOs
* Permitir escolha de modelo ao chamar API da OpenAI
* Aceitar envio e recebimento de Audios, já está preparado na request, mas ainda não foi implementado.
