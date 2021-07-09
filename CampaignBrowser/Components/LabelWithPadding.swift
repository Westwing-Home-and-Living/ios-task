import UIKit


/**
 A custom label that has some padding between its frame and its displayed text. Configurable in Interface Builder.
 */
@IBDesignable
class LabelWithPadding: UILabel {
    
    /** The padding (in points). Will be added to left and right edges. */
    @IBInspectable var padding: CGFloat{
        set{
            textEdgeInsets.right = newValue
            textEdgeInsets.left = newValue
        }
        get{
            return self.padding
        }
    }
    
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRect = super.textRect(
            forBounds: bounds.inset(by: textEdgeInsets),
            limitedToNumberOfLines: numberOfLines
        )
        let invertedInsets = UIEdgeInsets(
            top: -textEdgeInsets.top,
            left: -textEdgeInsets.left,
            bottom: -textEdgeInsets.bottom,
            right: -textEdgeInsets.right
        )
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
}
