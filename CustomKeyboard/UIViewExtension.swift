import UIKit

enum Edge {
    case top
    case left
    case bottom
    case right
}

extension UIViewController {
    @discardableResult func pinToTopLayoutGuide(view subview: UIView, withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: subview, attribute: .top,
            relatedBy: .equal,
            toItem: topLayoutGuide, attribute: .bottom,
            multiplier: 1, constant: inset
        )
        
        view.addConstraint(constraint)
        
        return constraint
    }
}

extension UIView {
    
    func pinToSuperview(_ edges: [Edge], constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) {
        for edge in edges {
            switch edge {
            case .top: pinToSuperviewTop(withInset: constant, priority: priority)
            case .left: pinToSuperviewLeft(withInset: constant, priority: priority)
            case .bottom: pinToSuperviewBottom(withInset: constant, priority: priority)
            case .right: pinToSuperviewRight(withInset: constant, priority: priority)
            }
        }
    }
    
    @discardableResult func pinToSuperviewTop(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        return alignTopToView(superview, constant: inset, priority: priority)
    }
    
    @discardableResult func limitToSuperviewTop(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: superview, attribute: .top,
            multiplier: 1, constant: inset
        )
        
        constraint.priority = priority
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    
    @discardableResult func limitToSuperviewTop(withRange range:(min: CGFloat, max: CGFloat), priority: UILayoutPriority = UILayoutPriorityRequired) -> (min: NSLayoutConstraint, max: NSLayoutConstraint) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let minConstraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: superview, attribute: .top,
            multiplier: 1, constant: range.min
        )
        
        minConstraint.priority = priority
        superview.addConstraint(minConstraint)
        
        let maxConstraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .lessThanOrEqual,
            toItem: superview, attribute: .top,
            multiplier: 1, constant: range.max
        )
        
        maxConstraint.priority = priority
        superview.addConstraint(maxConstraint)
        
        return (minConstraint, maxConstraint)
    }
    
    @discardableResult func limitToSuperviewBottom(withRange range:(min: CGFloat, max: CGFloat), priority: UILayoutPriority = UILayoutPriorityRequired) -> (min: NSLayoutConstraint, max: NSLayoutConstraint) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let minConstraint = NSLayoutConstraint(
            item: superview, attribute: .bottom,
            relatedBy: .greaterThanOrEqual,
            toItem: self, attribute: .bottom,
            multiplier: 1, constant: range.min
        )
        
        minConstraint.priority = priority
        superview.addConstraint(minConstraint)
        
        let maxConstraint = NSLayoutConstraint(
            item: superview, attribute: .bottom,
            relatedBy: .lessThanOrEqual,
            toItem: self, attribute: .bottom,
            multiplier: 1, constant: range.max
        )
        
        maxConstraint.priority = priority
        superview.addConstraint(maxConstraint)
        
        return (minConstraint, maxConstraint)
    }
    
    
    @discardableResult func pinToSuperviewBottom(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        return alignBottomToView(superview, constant: -inset, priority: priority)
    }
    
    @discardableResult func limitToSuperviewBottom(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: superview, attribute: .bottom,
            relatedBy: .greaterThanOrEqual,
            toItem: self, attribute: .bottom,
            multiplier: 1, constant: inset
        )
        
        constraint.priority = priority
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func pinToSuperviewLeft(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .left,
            relatedBy: .equal,
            toItem: superview, attribute: .left,
            multiplier: 1, constant: inset)
        
        constraint.priority = priority
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func limitToSuperviewLeft(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .left,
            relatedBy: .greaterThanOrEqual,
            toItem: superview, attribute: .left,
            multiplier: 1, constant: inset)
        
        constraint.priority = priority
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func pinToSuperviewRight(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: superview, attribute: .right,
            relatedBy: .equal,
            toItem: self, attribute: .right,
            multiplier: 1, constant: inset)
        
        constraint.priority = priority
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func limitToSuperviewRight(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: superview, attribute: .right,
            relatedBy: .greaterThanOrEqual,
            toItem: self, attribute: .right,
            multiplier: 1, constant: inset)
        
        constraint.priority = priority
        superview.addConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func pinViewToMyRight(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func pinViewToMyBottom(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    func addSizeConstraints(width: CGFloat, height: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) {
        addWidthConstraint(withConstant: width, priority: priority)
        addHeightConstraint(withConstant:height, priority: priority)
    }
    
    @discardableResult func addHeightConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func addMaxHeightConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func addMinHeightConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func addWidthConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func addMaxWidthConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func equalWidthTo(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func equalHeightTo(_ view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .height,
            relatedBy: .equal, toItem: view,
            attribute: .height, multiplier: multiplier,
            constant: constant
        )
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func maxHeightEqualTo(_ view: UIView, multiplier: CGFloat = 1, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .lessThanOrEqual, toItem: view, attribute: .height, multiplier: multiplier, constant: 0)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    func positionInContainer(_ containerView: UIView, insets: UIEdgeInsets) {
        
        precondition(containerView == self.superview, "containerView is not the superview of self")
        self.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                                                       toItem: containerView, attribute: .top, multiplier: 1.0, constant: insets.top))
        
        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal,
                                                       toItem: containerView, attribute: .left, multiplier: 1.0, constant: insets.left))
        
        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                                                       toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: insets.bottom))
        
        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal,
                                                       toItem: containerView, attribute: .right, multiplier: 1.0, constant: insets.right))
        
    }
    
    func centerInContainer(_ containerView: UIView, margin: CGFloat) {
        
        let edgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: -margin, right: -margin)
        self.positionInContainer(containerView, insets: edgeInsets)
        
    }
    
    func pinToSuperviewEdges(withInset inset: CGFloat = 0) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        self.positionInContainer(superview, insets: edgeInsets)
    }
    
    func centerInSuperview(withInset inset: CGFloat = 0) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        self.positionInContainer(superview, insets: edgeInsets)
    }
    
}

