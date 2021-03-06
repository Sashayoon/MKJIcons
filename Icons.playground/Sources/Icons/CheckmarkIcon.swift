//
//  Checkmark.swift
//
//
//  Created by Matěj Jirásek on 31/03/16.
//
//

import UIKit

@IBDesignable
public class CheckmarkIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var checkmarkColor: UIColor = UIColor.iconLightGreenColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    @IBInspectable public var crossColor: UIColor = UIColor.iconRedColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var checked: Bool {
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

        CGContextClearRect(context, CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        let currentColor = UIColor(between: crossColor, and: checkmarkColor, using: colorMode, ratio: time)

        // Variable Declarations
        let phase: CGFloat = -time * 111
        let dash: CGFloat = (1 - time / 2.0) * 57

        CGContextScaleCTM(context, scale, scale)

        // Static line Drawing
        let staticLinePath = UIBezierPath(style: self)
        staticLinePath.moveToPoint(CGPoint(x: 70, y: 30))
        staticLinePath.addLineToPoint(CGPoint(x: 30, y: 70))

        currentColor.setStroke()
        staticLinePath.stroke()


        // Animated line Drawing
        let animatedLinePath = UIBezierPath(style: self)
        animatedLinePath.moveToPoint(CGPoint(x: 30, y: 30))
        animatedLinePath.addCurveToPoint(CGPoint(x: 70, y: 70), controlPoint1: CGPoint(x: 30, y: 30), controlPoint2: CGPoint(x: 56.58, y: 56.58))
        animatedLinePath.addCurveToPoint(CGPoint(x: 30, y: 70), controlPoint1: CGPoint(x: 83.42, y: 83.42), controlPoint2: CGPoint(x: 46.03, y: 86.03))
        animatedLinePath.addCurveToPoint(CGPoint(x: 10, y: 50), controlPoint1: CGPoint(x: 13.97, y: 53.97), controlPoint2: CGPoint(x: 10, y: 50))

        CGContextSaveGState(context)
        CGContextSetLineDash(context, phase, [dash, 200], 2)
        animatedLinePath.stroke()
        CGContextRestoreGState(context)
    }

}
