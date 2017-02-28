import UIKit

public protocol PageViewDelegate: class {
    func keyPressed(sender: PageView, character: String)
}

public class PageView: UIView, RowViewDelegate {
    
    public weak var pageViewDelegate: PageViewDelegate?
    private let settings = KeyboardSettings()
    private var rowViews = [RowView]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(pageNumber:)")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(pageNumber:)")
    }
    
    public init(pageNumber: Int) {
        super.init(frame: CGRect())
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let pageTitles = ButtonTitles(forPage: pageNumber)
        setupRowsForPage(with: pageTitles)
    }
    
    public override func didMoveToSuperview() {
        addConstraintsToSubviews()
    }
    
    private func setupRowsForPage(with pageTitles: ButtonTitles) {
        for rowNumber in 1...settings.maxRowCount {
            
            let rowTitles = pageTitles.getTitles(forRow: rowNumber)
            let rowView = RowView(titles: rowTitles)
            rowView.rowViewDelegate = self
            
            rowViews.append(rowView)
            addSubview(rowView)
        }
    }
    
    public func keyPressed(sender: RowView, character: String) {
        pageViewDelegate?.keyPressed(sender: self, character: character)
    }
    
    private func addConstraintsToSubviews() {
        for (index, rowView) in rowViews.enumerated() {
            
            rowView.constrainToSuperview(edges: [.left, .right])
            
            let keyboardHeight: CGFloat = UIScreen.mainScreenHeight/2.5
            let maxNumberOfRows = settings.maxRowCount
            let rowHeight = (keyboardHeight-settings.navBarHeight) / CGFloat(maxNumberOfRows)
            rowView.constrain(height: rowHeight)
            
            if index == maxNumberOfRows-1 {
                rowView.constrainToSuperview(.bottom)
            } else {
                let nextRow = rowViews[index+1]
                rowView.constrain(.bottom, to: nextRow, .top)
            }
        }
    }
    
}
