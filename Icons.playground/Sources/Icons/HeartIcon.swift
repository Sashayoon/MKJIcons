//
//  HeartIcon.swift
//
//
//  Created by Matěj Jirásek on 3/04/16.
//
//

import UIKit

@IBDesignable
public class HeartIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var strokeColor: UIColor = UIColor.iconRedColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    @IBInspectable public var fillColor: UIColor = UIColor.iconRedColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    @IBInspectable public var twoLines: Bool = true {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var visible: Bool {
        get {
            return Bool(value)
        }
        set (newValue) {
            value = CGFloat(newValue)
        }
    }

    // MARK: - Drawing methods

    override func draw(time: CGFloat = 0) {

        if time == 0 {
            return
        }

        // General Declarations
        let context = UIGraphicsGetCurrentContext()

        CGContextClearRect(context, CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        // Variable Declarations
        let dash: CGFloat = time * (twoLines ? 82 : 164)
        let gap: CGFloat = -5 + (1 - time) * (twoLines ? 82 : 164)
        let phase: CGFloat = -0.5

        CGContextScaleCTM(context, scale, scale)

        // Bezier Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 50, 75)
        CGContextRotateCTM(context, -45 * CGFloat(M_PI) / 180)

        let bezierPath = UIBezierPath(style: self)
        bezierPath.moveToPoint(CGPoint(x: 30, y: -30.19))
        bezierPath.addLineToPoint(CGPoint(x: 30, y: -30))
        bezierPath.addCurveToPoint(CGPoint(x: 45, y: -15), controlPoint1: CGPoint(x: 38.28, y: -30), controlPoint2: CGPoint(x: 45, y: -23.28))
        bezierPath.addCurveToPoint(CGPoint(x: 30, y: 0), controlPoint1: CGPoint(x: 45, y: -6.72), controlPoint2: CGPoint(x: 38.28, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: -30))
        bezierPath.addCurveToPoint(CGPoint(x: 5.94, y: -41.95), controlPoint1: CGPoint(x: 0, y: -34.88), controlPoint2: CGPoint(x: 2.33, y: -39.21))
        bezierPath.addLineToPoint(CGPoint(x: 6.03, y: -42.02))
        bezierPath.addCurveToPoint(CGPoint(x: 15, y: -45), controlPoint1: CGPoint(x: 8.53, y: -43.89), controlPoint2: CGPoint(x: 11.64, y: -45))
        bezierPath.addCurveToPoint(CGPoint(x: 30, y: -30.19), controlPoint1: CGPoint(x: 23.22, y: -45), controlPoint2: CGPoint(x: 29.9, y: -38.39))
        bezierPath.closePath()

        strokeColor.setStroke()
        fillColor.colorWithAlphaComponent(time * fillAlpha).setFill()
        CGContextSaveGState(context)

        if time < 1 {
            CGContextSetLineDash(context, phase, [dash < 0 ? 0 : dash, gap < 0 ? 0 : gap], 2)
        }
        bezierPath.fill()
        bezierPath.stroke()
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)

    }

}
