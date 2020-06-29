//
//  CustomLabel.swift
//  Angkasa Pura Solusi
//
//  Created by Arief Zainuri on 11/08/19.
//  Copyright © 2019 Gama Techno. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomLabel: UILabel {
    
    @IBInspectable var fontName: String = "Poppins-Medium" { didSet { updateFonts() }}
    @IBInspectable var fontSize: CGFloat = 16 { didSet { updateFonts() }}
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }

            attributedString.addAttribute(NSAttributedString.Key.kern,
                                           value: newValue,
                                           range: NSRange(location: 0, length: attributedString.length))

            attributedText = attributedString
        }

        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
    
    func updateFonts() {
        font = UIFont(name: fontName, size: fontSize + PublicFunction.dynamicSize())
    }
}
