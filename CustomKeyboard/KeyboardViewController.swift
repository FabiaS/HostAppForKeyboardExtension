import Foundation
import UIKit

class KeyboardViewController: UIInputViewController, UIScrollViewDelegate, NavigationBarViewDelegate, PagesViewDelegate {
    
    private var navigationBarView: NavigationBarView?
    private var horizontalScrollView: UIScrollView?
    private var pagesView: PagesView?
    private let settings = KeyboardSettings()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(nibName:bundle:")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = settings.keysBackgroundColor
        setupPages()
        setupNavigationBar()
        addConstraints()
    }
    
    // MARK: Views
    
    private func setupNavigationBar() {
        navigationBarView = NavigationBarView(frame: CGRect())
        guard let navigationBarView = navigationBarView else {
            fatalError("Could not setup navigationBarView")
        }
        navigationBarView.delegate = self
        view.addSubview(navigationBarView)
    }
    
    private func setupPages() {
        horizontalScrollView = UIScrollView(frame: CGRect())
        horizontalScrollView?.delegate = self
        horizontalScrollView?.showsVerticalScrollIndicator = false
        horizontalScrollView?.showsHorizontalScrollIndicator = false
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let maxScrollWidth = mainScreenWidth * CGFloat(settings.maxPageCount)
        let scrollHeight = CGFloat(settings.keyboardHeight - settings.navBarHeight)
        horizontalScrollView?.contentSize = CGSize(width: maxScrollWidth, height: scrollHeight)
        guard let horizontalScrollView = horizontalScrollView else {
            fatalError("Could not setup horizontalScrollView")
        }
        view.addSubview(horizontalScrollView)
        
        pagesView = PagesView(frame: CGRect())
        guard let pagesView = pagesView else {
            fatalError("Could not setup pagesView")
        }
        pagesView.delegate = self
        horizontalScrollView.addSubview(pagesView)
    }
    
    private func addConstraints() {
        
        guard let navigationBarView = navigationBarView else {
            fatalError("Could not find navigationBarView")
        }
        navigationBarView.pinToSuperviewTop(withInset: 0)
        navigationBarView.pinToSuperviewLeft(withInset: 0)
        navigationBarView.pinToSuperviewRight(withInset: 0)
        let navBarHeight = CGFloat(settings.navBarHeight)
        navigationBarView.addHeightConstraint(withConstant: navBarHeight)
        
        guard let horizontalScrollView = horizontalScrollView else {
            fatalError("Could not find horizontalScrollView")
        }
        horizontalScrollView.attachToBottomOf(navigationBarView)
        horizontalScrollView.pinToSuperviewLeft(withInset: 0)
        horizontalScrollView.pinToSuperviewRight(withInset: 0)
        let scrollViewHeight = CGFloat(settings.keyboardHeight - settings.navBarHeight)
        horizontalScrollView.addHeightConstraint(withConstant: scrollViewHeight)
        
        guard let pagesView = pagesView else {
            fatalError("Could not find pagesView")
        }
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let maxScrollWidth = mainScreenWidth * CGFloat(settings.maxPageCount)
        pagesView.pinToSuperviewTop(withInset: 0)
        pagesView.pinToSuperviewLeft(withInset: 0)
        pagesView.addWidthConstraint(withConstant: maxScrollWidth)
        pagesView.equalHeightTo(horizontalScrollView)
        
        for number in 1...settings.maxPageCount {
            
            let page = pagesView.getPage(number) 
            page.pinToSuperviewTop()
            page.pinToSuperviewBottom()
            page.addWidthConstraint(withConstant: mainScreenWidth)
            if number == 1 {
                page.pinToSuperviewLeft()
            } else {
                let previousPage = pagesView.getPage(number-1)
                page.attachToRightOf(previousPage)
            }
        }
    }
    
    // MARK: Action methods
    
    // A text document proxy provides textual context to a custom keyboard.
    // It inherits from UIKeyInput (insertText:, deleteBackward, hasText).
    // Additionally it can adjustTextPositionByCharacterOffset and it gives you documentContextBeforeInput: or documentContextAfterInput:
    
    func keyPressed(sender: PagesView, button: UIButton) {
        if let title = button.title(for: .normal) {
            self.textDocumentProxy.insertText("\(title)")
        }
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        })
    }
    
    func deletePressed(sender: NavigationBarView) {
        self.textDocumentProxy.deleteBackward()
    }
    
    func nextKeyboardPressed(sender: NavigationBarView) {
        advanceToNextInputMode()
    }
    
    func pagePlusOnePressed(sender: NavigationBarView) {
        navigationBarView?.movePageControlUp(1)
        moveScrollViewOneUp()
    }
    
    func pageMinusOnePressed(sender: NavigationBarView) {
        navigationBarView?.movePageControlDown(1)
        moveScrollViewOneDown()
    }
    
    // MARK: Scroll methods
    
    private func moveScrollViewOneUp() {
        guard let scrollView = horizontalScrollView else {
            fatalError("Could not find horizontalScrollView")
        }
        let visibleScrollWidth = scrollView.frame.width
        let maxScrollWidth = visibleScrollWidth * CGFloat(settings.maxPageCount)
        let contentOffset = scrollView.contentOffset.x
        
        if (contentOffset + visibleScrollWidth) < maxScrollWidth {
            let newOrigin = CGPoint(x: contentOffset+visibleScrollWidth, y:0)
            let oldSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.scrollRectToVisible(CGRect(origin: newOrigin, size: oldSize), animated: true)
        }
    }
    
    private func moveScrollViewOneDown() {
        guard let scrollView = horizontalScrollView else {
            fatalError("Could not find horizontalScrollView")
        }
        let visibleWidth = scrollView.frame.width
        let contentOffset = scrollView.contentOffset.x
        
        if  (contentOffset + visibleWidth) > visibleWidth {
            let newOrigin = CGPoint(x: contentOffset-visibleWidth, y:0)
            let oldSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.scrollRectToVisible(CGRect(origin: newOrigin, size: oldSize), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationBarView?.updatePageControlWith(scrollViewContentOffset: scrollView.contentOffset,
                                                 scrollViewPageSize: scrollView.frame.size)
    }
    
}
