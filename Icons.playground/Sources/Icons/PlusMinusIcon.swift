//
//  Checkmark.swift
//
//
//  Created by Matěj Jirásek on 31/03/16.
//
//

import UIKit

@IBDesignable
public class PlusMinusIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var plusColor: UIColor = UIColor.iconLightGreenColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var minusColor: UIColor = UIColor.iconRedColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var circle: Bool = true {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var minus: Bool {
        get {
            return Bool(value)
        }
        set (newValue) {
            value = CGFloat(newValue)
        }
    }

    // MARK: - Drawing methods

    override func draw(time: CGFloat = 0) {

        // General Declarations
        let context = UIGraphicsGetCurrentContext()

        let strokeColor = UIColor(between: plusColor, and: minusColor, using: colorMode, ratio: time)
        strokeColor.setStroke()
        let fillColor = strokeColor.colorWithAlphaComponent(fillAlpha)
        fillColor.setFill()

        // Variable Declarations
        let verticalAngle: CGFloat = minus ? -90 - time * 90 : -180 - (1 - time) * 90
        let horizontalAngle: CGFloat = minus ? -time * 180 : -180 - (1 - time) * 180
        let lineLength: CGFloat = circle ? 20 : 40
        let pointPosition: CGFloat = lineLength / 2.0
        let negativePointPosition: CGFloat = -pointPosition

        CGContextScaleCTM(context, scale, scale)
        CGContextTranslateCTM(context, 50, 50)

        // Circle Drawing
        if circle {

            let circlePath = UIBezierPath(ovalInRect: CGRect(x: -20, y: -20, width: 40, height: 40))
            circlePath.lineWidth = scaledLineWidth
            circlePath.fill()
            circlePath.stroke()

        }

        // Vertical line Drawing
        CGContextSaveGState(context)
        CGContextRotateCTM(context, -horizontalAngle * CGFloat(M_PI) / 180)

        let verticalLinePath = UIBezierPath(style: self)
        verticalLinePath.moveToPoint(CGPoint(x: pointPosition, y: 0))
        verticalLinePath.addLineToPoint(CGPoint(x: negativePointPosition, y: 0))

        verticalLinePath.stroke()

        CGContextRestoreGState(context)


        // Horizontal line Drawing
        CGContextSaveGState(context)
        CGContextRotateCTM(context, -verticalAngle * CGFloat(M_PI) / 180)

        let horizontalLinePath = UIBezierPath(style: self)
        horizontalLinePath.moveToPoint(CGPoint(x: pointPosition, y: 0))
        horizontalLinePath.addLineToPoint(CGPoint(x: negativePointPosition, y: 0))

        horizontalLinePath.stroke()

        CGContextRestoreGState(context)

    }

}
