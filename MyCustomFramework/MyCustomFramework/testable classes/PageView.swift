import UIKit

public protocol PageViewDelegate: class {
    func keyPressed(sender: PageView, button: UIButton)
}

public class PageView: UIView, RowViewDelegate {
    
    public weak var delegate: PageViewDelegate?
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
        
        let pageTitles = ButtonTitles(pageNumber: pageNumber)
        setupRowsForPage(pageTitles)
        addConstraints()
    }
    
    private func setupRowsForPage(_ pageTitles: ButtonTitles) {
        for number in 1...settings.maxRowCount {
            
            guard let rowNumber = RowNumber(rawValue: number) else {
                fatalError("Could not create rowNumber")
            }
            
            let rowView = RowView(frame: CGRect(), rowTitles: pageTitles.getTitlesForRow(rowNumber))
            rowView.delegate = self
            
            rowViews.append(rowView)
            addSubview(rowView)
        }
    }
    
    public func keyPressed(sender: RowView, button: UIButton) {
        delegate?.keyPressed(sender: self, button: button)
    }
    
    private func addConstraints() {
        for (index, rowView) in rowViews.enumerated() {
            rowView.pinToSuperviewLeft(withInset: 0)
            rowView.pinToSuperviewRight(withInset: 0)
            
            if index == 0 {
                rowView.pinToSuperviewTop(withInset: 0)
                
                let scrollViewHeight = CGFloat(settings.keyboardHeight - settings.navBarHeight)
                let rowHeight = scrollViewHeight / CGFloat(settings.maxRowCount)
                rowView.addHeightConstraint(withConstant: rowHeight)
                
            } else {
                let previousRow = rowViews[index-1]
                rowView.attachToBottomOf(previousRow)
                rowView.equalHeightTo(previousRow)
            }
        }
    }
    
}
