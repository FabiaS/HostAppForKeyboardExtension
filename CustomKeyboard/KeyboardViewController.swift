import Foundation
import UIKit
import MyCustomFramework

class KeyboardViewController: UIInputViewController, NavigationBarViewDelegate, PagesScrollViewDelegate, PagesViewDelegate {
    
    private var navigationBarView: NavigationBarView?
    private var horizontalScrollView: PagesScrollView?
    private var allPagesView: PagesView?
    private let settings = KeyboardSettings()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(nibName:bundle:")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = settings.keysBackgroundColor

        horizontalScrollView = PagesScrollView(frame: CGRect())
        horizontalScrollView?.scrollViewDelegate = self
        
        allPagesView = PagesView(frame: CGRect())
        allPagesView?.pagesViewDelegate = self
        
        navigationBarView = NavigationBarView(frame: CGRect())
        navigationBarView?.navigationBarDelegate = self
        
        if let horizontalScrollView = horizontalScrollView,
            let allPagesView = allPagesView,
            let navigationBarView = navigationBarView {
            
            horizontalScrollView.addSubview(allPagesView)
            view.addSubview(horizontalScrollView)
            view.addSubview(navigationBarView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let horizontalScrollView = horizontalScrollView,
            let allPagesView = allPagesView,
            let navigationBarView = navigationBarView {
            
            horizontalScrollView.addConstraintsToSuperview()
            allPagesView.addConstraintsToSuperview()
            navigationBarView.addConstraintsToSuperview()
            // This cannot be done when setting up the views because their superviews are nil until they are added to one.
        }
    }
    
    // MARK: delegate methods
    
    // A text document proxy provides textual context to a custom keyboard.
    // It is a property of UIInputViewControllers.
    // It inherits from UIKeyInput (insertText:, deleteBackward, hasText).
    // Additionally it can 'adjustTextPositionByCharacterOffset' and it provides 'documentContextBeforeInput:' or 'documentContextAfterInput:'
    
    func keyPressed(sender: PagesView, character: String) {
        self.textDocumentProxy.insertText(character)
    }
    
    func deletePressed(sender: NavigationBarView) {
        self.textDocumentProxy.deleteBackward()
    }
    
    func nextKeyboardPressed(sender: NavigationBarView) {
        advanceToNextInputMode()
    }
    
    func pagePlusOnePressed(sender: NavigationBarView) {
        horizontalScrollView?.moveScrollViewOneUp()
    }
    
    func pageMinusOnePressed(sender: NavigationBarView) {
        horizontalScrollView?.moveScrollViewOneDown()
    }
    
    func scrollViewDidScroll(sender: PagesScrollView, scrollViewContentOffset: CGPoint, scrollViewPageSize: CGSize) {
        navigationBarView?.updatePageControlWith(scrollViewContentOffset: scrollViewContentOffset, scrollViewPageSize: scrollViewPageSize)
    }
    
}
