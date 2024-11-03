//
//  Helpers.swift
//  MegamilChat
//
//  Created by Eduardo dos santos on 03/11/24.
//
import SwiftUI

public class DateHelper {
    
    public static func formatCurrentDateTime(showDate: Bool = true, showTime: Bool = true, isAmericanFormat: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        
        if showDate && showTime {
            dateFormatter.dateFormat = isAmericanFormat ? "MM/dd/yyyy HH:mm" : "dd/MM/yyyy HH:mm"
        } else if showDate {
            dateFormatter.dateFormat = isAmericanFormat ? "MM/dd/yyyy" : "dd/MM/yyyy"
        } else if showTime {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            return ""
        }
        
        return dateFormatter.string(from: Date())
    }
    
}
