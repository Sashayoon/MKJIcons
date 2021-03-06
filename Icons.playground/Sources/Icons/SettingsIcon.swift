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

    @IBInspectable public var primaryColor: UIColor = UIColor.whiteColor() {
        didSet {
            layer.setNeedsDisplay()
        }
    }

    @IBInspectable public var secondaryColor: UIColor = UIColor.lightGrayColor() {
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

    override func draw(time: CGFloat = 0) {

        // General Declarations
        let context = UIGraphicsGetCurrentContext()

        let strokeColor = UIColor(between: primaryColor, and: secondaryColor, using: colorMode, ratio: time)
        strokeColor.setStroke()
        let fillColor = strokeColor.colorWithAlphaComponent(fillAlpha)
        fillColor.setFill()

        CGContextScaleCTM(context, scale, scale)

        // Slider 1 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 50, 50)
        CGContextRotateCTM(context, -180 * CGFloat(M_PI) / 180)

        let slider1Rect = CGRect(x: -10, y: -25, width: 20, height: 50)
        CGContextSaveGState(context)
        UIRectClip(slider1Rect)
        CGContextTranslateCTM(context, slider1Rect.origin.x, slider1Rect.origin.y)

        drawSlider(time: time)
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)


        // Slider 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 65, 50)

        let slider2Rect = CGRect(x: -10, y: -25, width: 20, height: 50)
        CGContextSaveGState(context)
        UIRectClip(slider2Rect)
        CGContextTranslateCTM(context, slider2Rect.origin.x, slider2Rect.origin.y)

        drawSlider(time: time)
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)


        // Slider 3 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 35, 50)

        let slider3Rect = CGRect(x: -10, y: -25, width: 20, height: 50)
        CGContextSaveGState(context)
        UIRectClip(slider3Rect)
        CGContextTranslateCTM(context, slider3Rect.origin.x, slider3Rect.origin.y)

        drawSlider(time: time)
        CGContextRestoreGState(context)

        CGContextRestoreGState(context)
    }

    func drawSlider(time time: CGFloat = 1) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()

        // Variable Declarations
        let handlePosition: CGFloat = 12 + time * 26
        let halfHandleSize: CGFloat = handleSize / 2.0
        let negativeHalfHandleSize: CGFloat = -halfHandleSize
        let longLineLength: CGFloat = -halfHandleSize + time * 26
        let shortLineLength: CGFloat = -halfHandleSize + (1 - time) * 26
        let cornerRadius: CGFloat = roundedHandle ? halfHandleSize : 0

        // Handle Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 10, handlePosition)

        let handlePath = UIBezierPath(roundedRect: CGRect(x: negativeHalfHandleSize, y: negativeHalfHandleSize, width: handleSize, height: handleSize), cornerRadius: cornerRadius)

        handlePath.lineWidth = scaledLineWidth
        handlePath.lineCapStyle = lineCap
        handlePath.lineJoinStyle = lineJoin

        handlePath.fill()
        handlePath.stroke()

        CGContextRestoreGState(context)


        // Top line Drawing
        let topLinePath = UIBezierPath(style: self)
        topLinePath.moveToPoint(CGPoint(x: 10, y: 5))
        topLinePath.addLineToPoint(CGPoint(x: 10, y: (longLineLength + 12)))

        topLinePath.stroke()


        // Bottom line Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 10, 45)
        CGContextRotateCTM(context, -180 * CGFloat(M_PI) / 180)

        let bottomLine = UIBezierPath(style: self)
        bottomLine.moveToPoint(CGPoint(x: 0, y: 0))
        bottomLine.addLineToPoint(CGPoint(x: 0, y: (shortLineLength + 7)))

        bottomLine.stroke()

        CGContextRestoreGState(context)
    }

}
