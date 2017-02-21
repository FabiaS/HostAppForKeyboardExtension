import UIKit

extension UIView {
    
    public func constrainToSuperview(edges: [NSLayoutAttribute], withOffset offset: CGFloat = 0) {
        for edge in edges {
            constrainToSuperview(edge, withOffset: offset)
        }
    }
    
    @discardableResult public func constrainToSuperview(_ edge: NSLayoutAttribute, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        let superview = prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: superview, attribute: edge, multiplier: 1, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult public func constrain(to view: UIView, _ edge: NSLayoutAttribute, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: view, attribute: edge, multiplier: 1, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    public func constrain(to view: UIView, edges: [NSLayoutAttribute], withOffset offset: CGFloat = 0) {
        for edge in edges {
            constrain(to: view, edge, withOffset: offset)
        }
    }
    
    @discardableResult public func constrain(height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult public func constrain(width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult public func constrain(_ edge: NSLayoutAttribute, to view: UIView, _ otherEdge: NSLayoutAttribute, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        _ = prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: view, attribute: otherEdge, multiplier: 1, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    public func add(_ view: UIView, constrainedTo edges: [NSLayoutAttribute], withOffset offset: CGFloat = 0) {
        addSubview(view)
        view.constrainToSuperview(edges: edges, withOffset: offset)
    }
    
    private func prepareForConstraints() -> UIView {
        guard let superview = self.superview else {
            fatalError("view doesn't have a superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        return superview
    }
    
    public func hugContent(_ axis: UILayoutConstraintAxis) {
        setContentHuggingPriority(UILayoutPriorityRequired, for: axis)
    }
    
    public func surroundedByView(insetBy inset: CGFloat) -> UIView {
        return surrounded(by: UIView(), inset: inset)
    }
    
    public func surrounded<T: UIView>(by view: T, inset: CGFloat) -> T {
        view.addSubview(self)
        constrainToSuperview(edges: [.leading, .top], withOffset: inset)
        constrainToSuperview(edges: [.trailing, .bottom], withOffset: -inset)
        return view
    }
    
}
