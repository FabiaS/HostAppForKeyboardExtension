import UIKit

public protocol PagesViewDelegate: class {
    func keyPressed(sender: PagesView, character: String)
}

public class PagesView: UIView, PageViewDelegate {
    
    public weak var pagesViewDelegate: PagesViewDelegate?
    private var pageViews = [PageView]()
    private let settings = KeyboardSettings()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:)")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPages()
        addConstraintsToSubviews()
    }
    
    private func setupPages() {
        for number in 1...settings.maxPageCount {
            
            let pageView = PageView(frame: CGRect(), pageNumber: number)
            pageView.pageViewDelegate = self
            
            pageViews.append(pageView)
            addSubview(pageView)
        }
    }
    
    public func keyPressed(sender: PageView, character: String) {
        pagesViewDelegate?.keyPressed(sender: self, character: character)
    }
    
    public func addConstraintsToSubviews() {
        for number in 1...settings.maxPageCount {
            let page = getPage(number)
            page.pinToSuperviewTop()
            page.pinToSuperviewBottom()
            let mainScreenWidth = UIScreen.main.bounds.size.width
            page.addWidthConstraint(withConstant: mainScreenWidth)
            if number == 1 {
                page.pinToSuperviewLeft()
            } else {
                let previousPage = getPage(number-1)
                page.attachToRightOf(previousPage)
            }
        }
    }
    
    private func getPage(_ pageNumber: Int) -> PageView {
        if pageNumber < 1 || pageNumber > settings.maxPageCount {
            fatalError("pageNumber is out of bounds")
        }
        return pageViews[pageNumber-1]
    }
    
    public func addConstraintsToSuperview() {
        pinToSuperviewTop(withInset: 0)
        pinToSuperviewLeft(withInset: 0)
        let mainScreenWidth = UIScreen.main.bounds.size.width
        let maxScrollWidth = mainScreenWidth * CGFloat(settings.maxPageCount)
        addWidthConstraint(withConstant: maxScrollWidth)
        let scrollViewHeight = CGFloat(settings.keyboardHeight - settings.navBarHeight)
        addHeightConstraint(withConstant: scrollViewHeight)
    }
    
}

