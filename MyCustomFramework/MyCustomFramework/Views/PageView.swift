import UIKit

public protocol PageViewDelegate: class {
    func keyPressed(sender: PageView, character: String)
}

public class PageView: UIView, RowViewDelegate {
    
    public weak var pageViewDelegate: PageViewDelegate?
    private var rowViews = [RowView]()
    private let settings = KeyboardSettings()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use init(frame:pageNumber:)")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented - use init(frame:pageNumber:)")
    }
    
    public init(frame: CGRect, pageNumber: Int) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let pageTitles = ButtonTitles(pageNumber: pageNumber)
        setupRowsForPage(pageTitles)
        addConstraintsToSubviews()
    }
    
    private func setupRowsForPage(_ pageTitles: ButtonTitles) {
        for number in 1...settings.maxRowCount {
            
            guard let rowNumber = RowNumber(rawValue: number) else {
                fatalError("Could not create rowNumber")
            }
            
            let rowView = RowView(frame: CGRect(), rowTitles: pageTitles.getTitlesForRow(rowNumber))
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
            
            let maxNumberOfRows = settings.maxRowCount
            let rowHeight = settings.keyboardHeight / CGFloat(maxNumberOfRows)
            rowView.constrain(height: rowHeight) // ??? 
            
            if index == maxNumberOfRows-1 {
                rowView.constrainToSuperview(.bottom)
            } else {
                let nextRow = rowViews[index+1]
                rowView.constrain(.bottom, to: nextRow, .top)
            }
        }
    }
    
}
