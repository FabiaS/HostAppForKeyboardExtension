import UIKit

public enum NavigationButtonType: String {
    case switchKeyboard = "SWITCH"
    case previousPage = "<<"
    case nextPage = ">>"
    case deleteCharacter = "DELETE"
}

public protocol NavigationButtonViewDelegate: class {
    func nextKeyboardPressed(sender: NavigationButtonView)
    func pageMinusOnePressed(sender: NavigationButtonView)
    func pagePlusOnePressed(sender: NavigationButtonView)
    func deletePressed(sender: NavigationButtonView)
}

public class NavigationButtonView: UIButton {
    
    public weak var navigationButtonViewDelegate: NavigationButtonViewDelegate?
    private let settings = KeyboardSettings()

    public init(type: NavigationButtonType) {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backgroundColor = .clear
        setTitleColor(settings.navigationBarTitleColor, for: .normal)
        setTitle(type.rawValue, for: UIControlState())
        
        switch type {
        case .switchKeyboard:
            self.addTarget(self, action: #selector(nextKeyboardButtonPressed(_:)), for: .touchUpInside)
        case .previousPage:
            self.addTarget(self, action: #selector(pageMinusOneButtonPressed(_:)), for: .touchUpInside)
        case .nextPage:
            self.addTarget(self, action: #selector(pagePlusOneButtonPressed(_:)), for: .touchUpInside)
        case .deleteCharacter:
            self.addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(type:)")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(type:)")
    }
    
    public func nextKeyboardButtonPressed(_ button: UIButton) {
        navigationButtonViewDelegate?.nextKeyboardPressed(sender: self)
    }
    
    public func pageMinusOneButtonPressed(_ button: UIButton) {
        navigationButtonViewDelegate?.pageMinusOnePressed(sender: self)
    }
    
    public func pagePlusOneButtonPressed(_ button: UIButton) {
        navigationButtonViewDelegate?.pagePlusOnePressed(sender: self)
    }
    
    public func deleteButtonPressed(_ button: UIButton) {
        navigationButtonViewDelegate?.deletePressed(sender: self)
    }
    
}
