//
//  BurgerIcon.swift
//
//
//  Created by Matěj Jirásek on 31/03/16.
//
//

import UIKit

@IBDesignable
public class BurgerIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var burgerColor: UIColor = UIColor.white() {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    @IBInspectable public var crossColor: UIColor = UIColor.iconRedColor {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var open: Bool {
        get {
            return Bool(value)
        }
        set (newValue) {
            value = CGFloat(newValue)
        }
    }

    // MARK: - Drawing methods

    override func draw(in context: CGContext, at time: CGFloat) {

        let offset: CGFloat = 5

        // General Declarations
        context.clear(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        let currentColor = UIColor(between: burgerColor, and: crossColor, using: colorMode, ratio: time)

        // Variable Declarations
        let angle: CGFloat = time * 45
        let negativeAngle: CGFloat = -angle
        let localScale: CGFloat = 1 + time * 0.414
        let opacity = UIColor(red: burgerColor.red, green: burgerColor.green, blue: burgerColor.blue, alpha: burgerColor.alpha - time * burgerColor.alpha)
        let timedOffset: CGFloat = time * offset
        let negativeTimedOffset: CGFloat = -timedOffset
        let timeLineWidth: CGFloat = scaledLineWidth / localScale

        context.scale(x: scale, y: scale)

        // Bottom Drawing
        context.saveGState()
        context.translate(x: 30, y: (timedOffset + 65))
        context.rotate(byAngle: -angle * CGFloat.pi / 180)
        context.scale(x: localScale, y: localScale)

        let bottomPath = UIBezierPath(style: self)
        bottomPath.move(to: CGPoint(x: 40, y: 0))
        bottomPath.addLine(to: CGPoint(x: 0, y: 0))

        currentColor.setStroke()
        bottomPath.lineWidth = timeLineWidth
        bottomPath.stroke()

        context.restoreGState()


        // Middle Drawing
        context.saveGState()
        context.translate(x: 50, y: 50)

        let middlePath = UIBezierPath(style: self)
        middlePath.move(to: CGPoint(x: 20, y: 0))
        middlePath.addLine(to: CGPoint(x: -20, y: 0))

        opacity.setStroke()
        middlePath.stroke()

        context.restoreGState()


        // Top Drawing
        context.saveGState()
        context.translate(x: 30, y: (negativeTimedOffset + 35))
        context.rotate(byAngle: -negativeAngle * CGFloat(M_PI) / 180)
        context.scale(x: localScale, y: localScale)

        let topPath = UIBezierPath(style: self)
        topPath.move(to: CGPoint(x: 40, y: 0))
        topPath.addLine(to: CGPoint(x: 0, y: 0))

        currentColor.setStroke()
        topPath.lineWidth = timeLineWidth
        topPath.stroke()

        context.restoreGState()
    }

}
