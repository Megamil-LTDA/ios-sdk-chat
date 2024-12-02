//
//  ToastView.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import UIKit //TODO atualizar para SwiftUI

class ToastView: UIView {
    
    class func showToast(message: String, duration: TimeInterval = 2.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let toast = ToastView(message: message)
            toast.alpha = 0.0
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    keyWindow.addSubview(toast)
                    
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                        toast.alpha = 1.0
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseIn, animations: {
                            toast.alpha = 0.0
                        }, completion: { _ in
                            toast.removeFromSuperview()
                        })
                    })
                }
            }
        }
    }
    
    init(message: String) {
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 2 * 32.0
        let maxHeight: CGFloat = 300.0
        let safeDistance: CGFloat = 32.0
        
        let label = UILabel()
        label.text = message
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        
        let labelSize = label.sizeThatFits(CGSize(width: maxWidth - 2 * safeDistance, height: maxHeight))
        let toastWidth = min(labelSize.width + 2 * safeDistance, maxWidth)
        let toastHeight = min(labelSize.height + 2 * safeDistance, maxHeight)
        
        let toastFrame = CGRect(x: 0, y: 0, width: toastWidth, height: toastHeight)
        super.init(frame: toastFrame)
        
        self.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - toastHeight / 2 - safeDistance)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.layer.cornerRadius = 10.0
        
        label.frame = CGRect(x: safeDistance, y: safeDistance, width: labelSize.width, height: labelSize.height)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

