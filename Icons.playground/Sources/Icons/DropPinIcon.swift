//
//  HeartIcon.swift
//
//
//  Created by Matěj Jirásek on 3/04/16.
//
//

import UIKit

@IBDesignable
public class DropPinIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var strokeColor: UIColor = UIColor.white() {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    @IBInspectable public var fillColor: UIColor = UIColor.white() {
        didSet {
            layer.setNeedsDisplay()
        }
    }
    @IBInspectable public var circle: Bool = true {
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

    override func draw(in context: CGContext, at time: CGFloat) {

        if time == 0 {
            return
        }

        // General Declarations
        strokeColor.setStroke()
        fillColor.withAlphaComponent(time * fillAlpha).setFill()

        // Variable Declarations
        let circleLineLength: CGFloat = 20 * CGFloat.pi * time
        let pinLineLength: CGFloat = time * 154

        context.scale(x: scale, y: scale)
        context.translate(x: 50, y: 40)

        // Fill Drawing
        let fillPath = UIBezierPath(style: self)

        if circle {
            fillPath.move(to: CGPoint(x: 0, y: -10))
            fillPath.addCurve(to: CGPoint(x: -10, y: 0), controlPoint1: CGPoint(x: -5, y: -10), controlPoint2: CGPoint(x: -10, y: -5))
            fillPath.addCurve(to: CGPoint(x: -10, y: 0), controlPoint1: CGPoint(x: -10, y: 0), controlPoint2: CGPoint(x: -10, y: 0))
            fillPath.addCurve(to: CGPoint(x: 0, y: 10), controlPoint1: CGPoint(x: -10, y: 5), controlPoint2: CGPoint(x: -5, y: 10))
            fillPath.addCurve(to: CGPoint(x: 10, y: 0), controlPoint1: CGPoint(x: 5, y: 10), controlPoint2: CGPoint(x: 10, y: 5))
            fillPath.addCurve(to: CGPoint(x: 0, y: -10), controlPoint1: CGPoint(x: 10, y: -5), controlPoint2: CGPoint(x: 5, y: -10))
            fillPath.close()
        }

        fillPath.move(to: CGPoint(x: 0, y: 40))
        fillPath.addCurve(to: CGPoint(x: -20, y: 0), controlPoint1: CGPoint(x: -20, y: 15), controlPoint2: CGPoint(x: -20, y: 10))
        fillPath.addCurve(to: CGPoint(x: 0, y: -20), controlPoint1: CGPoint(x: -20, y: -10), controlPoint2: CGPoint(x: -10, y: -20))
        fillPath.addCurve(to: CGPoint(x: 20, y: 0), controlPoint1: CGPoint(x: 10, y: -20), controlPoint2: CGPoint(x: 20, y: -10))
        fillPath.addCurve(to: CGPoint(x: 0, y: 40), controlPoint1: CGPoint(x: 20, y: 10), controlPoint2: CGPoint(x: 20, y: 15))
        fillPath.close()

        fillPath.fill()

        if circle {
            // Circle Drawing
            context.saveGState()
            context.rotate(byAngle: -180 * CGFloat.pi / 180)

            let circlePath = UIBezierPath(style: self)
            circlePath.move(to: CGPoint(x: 0, y: -10))
            circlePath.addCurve(to: CGPoint(x: 10, y: 0), controlPoint1: CGPoint(x: 5, y: -10), controlPoint2: CGPoint(x: 10, y: -5))
            circlePath.addCurve(to: CGPoint(x: 0, y: 10), controlPoint1: CGPoint(x: 10, y: 5), controlPoint2: CGPoint(x: 5, y: 10))
            circlePath.addCurve(to: CGPoint(x: -10, y: 0), controlPoint1: CGPoint(x: -5, y: 10), controlPoint2: CGPoint(x: -10, y: 5))
            circlePath.addCurve(to: CGPoint(x: 0, y: -10), controlPoint1: CGPoint(x: -10, y: -5), controlPoint2: CGPoint(x: -5, y: -10))
            circlePath.close()

            if time < 1 {
                context.setLineDash(phase: 0, lengths: [circleLineLength, 400], count: 2)
            }
            circlePath.stroke()

            context.restoreGState()
        }


        // Drop Drawing

        let dropPath = UIBezierPath(style: self)
        dropPath.move(to: CGPoint(x: 0, y: 40))
        dropPath.addCurve(to: CGPoint(x: -20, y: 0), controlPoint1: CGPoint(x: -20, y: 15), controlPoint2: CGPoint(x: -20, y: 10))
        dropPath.addCurve(to: CGPoint(x: 0, y: -20), controlPoint1: CGPoint(x: -20, y: -10), controlPoint2: CGPoint(x: -10, y: -20))
        dropPath.addCurve(to: CGPoint(x: 20, y: 0), controlPoint1: CGPoint(x: 10, y: -20), controlPoint2: CGPoint(x: 20, y: -10))
        dropPath.addCurve(to: CGPoint(x: 0, y: 40), controlPoint1: CGPoint(x: 20, y: 10), controlPoint2: CGPoint(x: 20, y: 15))
        dropPath.close()

        if time < 1 {
            context.setLineDash(phase: 0, lengths: [pinLineLength, 154], count: 2)
        }
        dropPath.stroke()

    }

}
