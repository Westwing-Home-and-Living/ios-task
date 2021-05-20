import UIKit


/**
 A custom label that has some padding between its frame and its displayed text. Configurable in Interface Builder.
 */
@IBDesignable
class LabelWithPadding: UILabel {

    /** The padding (in points). Will be added to all edges. */
    @IBInspectable var horizontalPadding: CGFloat = 8
    @IBInspectable var verticalPadding: CGFloat = 8

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: verticalPadding,
                                                       left: horizontalPadding,
                                                       bottom: verticalPadding,
                                                       right: horizontalPadding)))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insettedBounds = bounds.inset(by: UIEdgeInsets(top: verticalPadding,
                                                 left: horizontalPadding,
                                                 bottom: verticalPadding,
                                                 right: horizontalPadding))
        return super.textRect(forBounds: insettedBounds, limitedToNumberOfLines: 0)
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + horizontalPadding * 2,
                      height: originalSize.height + verticalPadding * 2)
    }
}
