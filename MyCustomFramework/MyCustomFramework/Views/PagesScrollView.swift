import UIKit

public protocol PagesScrollViewDelegate: class {
    func scrollViewDidScroll(sender: PagesScrollView, scrollViewContentOffset: CGPoint, scrollViewPageSize: CGSize)
}

public class PagesScrollView: UIScrollView, UIScrollViewDelegate {
    
    private let settings = KeyboardSettings()
    public weak var scrollViewDelegate: PagesScrollViewDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:)")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupPagesScrollView()
    }
    
    private func setupPagesScrollView() {
        delegate = self
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        let maxScrollWidth = UIScreen.mainScreenWidth * CGFloat(settings.maxPageCount)
        contentSize = CGSize(width: maxScrollWidth, height: settings.keyboardHeight) // ???
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
    
    public func addConstraintsToSuperview() {
        constrainToSuperview(.left)
        constrainToSuperview(.top)
        
        // ???
        constrain(width: UIScreen.mainScreenWidth)
        constrain(height: settings.keyboardHeight)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll(sender: self, scrollViewContentOffset: scrollView.contentOffset, scrollViewPageSize: scrollView.frame.size)
    }
    
}

