//
//  StringHelper.swift
//  TheBakingApp
//
//  Created by codedentwickler on 2/13/18.
//  Copyright © 2018 codedentwickler. All rights reserved.
//

import Foundation
import UIKit

class StringHelper {
    
    static func createBulletedList(withBullets: Bool = true,
                                   fromStringArray strings: [String],
                                   font: UIFont? = UIFont.systemFont(ofSize: 13)) -> NSAttributedString {
        
        let fullAttributedString = NSMutableAttributedString()
        let attributesDictionary: [NSAttributedStringKey: Any]
        
        if font != nil {
            attributesDictionary = [NSAttributedStringKey.font: font!]
        } else {
            attributesDictionary = [NSAttributedStringKey: Any]()
        }
        
        for index in 0..<strings.count {
            let bulletPoint: String = withBullets ? "\u{2022}" : "\t"
            var formattedString: String = "\(bulletPoint) \(strings[index].capitalized)"
            
            if index < strings.count - 1 {
                formattedString = "\(formattedString)\n"
            }
            
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: attributesDictionary)
            let paragraphStyle = StringHelper.createParagraphAttribute()
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
    }
    
    private static func createParagraphAttribute() -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 11
        return paragraphStyle
    }
}
