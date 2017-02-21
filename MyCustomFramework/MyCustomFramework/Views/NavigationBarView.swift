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
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = settings.navigationBarBackgroundColor
        setupPageControl()
        setupButtons()
        addConstraintsToSubviews()
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
    
    private func addConstraintsToSubviews() {
        
        pageControl.constrainToSuperview(edges: [.left, .top, .right])
        pageControl.constrain(height: 20)
        
        guard let nextKeyboardButton = nextKeyboardButton,
                let backButton = backButton,
                let forwardButton = forwardButton,
                let deleteButton = deleteButton else {
            fatalError("Could not find buttons")
        }
        
        let buttons = [nextKeyboardButton, backButton, forwardButton, deleteButton]
        for (index, button) in buttons.enumerated() {
            
            button.constrainToSuperview(edges: [.top, .bottom])
            
            let maxNumberOfButtons = buttons.count
            let buttonWidth = UIScreen.mainScreenWidth / CGFloat(maxNumberOfButtons)
            button.constrain(width: buttonWidth)
            
            if index == 0 {
                
                button.constrainToSuperview(.left)
                
            } else if index == maxNumberOfButtons-1 {
                
                button.constrainToSuperview(.right)
                
            } else if index <= (maxNumberOfButtons-1)/2 {
                
                let previousButton = buttons[index-1]
                button.constrain(.left, to: previousButton, .right)
                
            } else {
                
                let nextButton = buttons[index+1]
                button.constrain(.right, to: nextButton, .left)
            }
        }
    }
    
    public func addConstraintsToSuperview() {
        constrainToSuperview(edges: [.left, .bottom, .right])
        constrain(height: CGFloat(settings.navBarHeight))
    }

}
