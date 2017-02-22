import Foundation
import UIKit

public struct KeyboardSettings {
    public let navBarHeight: CGFloat = 40
    // ???
    /*public var keyboardHeight: CGFloat {
        get {
            if UIDevice.current.orientation.isLandscape {
                return UIScreen.mainScreenHeight/2.0 - navBarHeight
            } else {
                return UIScreen.mainScreenHeight/2.5 - navBarHeight
            }
        }
    }*/
    
    public let maxPageCount = 2
    public let maxRowCount = 3
    
    public let keysBackgroundColor = UIColor.lightGray
    public let navigationBarBackgroundColor = UIColor.darkGray
    public let keysTitleColor = UIColor.black
    public let navigationBarTitleColor = UIColor.white
    
    public init() {
        // 
    }
}
