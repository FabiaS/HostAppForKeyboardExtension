import UIKit

public protocol PagesViewDelegate: class {
    func keyPressed(sender: PagesView, character: String)
}

public class PagesView: UIView, PageViewDelegate {
    
    public weak var pagesViewDelegate: PagesViewDelegate?
    private let settings = KeyboardSettings()
    private var pageViews = [PageView]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init()")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init()")
    }
    
    public init() {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupPages()
    }
    
    public override func didMoveToSuperview() {
        addConstraints()
        addConstraintsToSubviews()
    }
    
    private func setupPages() {
        for number in 1...settings.maxPageCount {
            
            let pageView = PageView(pageNumber: number)
            pageView.pageViewDelegate = self
            
            pageViews.append(pageView)
            addSubview(pageView)
        }
    }
    
    public func keyPressed(sender: PageView, character: String) {
        pagesViewDelegate?.keyPressed(sender: self, character: character)
    }
    
    private func addConstraints() {
        constrainToSuperview(edges: [.left, .top])
        
        let keyboardHeight: CGFloat // ???
        if UIDevice.current.orientation.isLandscape {
            keyboardHeight = UIScreen.mainScreenHeight/2.0
        } else {
            keyboardHeight = UIScreen.mainScreenHeight/2.5
        }
        
        // ???
        let maxScrollWidth = UIScreen.mainScreenWidth * CGFloat(settings.maxPageCount)
        constrain(width: maxScrollWidth-8)
        constrain(height: keyboardHeight-settings.navBarHeight-2)
    }
    
    private func addConstraintsToSubviews() {
        for number in 1...settings.maxPageCount {
            
            let page = getPage(number)
            page.constrainToSuperview(edges: [.top, .bottom])
            
            page.constrain(width: UIScreen.mainScreenWidth) // ???
            
            if number == 1 {
                page.constrainToSuperview(.left)
            } else {
                let previousPage = getPage(number-1)
                page.constrain(.left, to: previousPage, .right)
            }
        }
    }
    
    private func getPage(_ pageNumber: Int) -> PageView {
        if pageNumber < 1 || pageNumber > settings.maxPageCount {
            fatalError("pageNumber is out of bounds")
        }
        return pageViews[pageNumber-1]
    }
    
}

