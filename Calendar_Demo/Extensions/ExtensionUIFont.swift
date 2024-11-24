//
//  ExtensionUIFont.swift
//  Calendar_Demo
//
//  Created by Mohsin on 24/11/2024.
//

import UIKit

extension UIFont {
    enum Gilroy {
        static func Regular(of size:CGFloat) -> UIFont { return UIFont(name: "Gilroy-Regular", size: size) ?? UIFont.systemFont(ofSize: size) }
        static func Medium(of size:CGFloat) -> UIFont { return UIFont(name: "Gilroy-Medium", size: size) ?? UIFont.systemFont(ofSize: size) }
        static func SemiBold(of size:CGFloat) -> UIFont { return UIFont(name: "Gilroy-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size) }
        static func Bold(of size:CGFloat) -> UIFont { return UIFont(name: "Gilroy-Bold", size: size) ?? UIFont.systemFont(ofSize: size) }
    }
}
