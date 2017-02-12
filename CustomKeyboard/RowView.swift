import UIKit

protocol RowViewDelegate: class {
    func keyPressed(sender: RowView, button: UIButton)
}

class RowView: UIView {
    
    weak var delegate: RowViewDelegate?
    private var rowButtons = [UIButton]()
    private let settings = KeyboardSettings()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:rowTitles:)")
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(frame:rowTitles:)")
    }
    
    init(frame: CGRect, rowTitles: [String]) {
        super.init(frame: frame)
        
        setupButtonsWithTitles(rowTitles)
        addConstraints()
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
    
    func keyPressed(_ button: UIButton) {
        delegate?.keyPressed(sender: self, button: button)
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
    
    private func addConstraints() {
        for (index, button) in rowButtons.enumerated() {
            button.pinToSuperviewTop()
            button.pinToSuperviewBottom()
            
            if index == 0 {
                button.pinToSuperviewLeft()
                
                let mainScreenWidth = UIScreen.main.bounds.size.width
                let buttonWidth = mainScreenWidth / CGFloat(rowButtons.count)
                button.addWidthConstraint(withConstant: buttonWidth)
                
            } else if index == rowButtons.count - 1 {
                let previousButton = rowButtons[index-1]
                button.attachToRightOf(previousButton)
                
                let firstButton = rowButtons[0]
                button.equalWidthTo(firstButton)
                
            } else {
                let previousButton = rowButtons[index-1]
                button.attachToRightOf(previousButton)
                
                let firstButton = rowButtons[0]
                button.equalWidthTo(firstButton)
            }
        }
    }
    
}
