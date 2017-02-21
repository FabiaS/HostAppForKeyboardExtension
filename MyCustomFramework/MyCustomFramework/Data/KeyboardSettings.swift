import Foundation
import UIKit

public struct KeyboardSettings {
    public let navBarHeight: CGFloat = 40
    //public let keyboardHeight: CGFloat = 227
    public var keyboardHeight: CGFloat { // ???
        get {
            if UIDevice.current.orientation.isLandscape {
                return UIScreen.mainScreenHeight/2.0 - navBarHeight
            } else {
                return UIScreen.mainScreenHeight/2.5 - navBarHeight
            }
        }
    }
    
    public let maxPageCount = 2
    public let maxRowCount = 3
    
    public let keysBackgroundColor = UIColor.lightGray
    public let navigationBarBackgroundColor = UIColor.darkGray
    public let keysTintColor = UIColor.black
    public let navigationBarTintColor = UIColor.white
    
    public init() {
        // 
    }
}

public extension UIScreen {
    
    public class var mainScreenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    public class var mainScreenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
}
