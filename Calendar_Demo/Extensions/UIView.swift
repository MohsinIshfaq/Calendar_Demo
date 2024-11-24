import UIKit


extension UIView {
    enum Corners: Int {
        case TopLeft = 0
        case TopRight
        case BottomLeft
        case BottomRight
        
        var cornerMask: CACornerMask {
            switch self {
            case .TopLeft:
                return .layerMinXMinYCorner
            case .TopRight:
                return .layerMaxXMinYCorner
            case .BottomLeft:
                return .layerMinXMaxYCorner
            case .BottomRight:
                return .layerMaxXMaxYCorner
            }
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func addSubview(_ controller: UIViewController) {
        if let mainController = parentViewController {
            mainController.addChild(controller)
            addSubview(controller.view)
            controller.didMove(toParent: mainController)
        } else {
            addSubview(controller.view)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    func setBorder(color: UIColor = UIColor.white, borderWidth: CGFloat = 1)
    {
        layer.borderColor  = color.cgColor
        layer.borderWidth = borderWidth
    }
    
    func setCornerRadius(cornerRadius: Double = 5, corners:[Corners] = [])
    {
        if corners.count > 0 {
            if #available(iOS 11.0, *) {
                var cornerMask:CACornerMask = []
                for corner in corners {
                    cornerMask.insert(corner.cornerMask)
                }
                
                self.layer.maskedCorners = cornerMask
            }
        } else {
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = []
            } else {
                // Fallback on earlier versions
            }
        }
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(cornerRadius)
        
        
    }
    
    func setCornerRadius(cornerRadius: Double = 5)
    {
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func setRoundedCorners()
    {
        setCornerRadius(cornerRadius: Double(frame.size.height * 0.5))
    }
    
}


func animate(duration:Float = 0,_ completion : @escaping () -> () = {},_ performUpdates : @escaping () -> ())
{
    UIView.animate(withDuration: TimeInterval(duration), animations: {
        performUpdates()
    }) { (complete) in
        completion()
    }
    
}
