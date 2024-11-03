//
//  SafePrint.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import Foundation

enum PrintType {
    case error
    case warning
    case info
    case `default`
    
    var emoji: String {
        switch self {
            case .error: return "🔴 Error"
            case .warning: return "🟡 Warning"
            case .info: return "🔵 Info"
            case .default: return "🟢 Default"
        }
    }
}

class SafePrint {
    
    @discardableResult
    init(_ items: Any..., separator: String = " ", terminator: String = "\n|Safe Print End|\n===========", prefix: String = "", forceFullPrint: Bool = false, savePrint: Bool = false, showToast: Bool = false, type: PrintType = .default) {
        
#if !PRODUCTION
        var printItem = (items.count > 1 ? items : items.first) ?? "Empty print"
        
        if(!forceFullPrint && printItem is String && "\(printItem)".count > 20000) {
            printItem = " [** PRINT_TRIM START **] Original size: \("\(printItem)".count)" + String("\(printItem)".prefix(20000)) + "..." + String("\(printItem)".suffix(100)) + " [** PRINT_TRIM END **] "
        }
        
        if(savePrint && printItem is String) { /*@todo*/ }
        
        let after = "\n--------\n" + type.emoji + " |Safe Print Start| " + DateHelper.formatCurrentDateTime()
        
        Swift.print(after, prefix, printItem, separator:separator, terminator: terminator)
        if(showToast) { ToastView.showToast(message: "\(printItem)") }
#endif
        
    }
    
    static func decodableError(error: Error) {
        SafePrint(error, prefix: "Decodable error", type: .error)
        SafePrint(error.localizedDescription, prefix: "Decodable error description", type: .error)
    }
    
    
}
