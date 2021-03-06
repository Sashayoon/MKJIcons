//
//  Checkmark.swift
//
//
//  Created by Matěj Jirásek on 31/03/16.
//
//

import UIKit

@IBDesignable
public class PlayStopIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var size: CGFloat = 40 {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var playColor: UIColor = UIColor.iconLightGreenColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var stopColor: UIColor = UIColor.iconRedColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var playing: Bool {
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

        let strokeColor = UIColor(between: playColor, and: stopColor, using: colorMode, ratio: time)
        strokeColor.setStroke()

        let fillColor = strokeColor.colorWithAlphaComponent(fillAlpha)
        fillColor.setFill()

        // Variable Declarations
        let halfSize = size / 2.0

        CGContextScaleCTM(context, scale, scale)

        // Left line Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 50, 50)

        let leftLinePath = UIBezierPath(style: self)
        leftLinePath.moveToPoint(CGPoint(x: -halfSize, y: halfSize))
        leftLinePath.addLineToPoint(CGPoint(x: halfSize, y: halfSize * time))
        leftLinePath.addLineToPoint(CGPoint(x: halfSize, y: -halfSize * time))
        leftLinePath.addLineToPoint(CGPoint(x: -halfSize, y: -halfSize))
        leftLinePath.addLineToPoint(CGPoint(x: -halfSize, y: halfSize))
        leftLinePath.closePath()

        leftLinePath.stroke()
        leftLinePath.fill()

        CGContextRestoreGState(context)
    }

}
