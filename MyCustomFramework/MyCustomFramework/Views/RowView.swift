import UIKit

public protocol RowViewDelegate: class {
    func keyPressed(sender: RowView, character: String)
}

public class RowView: UIView, ButtonViewDelegate {
    
    public weak var rowViewDelegate: RowViewDelegate?
    private let settings = KeyboardSettings()
    private var rowButtons = [ButtonView]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(titles:)")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(titles:)")
    }
    
    public init(titles: [String]) {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupButtons(with: titles)
        addConstraintsToSubviews()
    }
    
    private func setupButtons(with rowTitles: [String]) {
        for buttonTitle in rowTitles {
            
            let button = ButtonView(title: buttonTitle, textColor: settings.keysTitleColor)
            button.buttonViewDelegate = self
            
            rowButtons.append(button)
            addSubview(button)
        }
    }
    
    public func keyPressed(sender: ButtonView, character: String) {
        rowViewDelegate?.keyPressed(sender: self, character: character)
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
