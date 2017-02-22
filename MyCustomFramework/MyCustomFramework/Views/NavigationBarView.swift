import UIKit

public protocol NavigationBarViewDelegate: class {
    func nextKeyboardPressed(sender: NavigationBarView)
    func pagePlusOnePressed(sender: NavigationBarView)
    func pageMinusOnePressed(sender: NavigationBarView)
    func deletePressed(sender: NavigationBarView)
}

public class NavigationBarView: UIView, NavigationButtonViewDelegate {
    
    public weak var navigationBarDelegate: NavigationBarViewDelegate?
    private let settings = KeyboardSettings()
    private var pageControl = UIPageControl()
    private var nextKeyboardButton: NavigationButtonView?
    private var backButton: NavigationButtonView?
    private var forwardButton: NavigationButtonView?
    private var deleteButton: NavigationButtonView?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init()")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init()")
    }
    
    public init() {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = settings.navigationBarBackgroundColor
        
        setupPageControl()
        setupButtons()
    }
    
    public override func didMoveToSuperview() {
        addConstraints()
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
        
        nextKeyboardButton = NavigationButtonView(type: NavigationButtonType.switchKeyboard)
        nextKeyboardButton?.navigationButtonViewDelegate = self
        
        backButton = NavigationButtonView(type: NavigationButtonType.previousPage)
        backButton?.navigationButtonViewDelegate = self
        
        forwardButton = NavigationButtonView(type: NavigationButtonType.nextPage)
        forwardButton?.navigationButtonViewDelegate = self
        
        deleteButton = NavigationButtonView(type: NavigationButtonType.deleteCharacter)
        deleteButton?.navigationButtonViewDelegate = self
        
        guard let nextKeyboardButton = nextKeyboardButton,
            let forwardButton = forwardButton,
            let backButton = backButton,
            let deleteButton = deleteButton else {
            fatalError("Could not setup buttons")
        }
        
        self.addSubview(nextKeyboardButton)
        self.addSubview(forwardButton)
        self.addSubview(backButton)
        self.addSubview(deleteButton)
    }
    
    // MARK: methods
    
    public func nextKeyboardPressed(sender: NavigationButtonView) {
        navigationBarDelegate?.nextKeyboardPressed(sender: self)
    }
    
    public func deletePressed(sender: NavigationButtonView) {
        navigationBarDelegate?.deletePressed(sender: self)
    }
    
    public func pagePlusOnePressed(sender: NavigationButtonView) {
        movePageControlUp(1)
        navigationBarDelegate?.pagePlusOnePressed(sender: self)
    }
    
    public func pageMinusOnePressed(sender: NavigationButtonView) {
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
        constrainToSuperview(edges: [.left, .bottom, .right])
        constrain(height: settings.navBarHeight)
    }
    
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

}
