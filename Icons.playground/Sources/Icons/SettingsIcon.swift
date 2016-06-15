//
//  Checkmark.swift
//
//
//  Created by Matěj Jirásek on 31/03/16.
//
//

import UIKit

@IBDesignable
public class SettingsIcon: AnimatedIcon {

    // MARK: - Inspectable properties

    @IBInspectable public var primaryColor: UIColor = UIColor.white() {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var secondaryColor: UIColor = UIColor.lightGray() {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var handleSize: CGFloat = 6 {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var roundedHandle: Bool = true {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var changed: Bool {
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
        let strokeColor = UIColor(between: primaryColor, and: secondaryColor, using: colorMode, ratio: time)
        strokeColor.setStroke()
        let fillColor = strokeColor.withAlphaComponent(fillAlpha)
        fillColor.setFill()

        context.scale(x: scale, y: scale)

        // Slider 1 Drawing
        context.saveGState()
        context.translate(x: 50, y: 50)
        context.rotate(byAngle: -180 * CGFloat.pi / 180)

        let slider1Rect = CGRect(x: -10, y: -25, width: 20, height: 50)
        context.saveGState()
        UIRectClip(slider1Rect)
        context.translate(x: slider1Rect.origin.x, y: slider1Rect.origin.y)

        drawSlider(in: context, at: time)
        context.restoreGState()

        context.restoreGState()


        // Slider 2 Drawing
        context.saveGState()
        context.translate(x: 65, y: 50)

        let slider2Rect = CGRect(x: -10, y: -25, width: 20, height: 50)
        context.saveGState()
        UIRectClip(slider2Rect)
        context.translate(x: slider2Rect.origin.x, y: slider2Rect.origin.y)

        drawSlider(in: context, at: time)
        context.restoreGState()

        context.restoreGState()


        // Slider 3 Drawing
        context.saveGState()
        context.translate(x: 35, y: 50)

        let slider3Rect = CGRect(x: -10, y: -25, width: 20, height: 50)
        context.saveGState()
        UIRectClip(slider3Rect)
        context.translate(x: slider3Rect.origin.x, y: slider3Rect.origin.y)

        drawSlider(in: context, at: time)
        context.restoreGState()

        context.restoreGState()
    }

    func drawSlider(in context: CGContext, at time: CGFloat) {

        // Variable Declarations
        let handlePosition: CGFloat = 12 + time * 26
        let halfHandleSize: CGFloat = handleSize / 2.0
        let negativeHalfHandleSize: CGFloat = -halfHandleSize
        let longLineLength: CGFloat = -halfHandleSize + time * 26
        let shortLineLength: CGFloat = -halfHandleSize + (1 - time) * 26
        let cornerRadius: CGFloat = roundedHandle ? halfHandleSize : 0

        // Handle Drawing
        context.saveGState()
        context.translate(x: 10, y: handlePosition)

        let handlePath = UIBezierPath(roundedRect: CGRect(x: negativeHalfHandleSize, y: negativeHalfHandleSize, width: handleSize, height: handleSize), cornerRadius: cornerRadius)

        handlePath.lineWidth = scaledLineWidth
        handlePath.lineCapStyle = lineCap
        handlePath.lineJoinStyle = lineJoin

        handlePath.fill()
        handlePath.stroke()

        context.restoreGState()


        // Top line Drawing
        let topLinePath = UIBezierPath(style: self)
        topLinePath.move(to: CGPoint(x: 10, y: 5))
        topLinePath.addLine(to: CGPoint(x: 10, y: (longLineLength + 12)))

        topLinePath.stroke()


        // Bottom line Drawing
        context.saveGState()
        context.translate(x: 10, y: 45)
        context.rotate(byAngle: -180 * CGFloat.pi / 180)

        let bottomLine = UIBezierPath(style: self)
        bottomLine.move(to: CGPoint(x: 0, y: 0))
        bottomLine.addLine(to: CGPoint(x: 0, y: (shortLineLength + 7)))

        bottomLine.stroke()

        context.restoreGState()
    }

}
