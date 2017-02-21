import UIKit

public protocol RowViewDelegate: class {
    func keyPressed(sender: RowView, character: String)
}

public class RowView: UIView {
    
    public weak var rowViewDelegate: RowViewDelegate?
    private var rowButtons = [UIButton]()
    private let settings = KeyboardSettings()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:rowTitles:)")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(frame:rowTitles:)")
    }
    
    public init(frame: CGRect, rowTitles: [String]) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupButtonsWithTitles(rowTitles)
        addConstraintsToSubviews()
    }
    
    private func setupButtonsWithTitles(_ titles: [String]) {
        for buttonTitle in titles {
            let button = createButtonWithTitle(buttonTitle)
            rowButtons.append(button)
            
            let selector = #selector(keyPressed(_:))
            button.addTarget(self, action: selector, for: .touchUpInside)
            
            addSubview(button)
        }
    }
    
    private func createButtonWithTitle(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle(title, for: UIControlState())
        button.tintColor = settings.keysTintColor
        return button
    }
    
    public func keyPressed(_ button: UIButton) {
        sendButtonTitleToDelegate(button)
        animatePressedButton(button)
    }
    
    private func sendButtonTitleToDelegate(_ button: UIButton) {
        if let character = button.title(for: .normal) {
            rowViewDelegate?.keyPressed(sender: self, character: character)
        }
    }
    
    private func animatePressedButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        })
    }
    
    private func addConstraintsToSubviews() {
        for (index, button) in rowButtons.enumerated() {
            
            button.constrainToSuperview(edges: [.top, .bottom])
            
            let maxNumberOfButtons = rowButtons.count
            let buttonWidth = UIScreen.mainScreenWidth / CGFloat(maxNumberOfButtons)
            button.constrain(width: buttonWidth) // ???
            
            if index == 0 {
                button.constrainToSuperview(.left)
            } else {
                let previousButton = rowButtons[index-1]
                button.constrain(.left, to: previousButton, .right)
            }
        }
    }
    
}
