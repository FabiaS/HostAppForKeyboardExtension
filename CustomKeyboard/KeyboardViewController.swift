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
        
        view.backgroundColor = settings.keysBackgroundColor
        setupViews()
    }
    
    private func setupViews() {

        horizontalScrollView = PagesScrollView()
        horizontalScrollView?.scrollViewDelegate = self
        
        allPagesView = PagesView()
        allPagesView?.pagesViewDelegate = self
        
        navigationBarView = NavigationBarView()
        navigationBarView?.navigationBarDelegate = self
        
        if let horizontalScrollView = horizontalScrollView,
            let allPagesView = allPagesView,
            let navigationBarView = navigationBarView {
            
            horizontalScrollView.addSubview(allPagesView)
            view.addSubview(horizontalScrollView)
            view.addSubview(navigationBarView)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // ???
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
