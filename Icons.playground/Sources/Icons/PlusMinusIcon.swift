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
    
    @IBInspectable public var minus: Bool = false {
        willSet {
            
            if newValue != minus {
                animateTo(minus ? 0 : 1)
            }
        }
    }
    
    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        if enabled {
            minus = !minus
            internalValue = minus ? 1 : 0
        }
    }
    
    override func draw(time: CGFloat = 0) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        let color = UIColor(between: plusColor, and: minusColor, using: .HSB, ratio: time)
        color.setStroke()
        
        //// Variable Declarations
        let verticalAngle: CGFloat = (minus ? -90 - time * 90 : -180 - (1 - time) * 90)
        let horizontalAngle: CGFloat = (minus ? -time * 180 : -180 - (1 - time) * 180)
        let lineLength: CGFloat = (circle ? 20 : 40)
        let pointPosition: CGFloat = lineLength / 2.0
        let negativePointPosition: CGFloat = -pointPosition
        
        CGContextScaleCTM(context, scale, scale)
        
        //// Vertical line Drawing
        CGContextTranslateCTM(context, 50, 50)
        CGContextSaveGState(context)
        CGContextRotateCTM(context, -horizontalAngle * CGFloat(M_PI) / 180)
        
        let verticalLinePath = UIBezierPath()
        verticalLinePath.moveToPoint(CGPoint(x: pointPosition, y: 0))
        verticalLinePath.addLineToPoint(CGPoint(x: negativePointPosition, y: 0))

        verticalLinePath.lineWidth = scaledLineWidth
        verticalLinePath.lineJoinStyle  = lineJoin
        verticalLinePath.lineCapStyle  = lineCap

        verticalLinePath.stroke()
        
        CGContextRestoreGState(context)
        
        
        //// Horizontal line Drawing
        CGContextSaveGState(context)
        CGContextRotateCTM(context, -verticalAngle * CGFloat(M_PI) / 180)
        
        let horizontalLinePath = UIBezierPath()
        horizontalLinePath.moveToPoint(CGPoint(x: pointPosition, y: 0))
        horizontalLinePath.addLineToPoint(CGPoint(x: negativePointPosition, y: 0))
        
        horizontalLinePath.lineWidth = scaledLineWidth
        horizontalLinePath.lineJoinStyle  = lineJoin
        horizontalLinePath.lineCapStyle  = lineCap

        horizontalLinePath.stroke()
        
        CGContextRestoreGState(context)
        
        
        if (circle) {
            //// Circle Drawing
            
            let circlePath = UIBezierPath(ovalInRect: CGRect(x: -20, y: -20, width: 40, height: 40))
            circlePath.lineWidth = scaledLineWidth
            circlePath.stroke()

        }

    }
    
}
