import Foundation

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
