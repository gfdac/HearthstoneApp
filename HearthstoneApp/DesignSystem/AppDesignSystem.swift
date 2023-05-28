//  AppDesignSystem.swift
//  HearthstoneApp
//
//  Created by Guh F on 28/05/23.
//

import UIKit

struct AppDesignSystem {
    struct Colors {
        static let background = UIColor(red: 27/255, green: 27/255, blue: 28/255, alpha: 1.0)
        static let headerBackground = UIColor(red: 32/255, green: 34/255, blue: 37/255, alpha: 1.0)
        static let headerTitle = UIColor.white
        static let text = UIColor.white
        static let activityIndicator = UIColor.white
        static let navigationBarBackground = UIColor(red: 32/255, green: 34/255, blue: 37/255, alpha: 1.0)
        static let navigationBarTint = UIColor.white
        static let navigationBarTitle = UIColor.white
        static let placeholder = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    }
    
    struct Fonts {
        static let headerTitle = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let attributesTitle = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let cellTitle = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let navigationBarTitle = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    struct Strings {
        static let appTitle = "HearthstoneApp"
        static let undefinedText = "Indefinido"
    }
    
    struct Sizes {
        static let cellPadding: CGFloat = 16
        static let headerPadding: CGFloat = 16
        static let headerHeight: CGFloat = 48
    }
}
