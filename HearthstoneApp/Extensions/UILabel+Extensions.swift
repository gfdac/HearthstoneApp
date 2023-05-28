//
//  UILabel+Extensions.swift
//  HearthstoneApp
//
//  Created by Guh F on 28/05/23.
//

import UIKit

extension UILabel {
    func setHTMLText(_ htmlString: String) {
        let textColor = AppDesignSystem.Colors.text
        let font = AppDesignSystem.Fonts.attributesTitle
        let textAlignment = NSTextAlignment.right
        
        guard let data = htmlString.data(using: .utf8) else {
            self.text = htmlString
            self.textColor = textColor
            self.font = font
            self.textAlignment = textAlignment
            return
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            let fullRange = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(.foregroundColor, value: textColor, range: fullRange)
            attributedString.addAttribute(.font, value: font, range: fullRange)
            self.attributedText = attributedString
            self.textAlignment = textAlignment
        } else {
            self.text = htmlString
            self.textColor = textColor
            self.font = font
            self.textAlignment = textAlignment
        }
    }
}
