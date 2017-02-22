import UIKit

public protocol PagesScrollViewDelegate: class {
    func scrollViewDidScroll(sender: PagesScrollView, scrollViewContentOffset: CGPoint, scrollViewPageSize: CGSize)
}

public class PagesScrollView: UIScrollView, UIScrollViewDelegate {
    
    public weak var scrollViewDelegate: PagesScrollViewDelegate?
    private let settings = KeyboardSettings()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init()")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init()")
    }
    
    public init() {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupPagesScrollView()
    }
    
    public override func didMoveToSuperview() {
        addConstraints()
    }
    
    private func setupPagesScrollView() {
        delegate = self
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        let keyboardHeight: CGFloat // ???
        if UIDevice.current.orientation.isLandscape {
            keyboardHeight = UIScreen.mainScreenHeight/2.0
        } else {
            keyboardHeight = UIScreen.mainScreenHeight/2.5
        }
        
        let maxScrollWidth = UIScreen.mainScreenWidth * CGFloat(settings.maxPageCount)
        contentSize = CGSize(width: maxScrollWidth, height: keyboardHeight-settings.navBarHeight) // ???
    }
    
    public func moveScrollViewOneUp() {
        let visibleScrollWidth = self.frame.width
        let maxScrollWidth = visibleScrollWidth * CGFloat(settings.maxPageCount)
        let contentOffset = self.contentOffset.x
        
        if (contentOffset + visibleScrollWidth) < maxScrollWidth {
            let newOrigin = CGPoint(x: contentOffset+visibleScrollWidth, y:0)
            let oldSize = CGSize(width: self.frame.width, height: self.frame.height)
            self.scrollRectToVisible(CGRect(origin: newOrigin, size: oldSize), animated: true)
        }
    }
    
    public func moveScrollViewOneDown() {
        let visibleWidth = self.frame.width
        let contentOffset = self.contentOffset.x
        
        if  (contentOffset + visibleWidth) > visibleWidth {
            let newOrigin = CGPoint(x: contentOffset-visibleWidth, y:0)
            let oldSize = CGSize(width: self.frame.width, height: self.frame.height)
            self.scrollRectToVisible(CGRect(origin: newOrigin, size: oldSize), animated: true)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll(sender: self, scrollViewContentOffset: scrollView.contentOffset, scrollViewPageSize: scrollView.frame.size)
    }
    
    private func addConstraints() {
        constrainToSuperview(.left)
        constrainToSuperview(.top)
        
        let keyboardHeight: CGFloat // ???
        if UIDevice.current.orientation.isLandscape {
            keyboardHeight = UIScreen.mainScreenHeight/2.0
        } else {
            keyboardHeight = UIScreen.mainScreenHeight/2.5
        }
        
        // ???
        constrain(width: UIScreen.mainScreenWidth)
        constrain(height: keyboardHeight-settings.navBarHeight)
    }
    
}

