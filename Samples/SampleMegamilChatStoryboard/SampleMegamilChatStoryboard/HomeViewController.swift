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
    
    private func presentChatViewController(presentationStyle: PresentationStyle) {
        let chatViewController = MegamilChatView(backgroundColor: .white, canDragging: true, showBorder: true, themName: "[Megamil AI]", presentationStyle: presentationStyle, onClose: {
            self.dismiss(animated: true, completion: nil)
        })
        
        let chatView = UIHostingController(rootView: chatViewController)
        
        chatView.view.backgroundColor = .clear
        chatView.modalPresentationStyle = .overFullScreen
        present(chatView, animated: true)
    }
}
