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

    override func draw(in context: CGContext, at time: CGFloat) {

        // General Declarations
        let strokeColor = UIColor(between: playColor, and: stopColor, using: colorMode, ratio: time)
        strokeColor.setStroke()

        let fillColor = strokeColor.withAlphaComponent(fillAlpha)
        fillColor.setFill()

        // Variable Declarations
        let halfSize = size / 2.0

        context.scale(x: scale, y: scale)

        // Left line Drawing
        context.saveGState()
        context.translate(x: 50, y: 50)

        let leftLinePath = UIBezierPath(style: self)
        leftLinePath.move(to: CGPoint(x: -halfSize, y: halfSize))
        leftLinePath.addLine(to: CGPoint(x: halfSize, y: halfSize * time))
        leftLinePath.addLine(to: CGPoint(x: halfSize, y: -halfSize * time))
        leftLinePath.addLine(to: CGPoint(x: -halfSize, y: -halfSize))
        leftLinePath.addLine(to: CGPoint(x: -halfSize, y: halfSize))
        leftLinePath.close()

        leftLinePath.stroke()
        leftLinePath.fill()

        context.restoreGState()
    }

}