extension UIView {
    
    func centerViewsVertically(view1: UIView, view2: UIView) {
        let topSpacer = UIView()
        let bottomSpacer = UIView()
        self.addSubview(topSpacer)
        self.addSubview(bottomSpacer)
        topSpacer.isHidden = true
        bottomSpacer.isHidden = true
        
        topSpacer.pinToSuperviewTop()
        topSpacer.pinViewToMyBottom(view1)
        view1.pinViewToMyBottom(view2)
        view2.pinViewToMyBottom(bottomSpacer)
        bottomSpacer.pinToSuperviewBottom()
        topSpacer.equalHeightTo(bottomSpacer)
    }
    
}

// MARK: - Attach to Sibling

extension UIView {
    @discardableResult func attachToBottomOf(
        _ view: UIView,
        withConstant constant: CGFloat = 0,
        priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .equal,
            toItem: view, attribute: .bottom,
            multiplier: 1.0, constant: constant
        )
        
        constraint.priority = priority
        
        addSiblingConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func limitToBottomOf(
        _ view: UIView,
        withConstant constant: CGFloat = 0,
        priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: view, attribute: .bottom,
            multiplier: 1.0, constant: constant
        )
        
        constraint.priority = priority
        
        addSiblingConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func attachToBottomOf(
        _ view: UIView,
        withRange range:(min: CGFloat, max: CGFloat),
        priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> (min: NSLayoutConstraint, max: NSLayoutConstraint) {
        
        let minConstraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .greaterThanOrEqual,
            toItem: view, attribute: .bottom,
            multiplier: 1.0, constant: range.min
        )
        
        minConstraint.priority = priority
        addSiblingConstraint(minConstraint)
        
        let maxConstraint = NSLayoutConstraint(
            item: self, attribute: .top,
            relatedBy: .lessThanOrEqual,
            toItem: view, attribute: .bottom,
            multiplier: 1.0, constant: range.max
        )
        
        maxConstraint.priority = priority
        addSiblingConstraint(maxConstraint)
        
        return (minConstraint, maxConstraint)
    }
    
    @discardableResult func attachToRightOf(
        _ view: UIView,
        withConstant constant: CGFloat = 0,
        priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .left,
            relatedBy: .equal,
            toItem: view, attribute: .right,
            multiplier: 1.0, constant: constant
        )
        
        constraint.priority = priority
        
        addSiblingConstraint(constraint)
        
        return constraint
    }
    
    fileprivate func addSiblingConstraint(_ constraint: NSLayoutConstraint) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        if let firstItem = constraint.firstItem as? UIView , firstItem != superview {
            firstItem.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if let secondItem = constraint.secondItem as? UIView , secondItem != superview {
            secondItem.translatesAutoresizingMaskIntoConstraints = false
        }
        
        superview.addConstraint(constraint)
    }
}


// MARK: Aligning sibling views

extension UIView {
    
    @discardableResult func alignTopToView(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func alignBottomToView(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func alignLeftToView(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func alignRightToView(_ view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func alignHorizontalCenter(withView view: UIView, withMultiplier multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .centerX,
            relatedBy: .equal,
            toItem: view, attribute: .centerX,
            multiplier: multiplier, constant: 0
        )
        
        addSiblingConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func alignHorizontalCenterWithSuperview(withMultiplier multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let superview = unWrappedSuperview()
        return alignHorizontalCenter(withView: superview, withMultiplier: multiplier)
    }
    
    @discardableResult func alignVerticalCenter(withView view: UIView, withMultiplier multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .centerY,
            relatedBy: .equal,
            toItem: view, attribute: .centerY,
            multiplier: multiplier, constant: 0
        )
        
        constraint.priority = priority
        
        addSiblingConstraint(constraint)
        
        return constraint
    }
    
    @discardableResult func alignVerticalCenterWithSuperview(withMultiplier multiplier: CGFloat = 1.0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        let superview = unWrappedSuperview()
        
        let constraint = alignVerticalCenter(withView: superview, withMultiplier: multiplier, priority: priority)
        
        return constraint
    }
    
    func alignEdges(withView view: UIView, withInset inset: CGFloat = 0.0, priority: UILayoutPriority = UILayoutPriorityRequired) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        self.positionInContainer(view, insets: edgeInsets)
    }
    
    fileprivate func unWrappedSuperview() -> UIView {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return superview
    }
    
}


