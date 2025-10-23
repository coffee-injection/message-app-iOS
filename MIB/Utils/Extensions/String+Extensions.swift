//
//  String+Extensions.swift
//  MIB
//
//  Created by JunghyunYoo on 10/14/25.
//

import Foundation

extension String {
    func toDate() -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self) ?? Date()
    }
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNotEmpty: Bool {
        return !self.trimmed.isEmpty
    }
}
