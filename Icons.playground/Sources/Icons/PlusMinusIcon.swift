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

    override func draw(in context: CGContext, at time: CGFloat) {

        // General Declarations
        let strokeColor = UIColor(between: plusColor, and: minusColor, using: colorMode, ratio: time)
        strokeColor.setStroke()
        let fillColor = strokeColor.withAlphaComponent(fillAlpha)
        fillColor.setFill()

        // Variable Declarations
        let verticalAngle: CGFloat = minus ? -90 - time * 90 : -180 - (1 - time) * 90
        let horizontalAngle: CGFloat = minus ? -time * 180 : -180 - (1 - time) * 180
        let lineLength: CGFloat = circle ? 20 : 40
        let pointPosition: CGFloat = lineLength / 2.0
        let negativePointPosition: CGFloat = -pointPosition

        context.scale(x: scale, y: scale)
        context.translate(x: 50, y: 50)

        // Circle Drawing
        if circle {

            let circlePath = UIBezierPath(ovalIn: CGRect(x: -20, y: -20, width: 40, height: 40))
            circlePath.lineWidth = scaledLineWidth
            circlePath.fill()
            circlePath.stroke()

        }

        // Vertical line Drawing
        context.saveGState()
        context.rotate(byAngle: -horizontalAngle * CGFloat(M_PI) / 180)

        let verticalLinePath = UIBezierPath(style: self)
        verticalLinePath.move(to: CGPoint(x: pointPosition, y: 0))
        verticalLinePath.addLine(to: CGPoint(x: negativePointPosition, y: 0))

        verticalLinePath.stroke()

        context.restoreGState()


        // Horizontal line Drawing
        context.saveGState()
        context.rotate(byAngle: -verticalAngle * CGFloat.pi / 180)

        let horizontalLinePath = UIBezierPath(style: self)
        horizontalLinePath.move(to: CGPoint(x: pointPosition, y: 0))
        horizontalLinePath.addLine(to: CGPoint(x: negativePointPosition, y: 0))

        horizontalLinePath.stroke()

        context.restoreGState()

    }

}
