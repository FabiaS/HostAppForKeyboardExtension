import UIKit

protocol PagesViewDelegate: class {
    func keyPressed(sender: PagesView, button: UIButton)
}

class PagesView: UIView, PageViewDelegate {
    
    weak var delegate: PagesViewDelegate?
    private var pageViews = [PageView]()
    private let settings = KeyboardSettings()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPages()
    }
    
    private func setupPages() {
        for number in 1...settings.maxPageCount {
            
            let pageView = PageView(frame: CGRect(), pageNumber: number)
            pageView.delegate = self
            
            pageViews.append(pageView)
            addSubview(pageView)
        }
    }
    
    func keyPressed(sender: PageView, button: UIButton) {
        delegate?.keyPressed(sender: self, button: button)
    }
    
    func getPage(_ pageNumber: Int) -> PageView {
        if pageNumber < 1 || pageNumber > settings.maxPageCount {
            fatalError("pageNumber is out of bounds")
        }
        return pageViews[pageNumber-1]
    }
    
}

