import UIKit

public protocol NavigationBarViewDelegate: class {
    func nextKeyboardPressed(sender: NavigationBarView)
    func pagePlusOnePressed(sender: NavigationBarView)
    func pageMinusOnePressed(sender: NavigationBarView)
    func deletePressed(sender: NavigationBarView)
}

public class NavigationBarView: UIView {
    
    public weak var navigationBarDelegate: NavigationBarViewDelegate?
    private var pageControl = UIPageControl()
    private var nextKeyboardButton: UIButton?
    private var backButton: UIButton?
    private var forwardButton: UIButton?
    private var deleteButton: UIButton?
    private let settings = KeyboardSettings()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:)")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = settings.navigationBarBackgroundColor
        setupPageControl()
        setupButtons()
        addConstraints()
    }
    
    private func setupPageControl() {
        pageControl.frame = CGRect()
        pageControl.numberOfPages = settings.maxPageCount;
        pageControl.currentPage = 0;
        pageControl.backgroundColor = .clear
        addSubview(pageControl)
    }
    
    private func setupButtons() {
        nextKeyboardButton = createButtonWithTitle("SWITCH")
        backButton = createButtonWithTitle("<<")
        forwardButton = createButtonWithTitle(">>")
        deleteButton = createButtonWithTitle("DELETE")
        
        guard let nextKeyboardButton = nextKeyboardButton,
            let forwardButton = forwardButton,
            let backButton = backButton,
            let deleteButton = deleteButton else {
            fatalError("Could not setup buttons")
        }
        
        nextKeyboardButton.addTarget(self, action: #selector(nextKeyboardButtonPressed), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(pagePlusOneButtonPressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(pageMinusOneButtonPressed), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        
        self.addSubview(nextKeyboardButton)
        self.addSubview(forwardButton)
        self.addSubview(backButton)
        self.addSubview(deleteButton)
    }
    
    private func createButtonWithTitle(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle(title, for: UIControlState())
        button.tintColor = settings.navigationBarTintColor
        return button
    }
    
    // MARK: methods
    
    public func nextKeyboardButtonPressed() {
        navigationBarDelegate?.nextKeyboardPressed(sender: self)
    }
    
    public func deleteButtonPressed() {
        navigationBarDelegate?.deletePressed(sender: self)
    }
    
    public func pagePlusOneButtonPressed() {
        movePageControlUp(1)
        navigationBarDelegate?.pagePlusOnePressed(sender: self)
    }
    
    public func pageMinusOneButtonPressed() {
        movePageControlDown(1)
        navigationBarDelegate?.pageMinusOnePressed(sender: self)
    }
    
    private func movePageControlUp(_ step: Int) {
        let newPageNumber = pageControl.currentPage+step
        if newPageNumber < settings.maxPageCount {
            pageControl.currentPage = newPageNumber
        }
    }
    
    private func movePageControlDown(_ step: Int) {
        let newPageNumber = pageControl.currentPage-step
        if newPageNumber >= 0 {
            pageControl.currentPage = newPageNumber
        }
    }
    
    public func updatePageControlWith(scrollViewContentOffset: CGPoint, scrollViewPageSize: CGSize) {
        let fractionalPageNumber: Double = Double(scrollViewContentOffset.x / scrollViewPageSize.width)
        let roundedPageNumber = lround(fractionalPageNumber)
        if roundedPageNumber >= 0, roundedPageNumber < settings.maxPageCount {
            pageControl.currentPage = roundedPageNumber
        }
    }
    
    // MARK: constraints
    
    private func addConstraints() {
        pageControl.pinToSuperviewTop(withInset: 0)
        pageControl.pinToSuperviewLeft(withInset: 0)
        pageControl.pinToSuperviewRight(withInset: 0)
        pageControl.addHeightConstraint(withConstant: 20)
        
        guard let nextKeyboardButton = nextKeyboardButton, let backButton = backButton, let forwardButton = forwardButton, let deleteButton = deleteButton else {
            fatalError("Could not find buttons")
        }
        let buttons = [nextKeyboardButton, backButton, forwardButton, deleteButton]
        
        for (index, button) in buttons.enumerated() {
            button.pinToSuperviewTop()
            button.pinToSuperviewBottom()
            
            if index == 0 {
                button.pinToSuperviewLeft()
                
                let mainScreenWidth = UIScreen.main.bounds.size.width
                let buttonWidth = mainScreenWidth / CGFloat(buttons.count)
                button.addWidthConstraint(withConstant: buttonWidth)
                
            } else if index == buttons.count - 1 {
                let previousButton = buttons[index-1]
                button.attachToRightOf(previousButton)
                
                let firstButton = buttons[0]
                button.equalWidthTo(firstButton)
                
            } else {
                let previousButton = buttons[index-1]
                button.attachToRightOf(previousButton)
                
                let firstButton = buttons[0]
                button.equalWidthTo(firstButton)
            }
        }
    }
    
    public func addConstraintsToSuperview() {
        pinToSuperviewTop(withInset: 0)
        pinToSuperviewLeft(withInset: 0)
        pinToSuperviewRight(withInset: 0)
        let navBarHeight = CGFloat(settings.navBarHeight)
        addHeightConstraint(withConstant: navBarHeight)
    }

}
