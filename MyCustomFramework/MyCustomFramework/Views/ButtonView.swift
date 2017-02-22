import UIKit

public protocol ButtonViewDelegate: class {
    func keyPressed(sender: ButtonView, character: String)
}

public class ButtonView: UIButton {
    
    public weak var buttonViewDelegate: ButtonViewDelegate?
    private let settings = KeyboardSettings()

    public init(title: String, textColor: UIColor) {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backgroundColor = .clear
        setTitleColor(settings.keysTitleColor, for: .normal)
        setTitle(title, for: UIControlState())
        
        self.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(title:)")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(title:)")
    }
    
    public func keyPressed(_ button: UIButton) {
        sendButtonTitleToDelegate(button)
        animatePressed(button)
    }
    
    private func sendButtonTitleToDelegate(_ button: UIButton) {
        if let character = button.title(for: .normal) {
            buttonViewDelegate?.keyPressed(sender: self, character: character)
        }
    }
    
    private func animatePressed(_ button: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        })
    }
    
}
