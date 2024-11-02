//
//  BackgroundVIew.swift
//  sample_megamil_chat_ios
//
//  Created by Eduardo dos santos on 02/11/24.
//
import SwiftUI

struct BackgroundView: View {
    var onClose: (() -> Void)?
    var backgroundColor: Color = Color.black.opacity(0.1)
    
    var body: some View {
        backgroundColor
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                onClose?()
            }
    }
}

#Preview {
    BackgroundView()
}
