

import UIKit

var AppMainColor: UIColor = UIColor(named: "AppMainColor") ?? .black

extension UIColor {

    enum AssetsColor: String {
        case c180738TOFFFFFF = "180738TOFFFFFF"
        case EDEBEETO251A3A = "EDEBEETO251A3A"
    }
    
    static func appColor(_ name: AssetsColor) -> UIColor {
        return UIColor(named: name.rawValue) ?? UIColor.white
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int,alpha: Double = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    convenience init(hex: Int,alpha: Double = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}
